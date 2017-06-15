//
//  mainViewController.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "mainViewController.h"
#import "LBBlueToothManagerVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LBMapCustomAnnotationView.h"
#import "LBLocationListViewController.h"

@interface mainViewController ()<MAMapViewDelegate,locationListViewControllerDelegate>{
    MAPointAnnotation *pointAnnotation;
}
@property (nonatomic,strong) UIPopoverController *popController;
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) LBLocationListViewController *locationListVC;
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kMainTitle;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"蓝牙" style:UIBarButtonItemStylePlain target:self action:@selector(setBlueToothConnection)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

-(void)initUI{
    [self initMap];
    [self initLocationListView];
}

-(void)initLocationListView{
    LBLocationListViewController *listVC = [[LBLocationListViewController alloc]init];
    listVC.view.frame = CGRectMake(0, 64, 200, kScreenHeight - 64);
    listVC.delegate = self;
    [self.view addSubview:listVC.view];
    [self addChildViewController:listVC];
}

-(void)initMap{
    
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(200, 64, kScreenWidth - 200,kScreenHeight - 64 )];
    [self.view addSubview:_mapView];
    
    _mapView.delegate = self;
    
     ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    [self.mapView updateUserLocationRepresentation:r];
}

-(void)setBlueToothConnection{
    LBBlueToothManagerVC *managerVC = [[LBBlueToothManagerVC
                                        alloc]init];
    self.popController = [[UIPopoverController alloc]initWithContentViewController:managerVC];
    self.popController.popoverContentSize = CGSizeMake(300, 550);
    //显示
    [self.popController presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//点击左侧列表的时候，拿到位置，添加大头针
-(void)updateMap:(NSDictionary *)dict{
    if (pointAnnotation) {//移除当前地图上的大头针
        [_mapView removeAnnotation:pointAnnotation];
    }
    pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake( [dict[@"longitude"] doubleValue],  [dict[@"latitude"] doubleValue]);
    pointAnnotation.title = [NSString stringWithFormat:@"经度:%f",pointAnnotation.coordinate.longitude];
    pointAnnotation.subtitle = [NSString stringWithFormat:@"纬度:%f",pointAnnotation.coordinate.latitude];
    [_mapView addAnnotation:pointAnnotation];
}

//代理 显示大头针，自定义的大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        LBMapCustomAnnotationView *annotationView = (LBMapCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[LBMapCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
        annotationView.imageName = @"boat";
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
