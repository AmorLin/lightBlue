//
//  CustomAnnotationView.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAPinAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
