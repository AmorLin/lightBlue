//
//  mainViewController.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "mainViewController.h"
#import "blueToothManagerVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface mainViewController ()
@property (nonatomic,strong) UIPopoverController *popController;

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kMainTitle;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"蓝牙" style:UIBarButtonItemStylePlain target:self action:@selector(setBlueToothConnection)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self initMap];
}

-(void)initMap{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
     ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
     ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

-(void)setBlueToothConnection{
    blueToothManagerVC *managerVC = [[blueToothManagerVC alloc]init];
    self.popController = [[UIPopoverController alloc]initWithContentViewController:managerVC];
    self.popController.popoverContentSize = CGSizeMake(300, 550);
    //显示
    [self.popController presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
