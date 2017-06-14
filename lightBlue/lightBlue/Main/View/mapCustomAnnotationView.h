//
//  mapCustomAnnotationView.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "mapCustomCalloutView.h"

@interface mapCustomAnnotationView : MAPinAnnotationView

@property (nonatomic, readonly) mapCustomCalloutView *calloutView;

@property (nonatomic, copy) NSString *imageName;
@end
