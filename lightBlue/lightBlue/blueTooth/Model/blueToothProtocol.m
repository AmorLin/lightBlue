//
//  blueToothProtocol.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "blueToothProtocol.h" 
#import "blueToothPeripheralCell.h"
@interface blueToothProtocol()


@end

@implementation blueToothProtocol

-(NSArray<CBPeripheral *> *)peripheralArray{
    if (!_peripheralArray) {
        _peripheralArray = [NSArray array];
    }
    return _peripheralArray;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    blueToothPeripheralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IsConnect"];
    if (cell == nil) {
        cell = [[blueToothPeripheralCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IsConnect"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CBPeripheral *per=(CBPeripheral *)self.peripheralArray[indexPath.row];
    cell.PeripheralNameLabel.text = [NSString stringWithFormat:@"设备名称：%@",per.name];
    cell.PeripheralUUIDLabel.text = [NSString stringWithFormat:@"UUID：%@",per.identifier];
    if (per.state == CBPeripheralStateConnected) {
        cell.connectStateLabel.text = @"状态：连接成功";
    }else if (per.state == CBPeripheralStateConnecting){
        cell.connectStateLabel.text = @"状态：连接中。。。";
    }else if (per.state == CBPeripheralStateDisconnected){
        cell.connectStateLabel.text = @"状态：未连接";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripheralArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.presentVC connectPeripheralWithIndex:indexPath.row];
}
 

@end
