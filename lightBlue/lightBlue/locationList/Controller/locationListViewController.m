//
//  LBLocationListViewController.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "LBLocationListViewController.h"
#import "LBLocationListCell.h"
@interface LBLocationListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation LBLocationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

- (void)initUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, kScreenHeight - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)initData{
    self.locationArray = @[
                           @{@"longitude":@39.989631,@"latitude":@116.481018},
                           @{@"longitude":@39.989631,@"latitude":@116.581018},
                           @{@"longitude":@39.989631,@"latitude":@116.681018}
                           ];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBLocationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationList"];
    if (cell == nil) {
        cell = [[LBLocationListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"locationList"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.longitudeLable.text = [NSString stringWithFormat:@"纬度:%@",self.locationArray[indexPath.row][@"longitude"]];
    cell.latitudeLable.text = [NSString stringWithFormat:@"经度:%@",self.locationArray[indexPath.row][@"latitude"]] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateMap:)]) {
        [self.delegate updateMap:self.locationArray[indexPath.row]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
