//
//  LBMapCustomAnnotationView.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "LBMapCustomAnnotationView.h"
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@interface LBMapCustomAnnotationView ()

@property (nonatomic, strong, readwrite) LBMapCustomCalloutView *calloutView;

@end

@implementation LBMapCustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
        
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[LBMapCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = [UIImage imageNamed:self.imageName];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}
@end
