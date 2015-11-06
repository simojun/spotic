//
//  SettingViewController.m
//  spotic
//
//  Created by 下津 惇平 on 2015/08/15.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDetailViewController.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>
{
    // テーブルビュー
    UITableView *settingTable;
    NSArray *sectionList;
    NSDictionary *dataSource;
    
    // 画像
    UIImage *img1;
    UIImage *img2;
    UIImage *img3;
    UIImage *img4;
    UIImage *img5;
    UIImage *img6;
    UIImage *img7;
    UIImage *img8;
    
    UIImageView *iv1;
    UIImageView *iv2;
    UIImageView *iv3;
    UIImageView *iv4;
    UIImageView *iv5;
    UIImageView *iv6;
    UIImageView *iv7;
    UIImageView *iv8;
    
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *lbl3;
    UILabel *lbl4;
    UILabel *lbl5;
    UILabel *lbl6;
    UILabel *lbl7;
    UILabel *lbl8;
    
    long cellNumber;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIView *statusHaikei = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusHaikei.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    [self.view addSubview:statusHaikei];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    label.text = @"Settings";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    [self.view addSubview:label];
    
    UILabel *modoru = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 40, 40)];
    modoru.text = @"×";
    modoru.textColor = [UIColor whiteColor];
    modoru.font = [UIFont boldSystemFontOfSize:35];
    [self.view addSubview:modoru];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 20, 40, 40);
    [btn addTarget:self action:@selector(back:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    UILabel *feed = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 35)];
    feed.text = @"Please give us feedbacks";
    feed.textAlignment = NSTextAlignmentCenter;
    feed.textColor = [UIColor whiteColor];
    feed.font = [UIFont systemFontOfSize:13];
    feed.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    [[feed layer] setCornerRadius:10.0];
    [feed setClipsToBounds:YES];
    [self.view addSubview:feed];
    
    // テーブルビュー
    settingTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 119, 320, 441) style:UITableViewStylePlain];
    settingTable.delegate = self;
    settingTable.dataSource = self;
    settingTable.bounces = NO;
    [self.view addSubview:settingTable];
    // セクション名を設定する
    sectionList =  [NSArray arrayWithObjects:@"Account", @"About", @"　", nil];
    
    // セルの項目を作成する
    NSArray *peple = [NSArray arrayWithObjects:@"Change Email address", @"Change password", @"Edit profile", nil];
    NSArray *dogs = [NSArray arrayWithObjects:@"Privacy Policy", @"Terms", @"Company", nil];
    NSArray *others = [NSArray arrayWithObjects:@"Logout",@"Delete account", nil];
    
    // セルの項目をまとめる
    NSArray *datas = [NSArray arrayWithObjects:peple, dogs, others, nil];
    
    dataSource = [NSDictionary dictionaryWithObjects:datas forKeys:sectionList];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)back:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * テーブル全体のセクションの数を返す
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionList count];
}

/**
 * 指定されたセクションのセクション名を返す
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionList objectAtIndex:section];
}

/**
 * 指定されたセクションの項目数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionName = [sectionList objectAtIndex:section];
    return [[dataSource objectForKey:sectionName ]count];
}

/**
 * 指定された箇所のセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セクション名を取得する
    NSString *sectionName = [sectionList objectAtIndex:indexPath.section];
    
    // セクション名をキーにしてそのセクションの項目をすべて取得
    NSArray *items = [dataSource objectForKey:sectionName];
    
    // セルにテキストを設定
//    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    img1 = [UIImage imageNamed:@"mail1.png"];
    iv1 = [[UIImageView alloc] initWithImage:img1];
    iv1.frame = CGRectMake(10, 12, 20, 20);
    
    lbl1 = [[UILabel alloc] init];
    lbl1.frame = CGRectMake(40, 0, 200, 44);
    lbl1.text = @"Change Email address";
    
    img2 = [UIImage imageNamed:@"password1.png"];
    iv2 = [[UIImageView alloc] initWithImage:img2];
    iv2.frame = CGRectMake(10, 12, 20, 20);
    
    lbl2 = [[UILabel alloc] init];
    lbl2.frame = CGRectMake(40, 0, 200, 44);
    lbl2.text = @"Change password";
    
    img3 = [UIImage imageNamed:@"profile1.png"];
    iv3 = [[UIImageView alloc] initWithImage:img3];
    iv3.frame = CGRectMake(10, 12, 20, 20);
    
    lbl3 = [[UILabel alloc] init];
    lbl3.frame = CGRectMake(40, 0, 200, 44);
    lbl3.text = @"Edit profile";
    
    img4 = [UIImage imageNamed:@"privacy1.png"];
    iv4 = [[UIImageView alloc] initWithImage:img4];
    iv4.frame = CGRectMake(10, 12, 20, 20);
    
    lbl4 = [[UILabel alloc] init];
    lbl4.frame = CGRectMake(40, 0, 200, 44);
    lbl4.text = @"Privacy Policy";
    
    img5 = [UIImage imageNamed:@"terms1.png"];
    iv5 = [[UIImageView alloc] initWithImage:img5];
    iv5.frame = CGRectMake(10, 12, 20, 20);
    
    lbl5 = [[UILabel alloc] init];
    lbl5.frame = CGRectMake(40, 0, 200, 44);
    lbl5.text = @"Terms";
    
    img6 = [UIImage imageNamed:@"company1.png"];
    iv6 = [[UIImageView alloc] initWithImage:img6];
    iv6.frame = CGRectMake(10, 12, 20, 20);
    
    lbl6 = [[UILabel alloc] init];
    lbl6.frame = CGRectMake(40, 0, 200, 44);
    lbl6.text = @"Company";
    
    img7 = [UIImage imageNamed:@"logout1.png"];
    iv7 = [[UIImageView alloc] initWithImage:img7];
    iv7.frame = CGRectMake(10, 12, 20, 20);
    
    lbl7 = [[UILabel alloc] init];
    lbl7.frame = CGRectMake(40, 0, 200, 44);
    lbl7.text = @"Logout";
    
    img8 = [UIImage imageNamed:@"delete1.png"];
    iv8 = [[UIImageView alloc] initWithImage:img8];
    iv8.frame = CGRectMake(10, 12, 20, 20);
    
    lbl8 = [[UILabel alloc] init];
    lbl8.frame = CGRectMake(40, 0, 200, 44);
    lbl8.text = @"Delete account";
    
    if (indexPath.section == 0)
    {
    if (indexPath.row == 0) {
        [cell addSubview:lbl1];
        [cell addSubview:iv1];
    }
    if (indexPath.row == 1) {
        [cell addSubview:lbl2];
        [cell addSubview:iv2];
    }
    if (indexPath.row == 2) {
        [cell addSubview:lbl3];
        [cell addSubview:iv3];
    }
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            [cell addSubview:lbl4];
            [cell addSubview:iv4];
        }
        if (indexPath.row == 1) {
            [cell addSubview:lbl5];
            [cell addSubview:iv5];
        }
        if (indexPath.row == 2) {
            [cell addSubview:lbl6];
            [cell addSubview:iv6];
        }
       
    }
    
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            [cell addSubview:lbl7];
            [cell addSubview:iv7];
        }
        if (indexPath.row == 1) {
            [cell addSubview:lbl8];
            [cell addSubview:iv8];
        }
    }
    
    return cell;
}

// セクションの高さ
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

/**
 * セルが選択されたとき
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellNumber = 1;
        }
        if (indexPath.row == 1) {
            cellNumber = 2;
        }
        if (indexPath.row == 2) {
            cellNumber = 3;
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            cellNumber = 4;
        }
        if (indexPath.row == 4) {
            cellNumber = 5;
        }
        if (indexPath.row == 5) {
            cellNumber = 6;
        }
        
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 6) {
            cellNumber = 7;
        }
        if (indexPath.row == 7) {
            cellNumber = 8;
        }
        
    }
    
    // セクション名を取得する
    NSString *sectionName = [sectionList objectAtIndex:indexPath.section];
    
    // セクション名をキーにしてそのセクションの項目をすべて取得
    NSArray *items = [dataSource objectForKey:sectionName];

    SettingDetailViewController *settingDVC = [[SettingDetailViewController alloc] init];
    settingDVC.titleStr = [items objectAtIndex:indexPath.row];
    settingDVC.cellNumber = cellNumber;
    [CATransaction begin];
    CGFloat duration = 0.5f;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11 :0.72 :0.02 :0.96]; // easing関数次第でかなり印象の違う効果が生まれる
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // ユーザーの操作を止める
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    [self presentViewController:settingDVC animated:NO completion: nil];
    [CATransaction commit];
    
}


@end
