//
//  LBMapCustomAnnotationView.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "LBMapCustomCalloutView.h"

@interface LBMapCustomAnnotationView : MAPinAnnotationView

@property (nonatomic, readonly) LBMapCustomCalloutView *calloutView;

@property (nonatomic, copy) NSString *imageName;
@end
