//
//  CameraViewController.m
//  spotic
//
//  Created by 下津 惇平 on 2015/07/24.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import "CameraViewController.h"
#import "ToukouViewController.h"

@interface CameraViewController ()
{
    UIImageView *cameraIv;
    UIImageView *flashIv;
    
    UIImage *takeImg;
    
    AVCaptureDevice *flashDevice;
    long flash;
    
    long imageNumber;
    
}
@property (strong, nonatomic) IBOutlet UIButton *backbtn;

// カメラ
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) UIView *previewView;
@end



@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flash=0;
    
    isFrontMode=NO;
    
    UILabel *headerHaikei = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    headerHaikei.backgroundColor = [UIColor colorWithRed:0.2 green:0.22 blue:0.21 alpha:1];
    [self.view addSubview:headerHaikei];
    _backbtn.frame = CGRectMake(5, 20, 44, 44);
    [self.view addSubview:_backbtn];
    UIView *footerHaikei = [[UIView alloc] initWithFrame:CGRectMake(0, 384, 320, 186)];
    footerHaikei.backgroundColor = [UIColor colorWithRed:0.07 green:0.08 blue:0.08 alpha:1];
    [self.view addSubview:footerHaikei];
    
    // カメラ
    UILabel *maru = [[UILabel alloc] initWithFrame:CGRectMake(125, 58, 70, 70)];
    maru.backgroundColor = [UIColor whiteColor];
    maru.layer.masksToBounds = YES;
    maru.layer.cornerRadius = 35.0f;
    [footerHaikei addSubview:maru];
    
    UILabel *maru2 = [[UILabel alloc] initWithFrame:CGRectMake(127.5, 60.5, 65, 65)];
    maru2.backgroundColor = [UIColor colorWithRed:0.07 green:0.08 blue:0.08 alpha:1];
    maru2.layer.masksToBounds = YES;
    maru2.layer.cornerRadius = 32.5f;
    [footerHaikei addSubview:maru2];
    
    UILabel *maru3 = [[UILabel alloc] initWithFrame:CGRectMake(132, 65, 56, 56)];
    maru3.backgroundColor = [UIColor colorWithRed:0.74 green:0.32 blue:0.3 alpha:1];
    maru3.layer.masksToBounds = YES;
    maru3.layer.cornerRadius = 28.0f;
    [footerHaikei addSubview:maru3];
    cameraBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cameraBtn.frame = CGRectMake(125, 58, 70, 70);
    // ボタンがタッチダウンされた時にhogeメソッドを呼び出す
    [cameraBtn addTarget:self action:@selector(takePhoto:)
        forControlEvents:UIControlEventTouchDown];
    [footerHaikei addSubview:cameraBtn];
    
    //画像
    img = [UIImage imageNamed:@"photo.png"];
    iv = [[UIImageView alloc] initWithImage:img];
    iv.frame = CGRectMake(40, 73, 40, 40);
    iv.layer.masksToBounds = YES;
    iv.layer.cornerRadius =5.0f;
    [footerHaikei addSubview:iv];
    // 画像ライブラリ
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(40, 73, 40, 40);
    [button setTitle:@"" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footerHaikei addSubview:button];
    
    // フラッシュ
    UIImage *flashImg = [UIImage imageNamed:@"lightoff.png"];
    flashIv = [[UIImageView alloc] initWithImage:flashImg];
    flashIv.frame = CGRectMake(240, 30, 17, 25);
    [self.view addSubview:flashIv];
    
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    flashBtn.frame = CGRectMake(240, 20, 40, 40);
    [flashBtn addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashBtn];
    
    // 反転
    UIImage *cameraImg = [UIImage imageNamed:@"camera_change.png"];
    cameraIv = [[UIImageView alloc] initWithImage:cameraImg];
    cameraIv.frame = CGRectMake(280, 30, 25, 25);
    [self.view addSubview:cameraIv];
    // 画像ライブラリ
    UIButton *hantenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hantenBtn.frame = CGRectMake(270, 20, 40, 40);
    [hantenBtn setTitle:@"" forState:UIControlStateNormal];
    [hantenBtn addTarget:self action:@selector(reverse:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hantenBtn];
    
    // プレビュー用のビューを生成
    self.previewView = [[UIView alloc] initWithFrame:CGRectMake(0,64,320,320)];
    [self.view addSubview:self.previewView];
    
    // 撮影開始
    [self setupAVCapture];
    
    
    
    UILabel *tate1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 64, 1, 320)];
    tate1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tate1];
    UILabel *tate2 = [[UILabel alloc] initWithFrame:CGRectMake(220, 64, 1, 320)];
    tate2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tate2];
    UILabel *yoko1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 174, 320, 1)];
    yoko1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yoko1];
    UILabel *yoko2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 284, 320, 1)];
    yoko2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yoko2];
    
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

- (void)setupAVCapture
{
    NSError *error = nil;
    
    // 入力と出力からキャプチャーセッションを作成
    self.session = [[AVCaptureSession alloc] init];
    
    // 正面に配置されているカメラを取得
    AVCaptureDevice *camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // カメラからの入力を作成し、セッションに追加
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&error];
    [self.session addInput:self.videoInput];
    
    // 画像への出力を作成し、セッションに追加
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [self.session addOutput:self.stillImageOutput];
    
    // キャプチャーセッションから入力のプレビュー表示を作成
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    captureVideoPreviewLayer.frame = self.view.bounds;
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // レイヤーをViewに設定
    CALayer *previewLayer = self.previewView.layer;
    previewLayer.masksToBounds = YES;
    [previewLayer addSublayer:captureVideoPreviewLayer];
    
    // セッション開始
    [self.session startRunning];
}


// 写真を撮る
- (void)takePhoto:(id)sender
{
    
    ToukouViewController *secondVC = [[ToukouViewController alloc] init];
    
    // ビデオ入力のAVCaptureConnectionを取得
    AVCaptureConnection *videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    if (videoConnection == nil) {
        return;
    }
    
    // ビデオ入力から画像を非同期で取得。ブロックで定義されている処理が呼び出され、画像データを引数から取得する
    [self.stillImageOutput
     captureStillImageAsynchronouslyFromConnection:videoConnection
     completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
         if (imageDataSampleBuffer == NULL) {
             return;
         }
         
         // 入力された画像データからJPEGフォーマットとしてデータを取得
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
         
         // JPEGデータからUIImageを作成
         takeImg = [[UIImage alloc] initWithData:imageData];
         
         // アルバムに画像を保存
         UIImageWriteToSavedPhotosAlbum(takeImg, self, nil, nil);
         
         iv.image = takeImg;
         
         // フラッシュ
         [flashDevice lockForConfiguration:NULL];
         flashDevice.torchMode = AVCaptureTorchModeOff;
         [flashDevice unlockForConfiguration];
         flash = 0;
         imageNumber = 1;
         secondVC.kakouImg = takeImg;
         secondVC.imageNumber = imageNumber;
         [self presentViewController:secondVC animated:YES completion:nil];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 画像ライブラリ関係
- (void)buttonWasTapped:(UIButton *)button
{
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        // フラッシュ
        [flashDevice lockForConfiguration:NULL];
        flashDevice.torchMode = AVCaptureTorchModeOff;
        [flashDevice unlockForConfiguration];
        flash = 0;
    }
}

#pragma UIImagePickerController

// 画像が選択された時
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ToukouViewController *secondVC = [[ToukouViewController alloc] init];
    
    // オリジナル画像
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    // 編集画像
    UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *saveImage;
    
    if(editedImage)
    {
        takeImg = editedImage;
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(senni:)
                                       userInfo:nil
                                        repeats:NO
         ];
    }
    else
    {
        saveImage = originalImage;
    }
    
}

- (void)senni:(NSTimer *)timer
{
    ToukouViewController *secondVC = [[ToukouViewController alloc] init];
    imageNumber = 0;
    secondVC.kakouImg = takeImg;
    secondVC.imageNumber = imageNumber;
    [self presentViewController:secondVC animated:YES completion:nil];
}

// 画像の保存完了時に呼ばれるメソッド
- (void)targetImage:(UIImage *)image
didFinishSavingWithError:(NSError *)error
        contextInfo:(void *)context
{
    if (error) {
        // 保存失敗時の処理
    } else {
        // 保存成功時の処理
    }
}


// 画像の選択がキャンセルされた時の
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 反転
- (void)reverse:(UIImagePickerController *)picker
{
    //フラッシュ
    [flashDevice lockForConfiguration:NULL];
    flashDevice.torchMode = AVCaptureTorchModeOff;
    [flashDevice unlockForConfiguration];
    flash = 0;
    AVCaptureDevice *captureDevice;
    if(!isFrontMode){
        captureDevice = [self frontFacingCameraIfAvailable];
        isFrontMode = YES;
    } else {
        captureDevice = [self backCamera];
        isFrontMode = NO;
    }
    [self.session removeInput:_videoInput];
    _videoInput = [AVCaptureDeviceInput
                   deviceInputWithDevice:captureDevice
                   error:nil];
    [self.session addInput:_videoInput];
}


- (AVCaptureDevice *)frontFacingCameraIfAvailable
{
    //  look at all the video devices and get the first one that's on the front
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionFront)
        {
            captureDevice = device;
            break;
        }
    }
    
    //  couldn't find one on the front, so just get the default video device.
    if ( ! captureDevice)
    {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return captureDevice;
}

- (AVCaptureDevice *)backCamera
{
    //  look at all the video devices and get the first one that's on the front
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionBack)
        {
            captureDevice = device;
            break;
        }
    }
    //  couldn't find one on the front, so just get the default video device.
    if ( ! captureDevice)
    {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return captureDevice;
}


// フラッシュ
-(void)flash:(UIButton*)button
{
    flashDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (flash == 0) {
        [flashDevice lockForConfiguration:NULL];
        flashDevice.torchMode = AVCaptureTorchModeOn;
        [flashDevice unlockForConfiguration];
        flash=1;
        return;
    }
    
    if (flash == 1)
    {
        [flashDevice lockForConfiguration:NULL];
        flashDevice.torchMode = AVCaptureTorchModeOff;
        [flashDevice unlockForConfiguration];
        flash = 0;
        return;
    }
}
@end