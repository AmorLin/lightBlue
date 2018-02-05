//
//  LBBlueToothManagerVC.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "LBBlueToothManagerVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "LBBlueToothProtocol.h"
#import "FDAlertView.h"
#import "SVProgressHUD.h"
@interface LBBlueToothManagerVC ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
}

@property (strong , nonatomic) LBBlueToothProtocol *protocol;
@end

@implementation LBBlueToothManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showInfoWithStatus:@"准备打开设备"];
    peripheralDataArray = [[NSMutableArray alloc]init];
    
    //初始化BabyBluetooth 蓝牙库
    baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];
    
    [self setUI];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    
    [baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    baby.scanForPeripherals().begin();
    //baby.scanForPeripherals().begin().stop(10);
}

-(void)setUI{ 
    [self setTableView];
    [self setBottomView];
}

-(void)setTableView{
    //pop控制器的大小（300,550）height = 550 - navheight - bottomheight
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 300, 466) style:UITableViewStyleGrouped];
    tableView.delegate = self.protocol;
    tableView.dataSource = self.protocol;
    [self.view addSubview:tableView];
}

-(void)setBottomView{
    UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 510, CGRectGetWidth(tableView.frame), 40)];
    [refreshButton setTitle:@"重新扫描" forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshScanPeripheral) forControlEvents:UIControlEventTouchUpInside];
    [refreshButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [refreshButton setBackgroundColor:kLightGrayColor];
    [self.view addSubview:refreshButton];
}

#pragma mark - 蓝牙配置和操作
//蓝牙网关初始化和委托代理方法设置
- (void)babyDelegate{
    
    __weak typeof (self) weakSelf = self;
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
        }
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
       NSLog(@"搜索到了设备:%@",peripheral.name);
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
    
    //设置发现设service的characteristeristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
    }];
    
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristic.UUID,characteristic.value);
    }];
    
    //设置发现characteristeristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID,descriptor.value);
    }];
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备
//        if ([peripheralName hasPrefix:@"Pxxxxxx"]) {
//            return YES;
//        }
//        return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length > 0) {
            return YES;
        }
        return NO;
        
    }];
    
    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
         NSLog(@"setBlockOnCancelScanBlock");
    }];
    
    //示例
    NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    //连接设备
    [baby setBabyOptionsWithScanForPeripheralsWithOptions:options connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
}

- (void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSArray *peripherals = [peripheralDataArray valueForKey:KPeripheral];
    if (![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:KPeripheral];
        [item setValue:RSSI forKey:KRSSI];
        [item setValue:advertisementData forKey:KAdvertisementData];
        [peripheralDataArray addObject:item];
        
        self.protocol.peripheralArray = peripheralDataArray;
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - 懒加载
-(LBBlueToothProtocol *)protocol{
    if (!_protocol) {
        _protocol = [[LBBlueToothProtocol alloc]init];
        _protocol.presentVC = self;
    }
    return _protocol;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
@end
