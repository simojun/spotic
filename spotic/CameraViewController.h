//
//  CameraViewController.h
//  spotic
//
//  Created by 下津 惇平 on 2015/07/24.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate>
{
    UIImage *img;
    UIImageView *iv;
    
    UIButton *cameraBtn;
    UIButton *refresf;
    
    BOOL isFrontMode;
    
}

@end
