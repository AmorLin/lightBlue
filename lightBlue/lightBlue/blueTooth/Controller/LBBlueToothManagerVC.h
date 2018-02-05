//
//  LBBlueToothManagerVC.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"
//#import "PeripheralViewController.h"

@interface LBBlueToothManagerVC : FDBaseViewController

-(void)connectPeripheralWithIndex:(NSInteger)index;

@end
