//
//  FDBaseViewController.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/13.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "FDBaseViewController.h"

@interface FDBaseViewController ()

@end

@implementation FDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationbar];
}

- (void)setNavigationbar
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    //创建UINavigationItem
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"外围设备管理"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
