//
//  LBBlueToothProtocol.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "LBBlueToothProtocol.h"
#import "LBBlueToothPeripheralCell.h"
@interface LBBlueToothProtocol()


@end

@implementation LBBlueToothProtocol

-(NSArray *)peripheralArray{
    if (!_peripheralArray) {
        _peripheralArray = [NSMutableArray array];
    }
    return _peripheralArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBBlueToothPeripheralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IsConnect"];
    if (cell == nil) {
        cell = [[LBBlueToothPeripheralCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IsConnect"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *item = [self.peripheralArray objectAtIndex:indexPath.row];
    CBPeripheral *per = [item objectForKey:KPeripheral];
    NSNumber *RSSI = [item objectForKey:KRSSI];
    cell.PeripheralNameLabel.text = [NSString stringWithFormat:@"设备名称：%@",per.name];
    cell.PeripheralUUIDLabel.text = [NSString stringWithFormat:@"UUID：%@",per.identifier];
    NSString *stateSting = nil;
    if (per.state == CBPeripheralStateConnected) {
        stateSting = @"连接成功";
    }else if (per.state == CBPeripheralStateConnecting){
        stateSting = @"连接中...";
    }else if (per.state == CBPeripheralStateDisconnected){
        stateSting = @"stateSting未连接";
    }
    cell.connectStateLabel.text = [NSString stringWithFormat:@"RSSI:%@  状态：%@",RSSI,stateSting];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripheralArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.presentVC connectPeripheralWithIndex:indexPath.row];
}
 

@end
