//
//  CustomAnnotation.m
//  spotic
//
//  Created by 下津 惇平 on 2015/09/27.
//  Copyright (c) 2015年 junP. All rights reserved.
//

#import "CustomAnnotation.h"
#import <MapKit/MapKit.h>
@implementation CustomAnnotation 
@synthesize coordinate;

- (NSString *)title {
    return annotationTitle;
}

- (NSString *)subtitle {
    return annotationSubtitle;
}

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) _coordinate
                           title:(NSString *)_annotationTitle subtitle:(NSString *)_annotationSubtitle {
    coordinate = _coordinate;
    self->annotationTitle = _annotationTitle;
    self->annotationSubtitle = _annotationSubtitle;
    return self;
}
@end
