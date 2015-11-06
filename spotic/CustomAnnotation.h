//
//  CustomAnnotation.h
//  spotic
//
//  Created by 下津 惇平 on 2015/09/27.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    IBOutlet NSString *annotationTitle;
    IBOutlet NSString *annotationSubtitle;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) _coordinate
                           title:(NSString *)_annotationTitle subtitle:(NSString *)_annotationannSubtitle;
- (NSString *)title;
- (NSString *)subtitle;

@end
