//
//  blueToothManagerVC.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "blueToothManagerVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "blueToothProtocol.h"
#import "FDAlertView.h"
@interface blueToothManagerVC ()<CBCentralManagerDelegate, CBPeripheralDelegate>{
    CBCentralManager *manager;
    UITableView *tableView;
}
@property (strong , nonatomic) blueToothProtocol *protocol;
@property (strong, nonatomic) NSMutableArray<CBPeripheral *> *peripheralArray;//已扫描到的设备

@property (nonatomic,strong) FDAlertView *alert;
@end

@implementation blueToothManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
    [self setUI];
}

-(void)setUI{
    [self setTableView];
    [self setBottomView];
}

-(void)setTableView{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 550) style:UITableViewStyleGrouped];
    tableView.delegate = self.protocol;
    tableView.dataSource = self.protocol;
    [self.view addSubview:tableView];
}

-(void)setBottomView{
    UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(tableView.frame) - 40, CGRectGetWidth(tableView.frame), 40)];
    [refreshButton setTitle:@"重新扫描" forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshScanPeripheral) forControlEvents:UIControlEventTouchUpInside];
    [refreshButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [refreshButton setBackgroundColor:kLightGrayColor];
    [self.view addSubview:refreshButton];
}

//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) { 
        case CBCentralManagerStateUnsupported:
            [self.alert showRemindWithCancelButton:@"不支持蓝牙4.0"];
            break;
        case CBCentralManagerStateUnauthorized:
            [self.alert showRemindWithCancelButton:@"未授权"];
            break;
        case CBCentralManagerStatePoweredOff:
            [self.alert showRemindWithCancelButton:@"蓝牙处于关闭状态，请打开蓝牙"];
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>蓝牙打开");
            //蓝牙打开时,再去扫描设备
            [manager scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }
}
//重新扫描设备
-(void)refreshScanPeripheral{
    [self.peripheralArray removeAllObjects];
    [self.protocol.peripheralArray removeAllObjects];
    [tableView reloadData];
    [manager scanForPeripheralsWithServices:nil options:nil];
}

//查到外设后，停止扫描，连接设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
     if (![self.peripheralArray containsObject:peripheral]) {
        //发现设备后,需要持有他
        [self.peripheralArray addObject:peripheral];
        self.protocol.peripheralArray = self.peripheralArray;
        [tableView reloadData];
    }
}
 //连接蓝牙设备
-(void)connectPeripheralWithIndex:(NSInteger)index{
    CBPeripheral *peripheral=(CBPeripheral *)self.peripheralArray[index];
    if (peripheral.state == CBPeripheralStateConnected) {
        [self.alert showRemindWithCancelButton:@"已连接成功"];
    }else{
         [self.alert showRemindWithCancelButton:@"正在连接,请稍后...."];
    }
    peripheral.delegate = self;
    [manager connectPeripheral:peripheral options:nil];
}

//外设连接成功时调用
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功");
    [self.alert dismissAlert];
    //设置外设代理
    peripheral.delegate = self;
    //搜索服务
    [peripheral discoverServices:nil];
    [tableView reloadData];
}

//外设连接失败时调用
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接失败,%@", [error localizedDescription]);
    [manager connectPeripheral:peripheral options:nil];
    [self.alert dismissAlert];
    
}

//断开连接时调用
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    NSLog(@"断开连接");
    NSLog(@"%@",error);
    [tableView reloadData];
}

//发现服务时调用
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        NSLog(@"%@发现服务时出错: %@", peripheral.identifier, [error localizedDescription]);
        return;
    }
    //遍历外设的所有服务
    for (CBService *service in peripheral.services) {
        NSLog(@"外设服务: %@", service.UUID.UUIDString);
        //每个服务又包含一个或多个特征,搜索服务的特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//发现特征时调用,由几个服务,这个方法就会调用几次
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"扫描特征出错:%@", [error localizedDescription]);
        return;
    }
    //获取Characteristic的值
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"服务server:%@ 的特征:%@, 读写属性:%ld", service.UUID.UUIDString, characteristic.UUID, characteristic.properties);
        //        if ([service.UUID.UUIDString isEqualToString:@"180A"]) {
        //            [peripheral readValueForCharacteristic:characteristic];
        // 获取特征对应的描述
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        // 获取特征的值
        [peripheral readValueForCharacteristic:characteristic];
        //        }
    }
}
/*
 //6.从外围设备读数据
 - (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
 {
 //    NSLog(@"从外围设备读数据== %@",characteristic.value);
 NSData *data = characteristic.value;
 if (data != nil) {
 NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"从外围设备读数据== %@",str);
 }
 
 }
 
 */

// 更新特征的描述的值的时候会调用
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    [peripheral readValueForDescriptor:descriptor];
}

// 更新特征的value的时候会调用
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    for (CBDescriptor *descriptor in characteristic.descriptors) {
        [peripheral readValueForDescriptor:descriptor];
    }
}

#pragma mark - 懒加载
-(NSMutableArray<CBPeripheral *> *)peripheralArray{
    if (!_peripheralArray) {
        _peripheralArray = [[NSMutableArray alloc]init];
    }
    return _peripheralArray;
}
-(blueToothProtocol *)protocol{
    if (!_protocol) {
        _protocol = [[blueToothProtocol alloc]init];
        _protocol.presentVC = self;
    }
    return _protocol;
}

-(FDAlertView *)alert{
    if (!_alert) {
        _alert = [[FDAlertView alloc]init];
    }
    return _alert;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
@end
