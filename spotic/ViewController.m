//
//  ViewController.m
//  spotic
//
//  Created by 下津 惇平 on 2015/07/24.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "SearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SettingViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
{
    UIImage *home;
    UIImage *home2;
    UIImage *camera;
    UIImage *user;
    UIImage *user2;
    UIImageView *homeIv;
    UIImageView *cameraIv;
    UIImageView *userIv;
    long syokai;
    
    // ボタン
    UIButton *cameraBtn;
    UIButton *homeBtn;
    UIButton *userBtn;
    
    // 画面
    UIView *homeView;
    UIView *userView;
    
    // HOME画面内部
    MKMapView *homeMapView;
    UIView *alphaView;
    
    UIImageView *iv;
    UIButton *closeBtn;
    
    CLLocationManager *_manager;
    
    // USER画面内部
    NSString *name; //タイトル
    NSString *nameStr; // 名前
    NSString *addStr; // 住所
    NSString *discriptionStr; // 自己紹介
    NSString *LinkStr;  // リンク
    
    long spots;
    long favs;
    
    // ボタンIv
    UIImageView *mapIv;
    UIImageView *picIv;
    
    //Map
    UIView *userMapView;
    MKMapView *mv;
    
    //CV
    UIView *cvBackView;
    UIScrollView *cvScrollView;
    UIImageView *cellImage;
}
@property (nonatomic, strong) NSArray *photos;
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    //    syokai = [[NSUserDefaults standardUserDefaults] integerForKey:@"SYOKAI"];
    //    NSLog(@"%ld", syokai);
    //    if (syokai == 0) {
    //     [self moveToLoginView];
    //    } else {
    //        return;
    //    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *aaa = [[UIView alloc] initWithFrame:CGRectMake(0, 518, 320, 50)];
    aaa.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aaa];
    UILabel *yoko = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 320, 1)];
    yoko.backgroundColor = [UIColor lightGrayColor];
    [aaa addSubview:yoko];
    
// 画面
    homeView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 498)];
    [self.view addSubview:homeView];
    
    userView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 498)];
    [self.view addSubview:userView];
    
    userView.hidden = YES;
    
// 画面内部
    
    // HOME------------------------------------------------------------------------------------------
    
    // 位置情報取得
    _manager = [CLLocationManager new];
    [_manager setDelegate:self];
    // iOS8未満は、このメソッドは無いので
    if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        // GPSを取得する旨の認証をリクエストする
        // 「このアプリ使っていない時も取得するけどいいでしょ？」
        [_manager requestAlwaysAuthorization];
    }
    [_manager startUpdatingLocation];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    
    UIImageView *titleIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    titleIv.frame = CGRectMake(0, 0, 320, 44);
    [homeView addSubview:titleIv];
    
    
    // マップ
    homeMapView = [[MKMapView alloc] init];
    homeMapView.frame = CGRectMake(0,44,320,455);
    
    // マップにユーザの現在地を表示
    homeMapView.showsUserLocation = YES;
    // マップの中心地がユーザの現在地を追従するように設定
    [homeMapView setUserTrackingMode:MKUserTrackingModeFollow];
    
    // 縮尺を指定
    MKCoordinateRegion cr = homeMapView.region;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [homeMapView setRegion:cr animated:NO];
    
    // addSubview
    [homeView addSubview:homeMapView];
    
    // 現在地ボタン
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    locationBtn.frame = CGRectMake(265,445,50,50);
    [locationBtn addTarget:self action:@selector(currentLocation:) forControlEvents:UIControlEventTouchDown];
    UIImage *loc = [UIImage imageNamed:@"yourlocation.png"];
    UIImageView *locIv = [[UIImageView alloc] initWithImage:loc];
    locIv.frame = CGRectMake(275,455,35,35);
    [homeView addSubview:locIv];
    [homeView addSubview:locationBtn];
    
    UIImage *searchImg = [UIImage imageNamed:@"search.png"];
    UIImageView *searchIv = [[UIImageView alloc] initWithImage:searchImg];
    searchIv.frame = CGRectMake(290, 10, 20, 20);
    [homeView addSubview:searchIv];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.frame = CGRectMake(280, 0, 40, 40);
    [searchBtn addTarget:self action:@selector(search:)
        forControlEvents:UIControlEventTouchDown];
    [homeView addSubview:searchBtn];
    
    
    
    // 成功例
    NSString *str1 = [NSString stringWithFormat:@"TEST"];
    NSString *str2 = [NSString stringWithFormat:@"test"];
    
    // ②CustomAnnotationクラスの初期化(インスタンス化)
    CustomAnnotation *ann1 = [[CustomAnnotation alloc] initWithLocationCoordinate:CLLocationCoordinate2DMake(35.67966, 139.7681) title:str1 subtitle:str2];
    [homeMapView setDelegate:self];
    // ③ついでにユーザの現在地を表示するように設定
    [homeMapView setShowsUserLocation:YES];
    // ④annotationをマップに追加
    [homeMapView addAnnotation:ann1];
    
    //サンプル(仮)
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    detailBtn.frame = CGRectMake(0,0,44,44);
    detailBtn.backgroundColor = [UIColor clearColor];
    [detailBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchDown];
    [homeView addSubview:detailBtn];
    
    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 648)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.5;
    [self.view addSubview:alphaView];
    
    iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"スクリーンショット 2015-09-29 20.33.01.png"]];
    iv.frame = CGRectMake(20, 120, 280, 320);
    [self.view addSubview:iv];
    
    alphaView.hidden = YES;
    iv.hidden = YES;
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.frame = CGRectMake(25,130,30,30);
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:closeBtn];
    closeBtn.hidden = YES;
    
    // USER -------------------------------------------------------------------------------------------
    
    name = @"YOSHITAKAGI";
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    titleLabel.text = [NSString stringWithFormat:@"%@", name];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [userView addSubview:titleLabel];
    
    UIImageView *settingIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting.png"]];
    settingIv.frame = CGRectMake(280, 10, 25, 25);
    [userView addSubview:settingIv];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    settingBtn.frame = CGRectMake(280, 0, 44, 44);
    [settingBtn addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchDown];
    [userView addSubview:settingBtn];
    
    // 上画面
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 210)];
    backView1.backgroundColor = [UIColor whiteColor];
    [userView addSubview:backView1];
    
    UIImage *profileImg = [UIImage imageNamed:@"1606454_756278167760378_6600729741222379102_o.jpg"];
    UIImageView *profileIv = [[UIImageView alloc] initWithImage:profileImg];
    profileIv.frame = CGRectMake(10, 10, 80, 80);
    CALayer *layer = [profileIv layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:40.0f];
    [backView1 addSubview:profileIv];
    
    // 名前
    nameStr = @"Yoshitaka Takagi";
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 0, 0)];
    nameLabel.text = [NSString stringWithFormat:@"%@", nameStr];
    nameLabel.font = [UIFont systemFontOfSize:22];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [nameLabel sizeToFit];
    [backView1 addSubview:nameLabel];
    // 住所
    addStr = @"Fukuoka,JPN";
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 0, 0)];
    addLabel.text = [NSString stringWithFormat:@"%@", addStr];
    [addLabel sizeToFit];
    [backView1 addSubview:addLabel];
    
    // 投稿文
    discriptionStr = [NSString stringWithFormat:@"Twitter:@yositakagi_FLAP Inc. \nCEO&Founder.I take pictures all over the world.\n From Fukuoka, Japan. Please follow me :)"];
    UITextView *discriptionTV = [[UITextView alloc] init];
    discriptionTV.text = discriptionStr;
    discriptionTV.editable = NO;
    discriptionTV.frame = CGRectMake(10, 90, 300, 60);
    [backView1 addSubview:discriptionTV];
    
    //リンク
    LinkStr = @"yositakatakagi.com";
    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 0, 0)];
    linkLabel.text = [NSString stringWithFormat:@"%@", LinkStr];
    linkLabel.font = [UIFont systemFontOfSize:13];
    linkLabel.textColor = [UIColor colorWithRed:0.02 green:0.69 blue:0.78 alpha:1];
    [linkLabel sizeToFit];
    [backView1 addSubview:linkLabel];
    
    // スポット数、ファボ数
    spots = 200;
    favs = 35;
    UILabel *spotsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 130, 30)];
    spotsLabel.textAlignment = NSTextAlignmentRight;
    spotsLabel.textColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    spotsLabel.text = [NSString stringWithFormat:@"%ld", spots];
    spotsLabel.font = [UIFont systemFontOfSize:28];
    [backView1 addSubview:spotsLabel];
    
    UILabel *favsLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 160, 130, 30)];
    favsLabel.textAlignment = NSTextAlignmentRight;
    favsLabel.textColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    favsLabel.text = [NSString stringWithFormat:@"%ld", favs];
    favsLabel.font = [UIFont systemFontOfSize:28];
    [backView1 addSubview:favsLabel];
    
    UILabel *spoLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 185, 50, 20)];
    spoLab.text = @"spots";
    spoLab.font = [UIFont systemFontOfSize:11];
    [backView1 addSubview:spoLab];
    UILabel *favLab = [[UILabel alloc] initWithFrame:CGRectMake(210, 185, 50, 20)];
    favLab.text = @"favs";
    favLab.font = [UIFont systemFontOfSize:11];
    [backView1 addSubview:favLab];
    
    UILabel *yokosen = [[UILabel alloc] initWithFrame:CGRectMake(0, 209, 320, 1)];
    yokosen.backgroundColor = [UIColor lightGrayColor];
    [backView1 addSubview:yokosen];
    
    // 真ん中Btn
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 254, 320, 44)];
    backView2.backgroundColor = [UIColor whiteColor];
    [userView addSubview:backView2];
    
    mapIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_active.png"]];
    mapIv.frame = CGRectMake(90, 9, 25, 25);
    [backView2 addSubview:mapIv];
    
    picIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list.png"]];
    picIv.frame = CGRectMake(210, 9, 25, 25);
    [backView2 addSubview:picIv];
    
    UILabel *yokosen2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
    yokosen2.backgroundColor = [UIColor lightGrayColor];
    [backView2 addSubview:yokosen2];
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mapBtn.frame = CGRectMake(80, 0, 44, 44);
    [mapBtn addTarget:self action:@selector(map:) forControlEvents:UIControlEventTouchDown];
    [backView2 addSubview:mapBtn];
    
    UIButton *cvBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cvBtn.frame = CGRectMake(200, 0, 44, 44);
    [cvBtn addTarget:self action:@selector(cv:) forControlEvents:UIControlEventTouchDown];
    [backView2 addSubview:cvBtn];
    
    
    userMapView = [[UIView alloc] initWithFrame:CGRectMake(0, 298, 320, 201)];
    userMapView.backgroundColor = [UIColor blueColor];
    [userView addSubview:userMapView];
    
    // Map
    mv = [[MKMapView alloc] init];
    mv.frame = 	CGRectMake(0,0,320,201);
    mv.showsUserLocation = YES;
    [mv setUserTrackingMode:MKUserTrackingModeFollow];
    MKCoordinateRegion cr2 = mv.region;
    cr2.span.latitudeDelta = 10.0;
    cr2.span.longitudeDelta = 10.0;
    [mv setRegion:cr2 animated:NO];
    [userMapView addSubview:mv];
    
    //CV
    cvBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)]; // 高さ固定なのは問題。
    cvBackView.backgroundColor = [UIColor whiteColor];
    
    cvScrollView = [[UIScrollView alloc] init];
    cvScrollView.bounces = NO;
    cvScrollView.backgroundColor = [UIColor whiteColor];
    cvScrollView.frame = CGRectMake(0, 298, 320, 201);
    [cvScrollView addSubview:cvBackView];
    cvScrollView.contentSize = cvBackView.bounds.size;
    [userView addSubview:cvScrollView];
    [self loadDemoData];
    [self createCollectionView];
    cvScrollView.hidden = YES;
    
// ホーム
    home = [UIImage imageNamed:@"home_active.png"];
    home2 = [UIImage imageNamed:@"home.png"];
    homeIv = [[UIImageView alloc] initWithImage:home];
    homeIv.frame = CGRectMake(45, 527, 30, 30);
    [self.view addSubview:homeIv];
    
    homeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    homeBtn.frame = CGRectMake(30, 510, 60, 60);
    [homeBtn addTarget:self action:@selector(home:)
        forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:homeBtn];
    
// カメラ
    camera = [UIImage imageNamed:@"camera.png"];
    cameraIv = [[UIImageView alloc] initWithImage:camera];
    cameraIv.frame = CGRectMake(145, 530, 30, 25);
    [self.view addSubview:cameraIv];
    
    cameraBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cameraBtn.frame = CGRectMake(130, 510, 60, 60);
    [cameraBtn addTarget:self action:@selector(camera:)
        forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:cameraBtn];
    
// ユーザー
    user = [UIImage imageNamed:@"mypage_active.png"];
    user2 = [UIImage imageNamed:@"mypage.png"];
    userIv = [[UIImageView alloc] initWithImage:user2];
    userIv.frame = CGRectMake(245, 527, 30, 30);
    [self.view addSubview:userIv];
    
    userBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userBtn.frame = CGRectMake(220, 510, 60, 60);
    [userBtn addTarget:self action:@selector(user:)
        forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:userBtn];

        
    //４インチの画面サイズ判定(iPhone5.5s)
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
        
    {
        
        self.view.transform = CGAffineTransformMakeScale(1, 1);
        
    }
    
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)   // iPhone 3.5インチ(iPhone4,4s)
        
    {
        
        self.view.transform = CGAffineTransformMakeScale(1, 0.84507042);
        
    }
    
    else if(screenSize.width == 375.0 && screenSize.height == 667.0)   // iPhone 4.7インチ(iPhone6)
        
    {
        
        self.view.transform = CGAffineTransformMakeScale(1.171875, 1.174295);
        
    }
    
    else if(screenSize.width == 414.0 && screenSize.height == 736.0)	// iPhone5.5インチ(iPhone6Plus)
        
    {
        
        self.view.transform = CGAffineTransformMakeScale(1.29375, 1.29577465);
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)home:(UIButton*)button{
    homeIv.image = home;
    userIv.image = user2;
    homeView.hidden = NO;
    userView.hidden = YES;
}

-(void)user:(UIButton*)button{
    homeIv.image = home2;
    userIv.image = user;
    homeView.hidden = YES;
    userView.hidden = NO;
}

-(void)camera:(UIButton*)button{
    CameraViewController *cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CAMERA"];
    cameraViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:cameraViewController animated:YES completion:nil];
    
    
}

// USER ---------------------------------------------------------------------------------------

// ViewController.mファイル内にviewForAnnotation関数を記述
-(MKAnnotationView*)mapView:(MKMapView*)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // ①ユーザの現在地はデフォルトの青丸マークを使いたいのでreturn: nil
    if (annotation == homeMapView.userLocation) {
        return nil;
    } else {
        MKAnnotationView *annotationView;
        // ②再利用可能なannotationがあるかどうかを判断するための識別子を定義
        NSString* identifier = @"Pin";
        // ③dequeueReusableAnnotationViewWithIdentifierで"Pin"という識別子の使いまわせるannotationがあるかチェック
        annotationView = (MKAnnotationView*)[homeMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        // ④使い回しができるannotationがない場合、annotationの初期化
        if(annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        // ⑤好きな画像をannotationとして設定
        annotationView.image = [UIImage imageNamed:@"search_pin_active.png"];
        annotationView.canShowCallout = YES;
        annotationView.annotation = annotation;
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)_mapView didAddAnnotationViews:(NSArray *)views {
    CGRect visibleRect = [homeMapView annotationVisibleRect];
    for (MKAnnotationView *view in views) {
        CGRect endFrame = view.frame;
        CGRect startFrame = endFrame;
        startFrame.origin.y = visibleRect.origin.y - startFrame.size.height;
        view.frame = startFrame;
        [UIView beginAnimations:@"drop" context:NULL];
        view.frame = endFrame;
        [UIView commitAnimations];
    }
}

// 現在地
-(void)currentLocation:(UIButton*)button
{
    [homeMapView setUserTrackingMode:MKUserTrackingModeFollow];
}

-(void)search:(UIButton*)button
{
    SearchViewController *secondVC = [[SearchViewController alloc] init];
    [self presentViewController: secondVC animated:YES completion: nil];
}

- (void)detail:(UIButton*)button
{
    alphaView.hidden = NO;
    iv.hidden = NO;
    closeBtn.hidden = NO;
}

-(void)close:(UIButton*)button
{
    alphaView.hidden = YES;
    iv.hidden = YES;
    closeBtn.hidden = YES;
}

// USER -----------------------------------------------------------------------------

- (void)loadDemoData
{
    NSMutableArray *samplePhotos = [NSMutableArray array];
    for (int i = 1; i <= 9; i++) {
        NSString *filename = [NSString stringWithFormat:@"p%d.jpg", i];
        [samplePhotos addObject:[UIImage imageNamed:filename]];
    }
    self.photos = @[samplePhotos];
    self.cvData = samplePhotos;
}

// ボタン

-(void)setting:(UIButton*)button
{
    SettingViewController *controller = [[SettingViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)map:(UIButton*)button
{
    cvScrollView.hidden = YES;
    userMapView.hidden = NO;
    mapIv.image = [UIImage imageNamed:@"map_active.png"];
    picIv.image = [UIImage imageNamed:@"list.png"];
}

-(void)cv:(UIButton*)button
{
    cvScrollView.hidden = NO;
    userMapView.hidden = YES;
    mapIv.image = [UIImage imageNamed:@"map.png"];
    picIv.image = [UIImage imageNamed:@"list_active.png"];
}

// CollectionView
-(void)createCollectionView
{
    /*UICollectionViewのコンテンツの設定 UICollectionViewFlowLayout*/
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(105, 105);  //表示するアイテムのサイズ
    self.flowLayout.minimumLineSpacing = 1.0f;  //セクションとアイテムの間隔
    self.flowLayout.minimumInteritemSpacing = 1.0f;  //アイテム同士の間隔
    
    /*UICollectionViewの土台を作成*/
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];  //collectionViewにcellのクラスを登録。セルの表示に使う
    
    self.collectionView.frame = CGRectMake(0, 0, 320, 508);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = YES;
    [cvScrollView addSubview:self.collectionView];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

//コレクションビュープロトコル

/*セクションの数*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/*セクションに応じたセルの数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cvData.count;
}

/*セルの内容を返す*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    int a=0;
    
    for (int i = 0; i < [self.cvData count]; i++) {
        cellImage = [[UIImageView alloc] initWithImage:_cvData[i]];
        
        if (indexPath.row == a)
        {
            cell.backgroundView = cellImage;
        }
        a++;
    }
    return cell;
}

//---------------------

-(IBAction)goback:(UIStoryboardSegue *)segue { }

@end