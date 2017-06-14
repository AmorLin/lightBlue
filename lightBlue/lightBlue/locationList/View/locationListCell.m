//
//  locationListCell.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "locationListCell.h"
#define kPortraitMargin     5
#define kTitleWidth     150
#define kTitleHeight    25
@implementation locationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    // 经度
    self.latitudeLable = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2, kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.latitudeLable.font = kDefaultFont;
    self.latitudeLable.textColor = kWhiteColor;
    self.latitudeLable.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
    [self addSubview:self.latitudeLable];
    
    //纬度
    self.longitudeLable = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 , CGRectGetMaxY(self.latitudeLable.frame), kTitleWidth, kTitleHeight)];
    self.longitudeLable.font = kDefaultFont;
    self.longitudeLable.textColor = kWhiteColor;
    self.longitudeLable.text = @"titletitletitletitle";
    [self addSubview:self.longitudeLable];
    
 
}

@end
