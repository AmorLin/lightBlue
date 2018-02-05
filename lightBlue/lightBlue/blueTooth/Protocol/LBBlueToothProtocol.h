//
//  LBBlueToothProtocol.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "LBBlueToothManagerVC.h"

@interface LBBlueToothProtocol : NSObject
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *peripheralArray;

@property(nonatomic,strong) LBBlueToothManagerVC *presentVC;

@end
