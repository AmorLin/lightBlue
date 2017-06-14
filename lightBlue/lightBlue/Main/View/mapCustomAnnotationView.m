//
//  mapCustomAnnotationView.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "mapCustomAnnotationView.h"
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@interface mapCustomAnnotationView ()

@property (nonatomic, strong, readwrite) mapCustomCalloutView *calloutView;

@end

@implementation mapCustomAnnotationView

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
            self.calloutView = [[mapCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
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
