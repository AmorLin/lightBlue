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
#import "CustomAnnotationView.h"

@interface mainViewController ()<MAMapViewDelegate>
@property (nonatomic,strong) UIPopoverController *popController;
@property (nonatomic,strong) MAMapView *mapView;
@end

@implementation mainViewController

-(void)viewDidAppear:(BOOL)animated{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = [NSString stringWithFormat:@"经度:%f",pointAnnotation.coordinate.longitude];
    pointAnnotation.subtitle = [NSString stringWithFormat:@"纬度:%f",pointAnnotation.coordinate.latitude]; 
    [_mapView addAnnotation:pointAnnotation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kMainTitle;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"蓝牙" style:UIBarButtonItemStylePlain target:self action:@selector(setBlueToothConnection)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initMap];
}

-(void)initMap{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
     ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
     ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.delegate = self;
}

-(void)setBlueToothConnection{
    blueToothManagerVC *managerVC = [[blueToothManagerVC alloc]init];
    self.popController = [[UIPopoverController alloc]initWithContentViewController:managerVC];
    self.popController.popoverContentSize = CGSizeMake(300, 550);
    //显示
    [self.popController presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
