//
//  ViewController.h
//  spotic
//
//  Created by 下津 惇平 on 2015/07/24.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic)NSMutableArray *cvData;
@property (retain, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (retain, nonatomic) UICollectionView *collectionView;
@end

