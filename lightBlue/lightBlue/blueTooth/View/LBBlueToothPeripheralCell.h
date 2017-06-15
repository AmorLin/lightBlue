//
//  LBBlueToothPeripheralCell.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBBlueToothPeripheralCell : UITableViewCell

@property (nonatomic,strong) UILabel *PeripheralNameLabel;//设备名称
@property (nonatomic,strong) UILabel *PeripheralUUIDLabel;//设备的UUID
@property (nonatomic,strong) UILabel *connectStateLabel;
@end
