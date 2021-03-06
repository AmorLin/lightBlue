//
//  LBBlueToothPeripheralCell.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "LBBlueToothPeripheralCell.h"

@implementation LBBlueToothPeripheralCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    CGRect PeripheralName_frame = CGRectMake(5, 5, 250, 20);
    self.PeripheralNameLabel = [[UILabel alloc]initWithFrame:PeripheralName_frame];
    _PeripheralNameLabel.text =@"设备名称";
    _PeripheralNameLabel.font = kDefaultFont;
    _PeripheralNameLabel.textColor = kBlackColor;
    [self addSubview:_PeripheralNameLabel];
    
    
    CGRect PeripheralUUID_frame = CGRectMake(5, CGRectGetMaxY(_PeripheralNameLabel.frame)-5, 280, 60);
    _PeripheralUUIDLabel = [[UILabel alloc]initWithFrame:PeripheralUUID_frame];
    _PeripheralUUIDLabel.numberOfLines = 0;
    _PeripheralUUIDLabel.font = kDefaultFont;
    _PeripheralUUIDLabel.textColor = kBlackColor;
    _PeripheralUUIDLabel.text = @"UUID........";
    [self addSubview:_PeripheralUUIDLabel];
    
    CGRect connectStateLabel_frame = CGRectMake(5, CGRectGetMaxY(_PeripheralUUIDLabel.frame)-5, 250, 25);
    _connectStateLabel = [[UILabel alloc]initWithFrame:connectStateLabel_frame]; 
    _connectStateLabel.text = @"连接状态";
    _connectStateLabel.font = kDefaultFont;
    _connectStateLabel.textColor = kBlackColor;
    [self addSubview:_connectStateLabel];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
