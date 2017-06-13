//
//  blueToothProtocol.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "blueToothManagerVC.h"

@interface blueToothProtocol : NSObject
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray<CBPeripheral *> *peripheralArray;

@property(nonatomic,strong) blueToothManagerVC *presentVC;

@end
