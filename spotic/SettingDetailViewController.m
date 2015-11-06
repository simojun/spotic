//
//  SettingDetailViewController.m
//  spotic
//
//  Created by 下津 惇平 on 2015/10/05.
//  Copyright © 2015年 junP. All rights reserved.
//

#import "SettingDetailViewController.h"

@interface SettingDetailViewController () <UITextFieldDelegate, UITextViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIView *mainView;
    
    UITextField *addressTf;
    
    UITextField *passTf;
    UITextField *passkakuninTf;
    
    // Edit Profile
    UITextField *nameTf;
    UITextField *usernameTf;
    UITextField *websiteTf;
    UITextField *locationTf;
    UITextView *bioTV;
    UILabel *bioLabel;
    
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
    
    UILabel *countryLabel;
    UILabel *birthdayLabel;
    UILabel *sexLabel;
    UILabel *countryLabel2;
    UILabel *birthdayLabel2;
    UILabel *sexLabel2;
    UIButton *countryBtn;
    UIButton *birthdayBtn;
    UIButton *sexBtn;
    UIView *alphaView;
    UIView *pickerView;
    UIPickerView *countriyPiv;
    UIDatePicker *birthdayPicker;
    UIPickerView *sexPiv;
    UILabel *modoru;
    UIButton *modoruBtn;
    NSMutableArray *countryArray;
    NSMutableArray *sexArray;
}
@end

@implementation SettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"%@", self.titleStr];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    
    UIImage *image = [UIImage imageNamed:@"revease.png"];
    UIImageView *modoruiv = [[UIImageView alloc] initWithImage:image];
    modoruiv.frame = CGRectMake(5, 30, 20, 20);
    [self.view addSubview:modoruiv];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 20, 50, 50);
    [backBtn addTarget:self action:@selector(back:)
      forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backBtn];
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 504)];
    mainView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
    [self.view addSubview:mainView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    if (self.cellNumber == 1) {
        addressTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        addressTf.borderStyle = UITextBorderStyleRoundedRect;
        addressTf.clearButtonMode = UITextFieldViewModeAlways;
        addressTf.delegate = self;
        addressTf.placeholder = @"abcdefg@hi.jk";
        addressTf.keyboardType = UIKeyboardTypeASCIICapable;
        [mainView addSubview:addressTf];
    }
    if (self.cellNumber == 2) {
        passTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        passTf.borderStyle = UITextBorderStyleRoundedRect;
        passTf.clearButtonMode = UITextFieldViewModeAlways;
        passTf.delegate = self;
        passTf.placeholder = @"New password";
        passTf.keyboardType = UIKeyboardTypeASCIICapable;
        [mainView addSubview:passTf];
        
        passkakuninTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 120, 320, 50)];
        passkakuninTf.borderStyle = UITextBorderStyleRoundedRect;
        passkakuninTf.clearButtonMode = UITextFieldViewModeAlways;
        passkakuninTf.delegate = self;
        passkakuninTf.placeholder = @"Retype";
        passkakuninTf.keyboardType = UIKeyboardTypeASCIICapable;
        [mainView addSubview:passkakuninTf];
        [passTf setSecureTextEntry:YES];
        [passkakuninTf setSecureTextEntry:YES];
    }
    if (self.cellNumber == 3) {
        UILabel *yoko1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
        yoko1.backgroundColor = [UIColor colorWithRed:0.41 green:0.42 blue:0.44 alpha:1];
        [mainView addSubview:yoko1];
        UILabel *acc = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 30)];
        acc.text = @"ACCOUNT";
        acc.font = [UIFont boldSystemFontOfSize:14];
        acc.textColor = [UIColor colorWithRed:0.41 green:0.42 blue:0.44 alpha:1];;
        [mainView addSubview:acc];
        
        
        UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 270)];
        accountView.backgroundColor = [UIColor whiteColor];
        [mainView addSubview:accountView];
        
        img1 = [UIImage imageNamed:@"name1.png"];
        iv1 = [[UIImageView alloc] initWithImage:img1];
        iv1.frame = CGRectMake(90, 15, 20, 20);
        img2 = [UIImage imageNamed:@"username1.png"];
        iv2 = [[UIImageView alloc] initWithImage:img2];
        iv2.frame = CGRectMake(90, 60, 20, 20);
        img3 = [UIImage imageNamed:@"website1.png"];
        iv3 = [[UIImageView alloc] initWithImage:img3];
        iv3.frame = CGRectMake(20, 105, 20, 20);
        img4 = [UIImage imageNamed:@"location1.png"];
        iv4 = [[UIImageView alloc] initWithImage:img4];
        iv4.frame = CGRectMake(20, 150, 20, 20);
        img5 = [UIImage imageNamed:@"bio1.png"];
        iv5 = [[UIImageView alloc] initWithImage:img5];
        iv5.frame = CGRectMake(20, 195, 20, 20);
        img6 = [UIImage imageNamed:@"country1.png"];
        iv6 = [[UIImageView alloc] initWithImage:img6];
        iv6.frame = CGRectMake(20, 15, 20, 20);
        img7 = [UIImage imageNamed:@"birthday1.png"];
        iv7 = [[UIImageView alloc] initWithImage:img7];
        iv7.frame = CGRectMake(20, 60, 20, 20);
        img8 = [UIImage imageNamed:@"sex1.png"];
        iv8 = [[UIImageView alloc] initWithImage:img8];
        iv8.frame = CGRectMake(20, 105, 20, 20);
        [accountView addSubview:iv1];
        [accountView addSubview:iv2];
        [accountView addSubview:iv3];
        [accountView addSubview:iv4];
        [accountView addSubview:iv5];
        
        nameTf = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, 200, 40)];
        nameTf.borderStyle = UITextBorderStyleNone;
        nameTf.clearButtonMode = UITextFieldViewModeAlways;
        nameTf.delegate = self;
        nameTf.placeholder = @"Name";
        [accountView addSubview:nameTf];
        
        usernameTf = [[UITextField alloc] initWithFrame:CGRectMake(120, 50, 200, 40)];
        usernameTf.borderStyle = UITextBorderStyleNone;
        usernameTf.clearButtonMode = UITextFieldViewModeAlways;
        usernameTf.delegate = self;
        usernameTf.placeholder = @"Username";
        [accountView addSubview:usernameTf];
        
        websiteTf = [[UITextField alloc] initWithFrame:CGRectMake(50, 95, 260, 40)];
        websiteTf.borderStyle = UITextBorderStyleNone;
        websiteTf.clearButtonMode = UITextFieldViewModeAlways;
        websiteTf.delegate = self;
        websiteTf.placeholder = @"Website";
        [accountView addSubview:websiteTf];
        
        locationTf = [[UITextField alloc] initWithFrame:CGRectMake(50, 140, 260, 40)];
        locationTf.borderStyle = UITextBorderStyleNone;
        locationTf.clearButtonMode = UITextFieldViewModeAlways;
        locationTf.delegate = self;
        locationTf.placeholder = @"Location";
        [accountView addSubview:locationTf];
        
        bioTV = [[UITextView alloc] initWithFrame:CGRectMake(50, 185, 260, 85)];
        bioTV.editable = YES;
        bioTV.delegate = self;
        [accountView addSubview:bioTV];
        bioLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 190, 100, 30)];
        bioLabel.text = @"Bio";
        bioLabel.textColor = [UIColor lightGrayColor];
        if ([bioTV.text isEqualToString:@""]) {
            [accountView addSubview:bioLabel];
        }
        
        countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, 250, 30)];
        countryLabel.text = @"Country";
        countryLabel.textColor = [UIColor lightGrayColor];
        
        birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 53, 250, 30)];
        birthdayLabel.text = @"Birthday";
        birthdayLabel.textColor = [UIColor lightGrayColor];
        
        sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 98, 250, 30)];
        sexLabel.text = @"Sex";
        sexLabel.textColor = [UIColor lightGrayColor];
        
        countryLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, 250, 30)];
        countryLabel2.text = @"";
        countryLabel2.textColor = [UIColor blackColor];
        
        birthdayLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 53, 250, 30)];
        birthdayLabel2.text = @"";
        birthdayLabel2.textColor = [UIColor blackColor];
        
        sexLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 98, 250, 30)];
        sexLabel2.text = @"";
        sexLabel2.textColor = [UIColor blackColor];
        
        countryBtn = [[UIButton alloc]
               initWithFrame:CGRectMake(50, 8, 250, 40)];
        [countryBtn addTarget:self
                action:@selector(country:) forControlEvents:UIControlEventTouchUpInside];
        
        birthdayBtn = [[UIButton alloc]
               initWithFrame:CGRectMake(50, 53, 250, 40)];
        [birthdayBtn addTarget:self
                action:@selector(birthday:) forControlEvents:UIControlEventTouchUpInside];
        
        sexBtn = [[UIButton alloc]
                initWithFrame:CGRectMake(50, 98, 250, 40)];
        [sexBtn addTarget:self
                action:@selector(sex:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImage *profileImg = [UIImage imageNamed:@"1606454_756278167760378_6600729741222379102_o.jpg"];
        UIImageView *profileIv = [[UIImageView alloc] initWithImage:profileImg];
        profileIv.frame = CGRectMake(10, 20, 60, 60);
        CALayer *layer = [profileIv layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:30.0f];
        [accountView addSubview:profileIv];
        
        UILabel *yoko2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 230, 1)];
        yoko2.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
        [accountView addSubview:yoko2];
        
        UILabel *yoko3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 300, 1)];
        yoko3.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
        [accountView addSubview:yoko3];
        
        UILabel *yoko4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, 300, 1)];
        yoko4.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
        [accountView addSubview:yoko4];
        
        UILabel *yoko5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 1)];
        yoko5.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
        [accountView addSubview:yoko5];
        
        UILabel *yoko6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 369, 320, 1)];
        yoko6.backgroundColor = [UIColor colorWithRed:0.41 green:0.42 blue:0.44 alpha:1];
        [mainView addSubview:yoko6];
        
        UILabel *pi = [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 200, 30)];
        pi.text = @"PRIVATE INFORMATION";
        pi.font = [UIFont boldSystemFontOfSize:14];
        pi.textColor = [UIColor colorWithRed:0.41 green:0.42 blue:0.44 alpha:1];;
        [mainView addSubview:pi];
        
        UIView *piView = [[UIView alloc] initWithFrame:CGRectMake(0, 370, 320, 135)];
        piView.backgroundColor = [UIColor whiteColor];
        [mainView addSubview:piView];
        
        [piView addSubview:iv6];
        [piView addSubview:iv7];
        [piView addSubview:iv8 ];
        
        [piView addSubview:countryLabel2];
        [piView addSubview:birthdayLabel2];
        [piView addSubview:sexLabel2];
        if ([countryLabel2.text isEqualToString:@""])
        {
            [piView addSubview:countryLabel];
        }
        if ([birthdayLabel2.text isEqualToString:@""])
        {
            [piView addSubview:birthdayLabel];
        }
        if ([sexLabel2.text isEqualToString:@""])
        {
            [piView addSubview:sexLabel];
        }
    
        [piView addSubview:countryBtn];
        [piView addSubview:birthdayBtn];
        [piView addSubview:sexBtn];
        
        UILabel *yoko7 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 300, 1)];
        yoko7.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
        [piView addSubview:yoko7];
        
        UILabel *yoko8 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 300, 1)];
        yoko8.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
        [piView addSubview:yoko8];
        
       // ぴっかー
        alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        alphaView.alpha = 0.7;
        alphaView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:alphaView];
        pickerView = [[UIView alloc] initWithFrame:CGRectMake(5, 200, 310, 200)];
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.layer.cornerRadius = 20;
        [self.view addSubview:pickerView];
        
        modoru = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 40, 40)];
        modoru.text = @"×";
        modoru.textColor = [UIColor whiteColor];
        modoru.font = [UIFont boldSystemFontOfSize:35];
        [self.view addSubview:modoru];
        
        modoruBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        modoruBtn.frame = CGRectMake(10, 160, 40, 40);
        [modoruBtn addTarget:self action:@selector(modoru:)
      forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:modoruBtn];
        
        countriyPiv = [[UIPickerView alloc] init];
        countriyPiv.tag = 1;
        countriyPiv.delegate = self;
        countriyPiv.dataSource = self;
        [pickerView addSubview:countriyPiv];
        
        birthdayPicker = [[UIDatePicker alloc] init];
        birthdayPicker.minuteInterval = 30;
        birthdayPicker.datePickerMode = UIDatePickerModeDate;
        [birthdayPicker addTarget:self action:@selector(birthdaypicker:)
     forControlEvents:UIControlEventValueChanged];
        [pickerView addSubview:birthdayPicker];
        
        sexPiv = [[UIPickerView alloc] init];
        sexPiv.delegate = self;
        sexPiv.tag = 2;
        sexPiv.dataSource = self;
        [pickerView addSubview:sexPiv];
        modoru.hidden = YES;
        modoruBtn.hidden = YES;
        alphaView.hidden = YES;
        pickerView.hidden = YES;
        
        //ピッカーのカテゴリ
        countryArray = [NSMutableArray arrayWithObjects:
                        @"AFGHANISTAN",
                        @"ALBANIA",
                        @"ALGERIA",
                        @"ANDORRA",
                        @"ANGOLA",
                        @"ANTIGUA AND BARBUDA",
                        @"ARGENTINE",
                        @"ARMENIA",
                        @"AUSTRALIA",
                        @"AUSTRIA",
                        @"AZERBAIJAN",
                        @"BAHAMAS",
                        @"BAHRAIN",
                        @"BANGLADESH",
                        @"BARBADOS",
                        @"BELARUS",
                        @"BELGIUM",
                        @"BELIZE",
                        @"BENIN",
                        @"BHUTAN",
                        @"BOLIVIA",
                        @"BOSNIA AND HERZEGOVINA",
                        @"BOTSWANA",
                        @"BRAZIL",
                        @"BRUNEI",
                        @"BULGARIABURKINA FASO",
                        @"BURUNDI",
                        @"CAMBODIA",
                        @"CAMEROON",
                        @"CANADA",
                        @"CAPE VERDE",
                        @"CENTRAL AFRICA",
                        @"CHAD",
                        @"CHILE",
                        @"CHINA",
                        @"COLOMBIA",
                        @"COMOROS",
                        @"COMGO, DEMOCRATIC REPUBLIC OF THE CONGO",
                        @"COSTA RICA",
                        @"COTE D'IVOIRE",
                        @"CROATIA",
                        @"CUBA",
                        @"CYPRUS",
                        @"CZECH",
                        @"DENMARK",
                        @"DJIBOUTI",
                        @"DOMINICAN REPUBLIC",
                        @"ECUADOR",
                        @"EGYPT",
                        @"EL SALVADOR",
                        @"EQUATORIAL GUINEA",
                        @"ERITREA",
                        @"ESTONIA",
                        @"ETHIOPIA",
                        @"FIJI",
                        @"FINLAND",
                        @"FRANCE",
                        @"GABON",
                        @"GAMBIA",
                        @"GEORGIA",
                        @"GERMANY",
                        @"GHANA",
                        @"GREECE",
                        @"GRENADA",
                        @"GUATEMALA",
                        @"GUINIA",
                        @"GUINEA-BISSAU",
                        @"GUYANA",
                        @"HAITI",
                        @"HONDURAS",
                        @"HUNGARY",
                        @"ICELAND",
                        @"INDIA",
                        @"INDONESIA",
                        @"IRAN",
                        @"IRAQ",
                        @"IRELAND",
                        @"ISRAEL",
                        @"ITALY",
                        @"JAMAICA",
                        @"JAPAN",
                        @"JORDAN",
                        @"KAZAKHSTAN",
                        @"KENYA",
                        @"KIRIBATI",
                        @"KOREAW",
                        @"KOSOVO",
                        @"KUWAIT",
                        @"KYRGYZ",
                        @"LAOS",
                        @"LATVIA",
                        @"LEBANON",
                        @"LESOTHO",
                        @"LIBERIA",
                        @"LIBYA",
                        @"LIECHTENSTEIN",
                        @"LITHUANIA",
                        @"LUXEMBOURG",
                        @"MACEDONIA",
                        @"MADAGASCAR",
                        @"MALAWI",
                        @"MALAYSIA",
                        @"MALDIVES",
                        @"MALI",
                        @"MALTA",
                        @"MARSHALL",
                        @"MAURITANIA",
                        @"MAURITIUS",
                        @"MEXICO",
                        @"MICRONESIA",
                        @"MOLDOVA",
                        @"MONACO",
                        @"MONGOLIA",
                        @"MONTENEGRO",
                        @"MOROCCO",
                        @"MOZAMBIQUE",
                        @"MYANMAR",
                        @"NAMIBIA",
                        @"NAURU",
                        @"NEPAL",
                        @"NETHERLANDS",
                        @"NEW ZEALAND",
                        @"NICARAGUA",
                        @"NIGER",
                        @"NIGERIA",
                        @"NORTH KOREA",
                        @"NORWAY",
                        @"OMAN",
                        @"PAKISTAN",
                        @"PALAU",
                        @"PANAMA",
                        @"PAPUA NEW GUINEA",
                        @"PARAGUAY",
                        @"PERU",
                        @"PHILIPPINES",
                        @"POLAND",
                        @"PORTUGAL",
                        @"QATAR",
                        @"ROMANIA",
                        @"RUSSIA",
                        @"RWANDA",
                        @"SAINT CHRISTOPHER AND NEVIS",
                        @"SAINT LUCIA",
                        @"SAINT VINCENT AND THE GRENADINES",
                        @"SAMOA",
                        @"SAN MARINO",
                        @"SAO TOME AND PRINCIPE",
                        @"SAUDI ARABIA",
                        @"SENEGAL",
                        @"SERBIA",
                        @"SEYCHELLES",
                        @"SIERRA LEONE",
                        @"SINGAPORE",
                        @"SLOVAK",
                        @"SLOVENIA",
                        @"SOLOMON",
                        @"SOMALI",
                        @"SOUTH AFRICA",
                        @"SOUTH SUDAN",
                        @"SPAIN",
                        @"SRI LANKA",
                        @"SUDAN",
                        @"SURINAME",
                        @"SWAZILAND",
                        @"SWEDEN",
                        @"SWISS",
                        @"SYRIA",
                        @"TAJIKISTAN",
                        @"TANZANIA",
                        @"THAILAND",
                        @"TIMOR-LESTE",
                        @"TOGO",
                        @"TONGA",
                        @"TRINIDAD AND TOBAGO",
                        @"TUNISIA",
                        @"TURKEY",
                        @"TURKMENISTAN",
                        @"TUVALU",
                        @"UGANDA",
                        @"UKRAINE",
                        @"UNITED ARAB EMIRATES",
                        @"UNITED KINGDOM",
                        @"UNITED STATES",
                        @"URUGUAY",
                        @"UZBEKISTAN",
                        @"VANUATU",
                        @"VATICAN",
                        @"VENEZUELA",
                        @"VIET NAM",
                        @"YEMEM",
                        @"ZAMBIA",
                        @"ZIMBABWE",nil];
        
        sexArray = [NSMutableArray arrayWithObjects:
                        @"Male",
                        @"Female", nil];

    }
    if (self.cellNumber == 4) {
    }
    if (self.cellNumber == 5) {
    }
    if (self.cellNumber == 6) {
    }
    if (self.cellNumber == 7) {
    }
    if (self.cellNumber == 8) {
    }
    
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

// 戻る
-(void)back:(UIButton*)button {
    [CATransaction begin];
    CGFloat duration = 0.5f;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11 :0.72 :0.02 :0.96]; // easing関数次第でかなり印象の違う効果が生まれる
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // ユーザーの操作を止める
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    [self.presentingViewController dismissViewControllerAnimated:NO completion:NULL];
    [CATransaction commit];
    
}


// テキストフィールドデリゲート
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [addressTf resignFirstResponder];
    [passTf resignFirstResponder];
    [passkakuninTf resignFirstResponder];
    [nameTf resignFirstResponder];
    [usernameTf resignFirstResponder];
    [websiteTf resignFirstResponder];
    [locationTf resignFirstResponder];
    [bioTV resignFirstResponder];
    
    
    return YES;
}

// タップ時の処理
- (void)tapped:(UITapGestureRecognizer *)sender
{
    [addressTf resignFirstResponder];
    [passTf resignFirstResponder];
    [passkakuninTf resignFirstResponder];
    [nameTf resignFirstResponder];
    [usernameTf resignFirstResponder];
    [websiteTf resignFirstResponder];
    [locationTf resignFirstResponder];
    [bioTV resignFirstResponder];
    
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

// テキストビュー デリゲート
-(BOOL)textViewShouldBeginEditing:(UITextView*)textView
{
    bioLabel.hidden = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
        
    {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = CGPointMake(160, 224);
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
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView*)textView
{
    [bioTV resignFirstResponder];
    
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
    
    if ([bioTV.text isEqualToString:@""]) {
        bioLabel.hidden = NO;
    }
    
    return YES;
}

// ぴっかー出すボタン
-(void)country:(UIButton*)button{
    countriyPiv.hidden = NO;
    birthdayPicker.hidden = YES;
    sexPiv.hidden = YES;
    alphaView.hidden = NO;
    pickerView.hidden = NO;
    modoru.hidden = NO;
    modoruBtn.hidden = NO;
}

-(void)birthday:(UIButton*)button{
    countriyPiv.hidden = YES;
    birthdayPicker.hidden = NO;
    sexPiv.hidden = YES;
    alphaView.hidden = NO;
    pickerView.hidden = NO;
    modoru.hidden = NO;
    modoruBtn.hidden = NO;
}

-(void)sex:(UIButton*)button{
    countriyPiv.hidden = YES;
    birthdayPicker.hidden = YES;
    sexPiv.hidden = NO;
    alphaView.hidden = NO;
    pickerView.hidden = NO;
    modoru.hidden = NO;
    modoruBtn.hidden = NO;
}

-(void)modoru:(UIButton*)button
{
    alphaView.hidden = YES;
    pickerView.hidden = YES;
    modoru.hidden = YES;
    modoruBtn.hidden = YES;
}


//ぴっかー
-(void)birthdaypicker:(UIDatePicker*)dp{
    //ラベルに表示する日付・時刻のフォーマットを指定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy年MM月dd日";
    birthdayLabel.hidden = YES;
    birthdayLabel2.text = [NSString stringWithFormat:@"%@", [df stringFromDate:dp.date]];
    if (![birthdayLabel2.text isEqualToString:@""]){
        birthdayLabel.hidden = YES;
    }
}

// 列数を返す例
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1; //列数は２つ
}

// 行数を返す例
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
     return [countryArray count];
    }
    
    if (pickerView.tag == 2)
    {
        return [sexArray count];
    }
    
    return 1;
}

// 表示する内容を返す例
-(NSString*)pickerView:(UIPickerView*)pickerView
           titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1)
    {
            return [countryArray objectAtIndex:row];
    }
    
    if (pickerView.tag == 2)
    {
        return [sexArray objectAtIndex:row];
    }
    
    return nil;
}

//選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
    {
        countryLabel.hidden = YES;
        countryLabel2.text = [NSString stringWithFormat:@"%@", [countryArray objectAtIndex:row]];
        if (![countryLabel2.text isEqualToString:@""]) {
            countryLabel.hidden = YES;
        }
    }
    if (pickerView.tag == 2)
    {
        sexLabel.hidden = YES;
        sexLabel2.text = [NSString stringWithFormat:@"%@", [sexArray objectAtIndex:row]];
        if (![sexLabel2.text isEqualToString:@""]) {
            sexLabel.hidden = YES;
        }
    }
}


@end
