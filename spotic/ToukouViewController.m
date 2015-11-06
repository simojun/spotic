//
//  ToukouViewController.m
//  spotic
//
//  Created by 下津 惇平 on 2015/07/26.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import "ToukouViewController.h"
#import <MapKit/MapKit.h>
#import <Social/Social.h>

@interface ToukouViewController () <UIScrollViewDelegate, UITextViewDelegate>
{
    UIView *scrollBackView;
    UIScrollView *myscrollView;
    MKMapView *mapView;
    
    // コメント
    UITextView *tv;
    UILabel *comment;
    // タグ
    UITextField *tf;
    
    // スイッチ切り替え
    int switchCount;
}

@end

@implementation ToukouViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 454)]; // 高さ固定なのは問題。
    scrollBackView.backgroundColor = [UIColor whiteColor];
    
    myscrollView = [[UIScrollView alloc] init];
    myscrollView.bounces = NO;
    myscrollView.backgroundColor = [UIColor whiteColor];
    myscrollView.frame = CGRectMake(0, 64, 320, 454);
    [myscrollView addSubview:scrollBackView];
    myscrollView.contentSize = scrollBackView.bounds.size;
    [self.view addSubview:myscrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *statusHaikei = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusHaikei.backgroundColor = [UIColor colorWithRed:0.2 green:0.22 blue:0.21 alpha:1];
    [self.view addSubview:statusHaikei];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, 320, 45)];
    label.text = @"Post";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.backgroundColor = [UIColor colorWithRed:0.2 green:0.22 blue:0.21 alpha:1];
    [self.view addSubview:label];
    
    UIImage *image = [UIImage imageNamed:@"revease.png"];
    UIImageView *modoruiv = [[UIImageView alloc] initWithImage:image];
    modoruiv.frame = CGRectMake(5, 30, 20, 20);
    [self.view addSubview:modoruiv];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 20, 40, 40);
    [btn addTarget:self action:@selector(back:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:_kakouImg];
    iv.frame = CGRectMake(10, 10, 60, 60);
    [scrollBackView addSubview:iv];
    
    if (_imageNumber == 1) {
        UIImage *srcImage = self.kakouImg;
        CGRect trimArea = CGRectMake(0, 0, 960, 960);
        CGImageRef srcImageRef = [srcImage CGImage];
        CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
        UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];
        
        iv.image = trimmedImage;
        //回転
        float radian = 90 * M_PI / 180; // 45°回転させたい場合
        iv.transform = CGAffineTransformMakeRotation(radian);
    }
    
    // コメント
    tv = [[UITextView alloc] initWithFrame:CGRectMake(80, 0, 240, 80)];
    tv.editable = YES;
    tv.delegate = self;
    [myscrollView addSubview:tv];
    
    comment = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 30)];
    comment.text = @"Comment...";
    comment.textColor = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
    [myscrollView addSubview:comment];
    
    // 画像とコメント・マップの境界線
    UILabel *yoko1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 1)];
    yoko1.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko1];
    
    // マップ
    mapView = [[MKMapView alloc] init];
    mapView.frame = 	CGRectMake(0,90,320,170);
    mapView.showsUserLocation = YES;
    [mapView setUserTrackingMode:MKUserTrackingModeFollow];
    MKCoordinateRegion cr = mapView.region;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mapView setRegion:cr animated:NO];
    [scrollBackView addSubview:mapView];
    
    UILabel *mapsetumeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 320, 20)];
    mapsetumeiLabel.text = @" Tap the map to drop a pin";
    mapsetumeiLabel.font = [UIFont systemFontOfSize:12];
    mapsetumeiLabel.textColor = [UIColor whiteColor];
    mapsetumeiLabel.backgroundColor = [UIColor colorWithRed:0.35 green:0.33 blue:0.34 alpha:1];
    mapsetumeiLabel.alpha = 0.9;
    [scrollBackView addSubview:mapsetumeiLabel];
    
    // マップとタグの境界線
    UILabel *yoko2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, 320, 1)];
    yoko2.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko2];
    
    UILabel *sharpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 275, 30, 30)];
    sharpLabel.text = @"#";
    sharpLabel.font = [UIFont systemFontOfSize:17];
    sharpLabel.textColor = [UIColor blackColor];
    sharpLabel.alpha = 0.9;
    [scrollBackView addSubview:sharpLabel];
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(40, 270, 280, 40)];
    tf.borderStyle = UITextBorderStyleNone;
    tf.textColor = [UIColor blackColor];
    tf.delegate = self;
    tf.placeholder = @"park, seaside, califolnia";
    tf.clearButtonMode = UITextFieldViewModeAlways;
    [scrollBackView addSubview:tf];
    
    UILabel *yoko3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, 320, 1)];
    yoko3.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko3];
    
    // facebookとか
    UILabel *tate3 = [[UILabel alloc] initWithFrame:CGRectMake(160, 324, 1, 40)];
    tate3.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:tate3];
    
    UILabel *yoko6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 324, 320, 1)];
    yoko6.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko6];
    
    UIImageView *fb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebook_active.png"]];
    fb.frame = CGRectMake(15, 334, 20, 20);
    [scrollBackView addSubview:fb];
    
    UILabel *fbLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 324, 100, 40)];
    fbLbl.text = @"Facebook";
    fbLbl.font = [UIFont systemFontOfSize:16];
    fbLbl.textAlignment = NSTextAlignmentCenter;
    fbLbl.textColor = [UIColor colorWithRed:0.2 green:0.32 blue:0.58 alpha:1];
    [scrollBackView addSubview:fbLbl];
    
    UIButton *fbBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fbBtn.frame = CGRectMake(0, 324, 160, 40);
    [fbBtn addTarget:self action:@selector(fb:) forControlEvents:UIControlEventTouchDown];
    [scrollBackView addSubview:fbBtn];
    
    UIImageView *tw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter_active.png"]];
    tw.frame = CGRectMake(175, 334, 25, 20);
    [scrollBackView addSubview:tw];
    
    UILabel *twLbl = [[UILabel alloc] initWithFrame:CGRectMake(190, 324, 100, 40)];
    twLbl.text = @"Twitter";
    twLbl.font = [UIFont systemFontOfSize:16];
    twLbl.textAlignment = NSTextAlignmentCenter;
    twLbl.textColor = [UIColor colorWithRed:0.17 green:0.63 blue:0.85 alpha:1];
    [scrollBackView addSubview:twLbl];
    
    UIButton *twBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twBtn.frame = CGRectMake(160, 324, 160, 40);
    [twBtn addTarget:self action:@selector(tw:) forControlEvents:UIControlEventTouchDown];
    [scrollBackView addSubview:twBtn];
    
    
    UILabel *yoko7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 364, 320, 1)];
    yoko7.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko7];
    
    
    // private spot
    UILabel *yoko9 = [[UILabel alloc] initWithFrame:CGRectMake(0, 379, 320, 1)];
    yoko9.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko9];
    
    UIImageView *kagi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kagi.png"]];
    kagi.frame = CGRectMake(15, 387, 15, 20);
    [scrollBackView addSubview:kagi];
    
    UILabel *prLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 379, 150, 40)];
    prLbl.text = @"Private Spot";
    prLbl.font = [UIFont systemFontOfSize:16];
    prLbl.textAlignment = NSTextAlignmentCenter;
    prLbl.textColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    [scrollBackView addSubview:prLbl];
    
    UISwitch *prSwitch = [[UISwitch alloc] init];
    prSwitch.frame = CGRectMake(250, 384, 40, 40);
    prSwitch.on = NO;
    [prSwitch addTarget:self action:@selector(prSwitch:) forControlEvents:UIControlEventValueChanged];
    [scrollBackView addSubview:prSwitch];
    
    UILabel *yoko10 = [[UILabel alloc] initWithFrame:CGRectMake(0, 419, 320, 1)];
    yoko10.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [scrollBackView addSubview:yoko10];
    
    
    UILabel *toukouLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 518, 320, 50)];
    toukouLabel.text = @"Add Spot";
    toukouLabel.textAlignment = NSTextAlignmentCenter;
    toukouLabel.textColor = [UIColor whiteColor];
    toukouLabel.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    [self.view addSubview:toukouLabel];
    
    
    
    // 投稿ボタン
    UIButton *toukouBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    toukouBtn.frame = CGRectMake(0, 518, 320, 50);
    [toukouBtn addTarget:self action:@selector(toukou:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toukouBtn];
    
    // タップにてテキストを閉じる
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myView_Tapped:)];
    // ビューにジェスチャーを追加
    [self.view addGestureRecognizer:tapGesture];
    
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
    [CATransaction begin];
    CGFloat duration = 0.5f;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11 :0.72 :0.02 :0.96];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // ユーザーの操作を止める
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    [CATransaction commit];
}

// SNS
-(void)fb:(UIButton*)button
{
    NSLog(@"fb");
    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString *text = [NSString stringWithFormat:@"%@", tv.text];
    [facebookPostVC setInitialText:text];
    [facebookPostVC addImage:_kakouImg];
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

-(void)tw:(UIButton*)button
{
    NSLog(@"tw");
    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *text = [NSString stringWithFormat:@"%@", tv.text];
    [twitterPostVC setInitialText:text];
    [twitterPostVC addImage:_kakouImg];
    [self presentViewController:twitterPostVC animated:YES completion:nil];
}

-(void)ins:(UIButton*)button
{
    NSLog(@"ins");
}

// Private  Switch
-(void)prSwitch:(UISwitch*)sw
{
    if (switchCount == 0) {
        NSLog(@"スイッチオン");
        switchCount = 1;
        return;
    }
    
    if (switchCount == 1) {
        NSLog(@"スイッチオフ");
        switchCount = 0;
        return;
    }
    
}


// 投稿
-(void)toukou:(UIButton*)button
{
    NSLog(@"投稿");
}

// タップ時の処理
- (void)myView_Tapped:(UITapGestureRecognizer *)sender
{
    [tf resignFirstResponder];
    [tv resignFirstResponder];
    [self hasText];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
        
    {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 284);
                         }];
    }
    
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)   // iPhone 3.5インチ(iPhone4,4s)
        
    {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 240);
                         }];
    }
    
    else if(screenSize.width == 375.0 && screenSize.height == 667.0)   // iPhone 4.7インチ(iPhone6)
        
    {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(187.5, 333.5);
                         }];
        
    }
    
    else if(screenSize.width == 414.0 && screenSize.height == 736.0)	// iPhone5.5インチ(iPhone6Plus)
        
    {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(207, 368);
                         }];
        
    }
}


// textField delegate

// テキストフィールドを編集する直前に呼び出される
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
        
    {
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 230);
                         }];
        
    }
    
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)   // iPhone 3.5インチ(iPhone4,4s)
        
    {
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 230);
                         }];
        
    }
    
    else if(screenSize.width == 375.0 && screenSize.height == 667.0)   // iPhone 4.7インチ(iPhone6)
        
    {
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(187.5, 300);
                         }];
        
    }
    
    else if(screenSize.width == 414.0 && screenSize.height == 736.0)	// iPhone5.5インチ(iPhone6Plus)
        
    {
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(207, 348);
                         }];
        
    }
    
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
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
        
    {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 284);
                         }];
    }
    
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)   // iPhone 3.5インチ(iPhone4,4s)
        
    {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 240);
                         }];
    }
    
    else if(screenSize.width == 375.0 && screenSize.height == 667.0)   // iPhone 4.7インチ(iPhone6)
        
    {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(187.5, 333.5);
                         }];
        
    }
    
    else if(screenSize.width == 414.0 && screenSize.height == 736.0)	// iPhone5.5インチ(iPhone6Plus)
    {
        NSLog(@"a");
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(207, 368);
                         }];
        
    }
    return YES;
}

// textView delegate
-(BOOL)textViewShouldBeginEditing:(UITextView*)textView
{
    comment.hidden = YES;
    return YES;
}

-(BOOL)hasText
{
    BOOL b = [tv hasText];
    if (b == YES) {
        return YES;
    }
    if (b == NO) {
        comment.hidden = NO;
    }
    return YES;
}
@end