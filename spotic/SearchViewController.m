//
//  SearchViewController.m
//  spotic
//
//  Created by 下津 惇平 on 2015/09/29.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UITextField *searchField;
    UIButton *clearBtn;
    UILabel *clearLabel;
    UITapGestureRecognizer *tap;
    
    // セグメント
    UIImageView *locationIv;
    UIImageView *tagIv;
    UIImage *loc1;
    UIImage *loc2;
    UIImage *tag1;
    UIImage *tag2;
    UILabel *yokosen1;
    UILabel *yokosen2;
    
    UIButton *locBtn;
    UIButton *tagBtn;
    
    // メイン
    UIView *mainBackView;
    //仮
    UIView *redView;
    UIView *blueView;
    
    // スクロール
    UIScrollView *scrolView;
    UIView *mainScroll;
    
    UITableView *notificationTableView;
    UITableView *yoyakuTableView;
    
    NSMutableArray *locationData;
    NSMutableArray *tagData;
    
    // 通知
    
    // 予約
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *yoyakuDateLabel;
    UILabel *yoyakuNaiyouLabel;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 検索
        searchField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 260, 30)];
        searchField.borderStyle = UITextBorderStyleNone;
        searchField.backgroundColor = [UIColor whiteColor];
        searchField.textAlignment = NSTextAlignmentCenter;
        searchField.textColor = [UIColor blackColor];
        // delegate を設定
        searchField.delegate = self;
        [self.view addSubview:searchField];
    
        // placeholderカラー変更&文字
        UIColor *color = [UIColor lightGrayColor];
        NSString *placeholderText = [NSString stringWithFormat:@"What are you asking me?"];
        searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: color}];
    
    UIImage *searchImg = [UIImage imageNamed:@"search2.png"];
    UIImageView *searchIv = [[UIImageView alloc] initWithImage:searchImg];
    searchIv.frame = CGRectMake(12, 33, 20, 20);
    [self.view addSubview:searchIv];
    
    // バツボタン
    // 標準ボタン例文
    clearLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 28, 30, 30)];
    clearLabel.textColor = [UIColor lightGrayColor];
    clearLabel.text = @"×";
    clearLabel.font = [UIFont boldSystemFontOfSize:30];
    
    clearBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearBtn.frame = CGRectMake(235, 30, 30, 30);
    [clearBtn addTarget:self action:@selector(clear:)
       forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:clearLabel];
    [self.view addSubview:clearBtn];
    clearLabel.hidden = YES;
    clearBtn.hidden = YES;
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    // ビューにジェスチャーを追加
    [self.view addGestureRecognizer:tap];
    tap.enabled = NO;
    
    UILabel *backlbl = [[UILabel alloc] initWithFrame:CGRectMake(270, 30, 45, 30)];
    backlbl.text = @"Cancel";
    backlbl.font = [UIFont systemFontOfSize:13];
    backlbl.textColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    [self.view addSubview:backlbl];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(280, 30, 30, 30);
    [backBtn addTarget:self action:@selector(back:)
       forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backBtn];
    
    UILabel *yoko = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 320, 1)];
    yoko.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yoko];

// セグメント
    UIView *Segmentura = [[UIView alloc] initWithFrame:CGRectMake(0, 66, 320, 44)];
    Segmentura.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Segmentura];
    
    loc1 = [UIImage imageNamed:@"search_pin_active.png"];
    loc2 = [UIImage imageNamed:@"search_pin.png"];
    tag1 = [UIImage imageNamed:@"search_tag_active.png"];
    tag2 = [UIImage imageNamed:@"search_tag.png"];
    
    locationIv = [[UIImageView alloc] initWithFrame:CGRectMake(68, 5, 30, 30)];
    locationIv.image = loc1;
    
    tagIv = [[UIImageView alloc] initWithFrame:CGRectMake(228, 8, 25, 25)];
    tagIv.image = tag2;
    
    locBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    locBtn.frame = CGRectMake(0, 0, 160, 44);
    [locBtn addTarget:self action:@selector(location:)
         forControlEvents:UIControlEventTouchDown];
    
    tagBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tagBtn.frame = CGRectMake(160, 0, 160, 44);
    [tagBtn addTarget:self action:@selector(tag:)
        forControlEvents:UIControlEventTouchDown];
    locBtn.enabled = NO;
    
    
    [Segmentura addSubview:locationIv];
    [Segmentura addSubview:tagIv];
    [Segmentura addSubview:locBtn];
    [Segmentura addSubview:tagBtn];
    
    // メインビュー
    yokosen1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 108, 160, 1)];
    yokosen1.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    yokosen2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 108, 160, 1)];
    yokosen2.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    yokosen2.hidden = YES;
    mainBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 108, 320, 411)];
    mainBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainBackView];
    [self.view addSubview:yokosen1];
    [self.view addSubview:yokosen2];
    
    // スクロールビュー
    scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 411)];
    scrolView.bounces = NO;
    scrolView.delegate = self;
    mainScroll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 640, 411)];
    [scrolView addSubview:mainScroll];
    scrolView.contentSize = mainScroll.bounds.size;
    [mainBackView addSubview:scrolView];
    
    // テーブルビュー
    yoyakuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 411) style:UITableViewStylePlain];
    yoyakuTableView.delegate = self;
    yoyakuTableView.dataSource = self;
    yoyakuTableView.tag = 1;
    locationData = [NSMutableArray arrayWithObjects:@"United State", @"London", @"Fukuoka", nil];
    
    notificationTableView = [[UITableView alloc]initWithFrame:CGRectMake(320, 0, 320, 411) style:UITableViewStylePlain];
    notificationTableView.delegate = self;
    notificationTableView.dataSource = self;
    notificationTableView.tag = 2;
    tagData = [NSMutableArray arrayWithObjects:@"Park", @"Seaside", @"Building", nil];
    [mainScroll addSubview:yoyakuTableView];
    [mainScroll addSubview:notificationTableView];
    
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

-(void)location:(UIButton*)button{
    locationIv.image = loc1;
    tagIv.image = tag2;
    
    locBtn.enabled = NO;
    tagBtn.enabled = YES;
    yokosen1.hidden = NO;
    yokosen2.hidden = YES;

    [UIView animateWithDuration:0.5 animations:^{
        scrolView.contentOffset = CGPointMake(0, 0);
    }];
}

-(void)tag:(UIButton*)button{
    locationIv.image = loc2;
    tagIv.image = tag1;
    
    locBtn.enabled = YES;
    tagBtn.enabled = NO;
    yokosen1.hidden = YES;
    yokosen2.hidden = NO;

        [UIView animateWithDuration:0.5 animations:^{
            scrolView.contentOffset = CGPointMake(320, 0);
        }];
}

-(void)scrollViewDidScroll:
(UIScrollView *)scrollView
{
    if (scrolView.contentOffset.x == 0)
    {
        locationIv.image = loc1;
        tagIv.image = tag2;
        locBtn.enabled = NO;
        tagBtn.enabled = YES;
        yokosen1.hidden = NO;
        yokosen2.hidden = YES;
    }
    else {
        
        locationIv.image = loc2;
        tagIv.image = tag1;
        
        locBtn.enabled = YES;
        tagBtn.enabled = NO;
        yokosen1.hidden = YES;
        yokosen2.hidden = NO;

    }
}


// テーブルビューデリゲート
// セクションの個数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 行の個数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (notificationTableView) {
        return [locationData count];
    } else if (yoyakuTableView) {
        return [tagData count];
    }
    return 1;
}

// セルの中身
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "cell"というkeyでcellデータを取得
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // cellデータが無い場合、UITableViewCellを生成して、"cell"というkeyでキャッシュする
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    if (tableView.tag == 1)
    {
        cell.textLabel.text = [locationData objectAtIndex:indexPath.row];
    }
    else if (tableView.tag == 2)
    {
        cell.textLabel.text = [tagData objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// セルがタップされた時のイベント
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cellがタップされた際の処理
    if (tableView.tag == 1)
    {
        
    }
    else if (tableView.tag == 2)
    {
        
    }
}

// 各行の高さを決めるメソッド
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

// テキストフィールドを編集する直前に呼び出される
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    tap.enabled = YES;
    clearBtn.hidden = NO;
    clearLabel.hidden = NO;
    return YES;
}
// テキストフィールドの編集が終了する直前に呼び出される
-(BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
    return YES;
}

// テキストフィールドを編集する直後に呼び出される
-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    
}

// テキストフィールドの編集が終了する直後に呼び出される
-(void)textFieldDidEndEditing:(UITextField*)textField
{
    
}

// Returnボタンがタップされた時に呼ばれる
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    
    if ([textField.text isEqualToString:@""]) {
        clearBtn.hidden = YES;
        clearLabel.hidden = YES;
    }
    else {
        clearBtn.hidden = NO;
        clearLabel.hidden = NO;
        //[self search];
    }
    
    tap.enabled = NO;
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    clearBtn.hidden = NO;
    clearLabel.hidden = NO;
    return YES;
}

// バツボタン
-(void)clear:(UIButton*)button{
    clearBtn.hidden = YES;
    clearLabel.hidden = YES;
    searchField.text = @"";
}

/**
 * ビューがタップされたとき
 */
- (void)tapped:(UITapGestureRecognizer *)sender
{
    tap.enabled = NO;
    [searchField resignFirstResponder];
}
//
//-(void)search
//{
//    // ローカル検索
//    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
//    request.naturalLanguageQuery = searchField.text;
//    request.region = mapView.region;
//
//    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
//
//    [search startWithCompletionHandler: ^(MKLocalSearchResponse *response, NSError *error)
//     {
//         for (MKMapItem *item in response.mapItems)
//         {
//             MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//             point.coordinate = item.placemark.coordinate;
//             point.title = item.placemark.name;
//             point.subtitle = item.placemark.title;
//
//             [mapView addAnnotation:point];
//         }
//
//         [mapView showAnnotations:[mapView annotations] animated:YES];
//     }];
//}

-(void)back:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
