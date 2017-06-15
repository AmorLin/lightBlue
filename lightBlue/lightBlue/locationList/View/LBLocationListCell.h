//
//  LBLocationListCell.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBLocationListCell : UITableViewCell
//纬度
@property (nonatomic,strong) UILabel *longitudeLable;
//经度
@property (nonatomic,strong) UILabel *latitudeLable;
@end
