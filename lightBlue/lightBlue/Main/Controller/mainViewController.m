//
//  mainViewController.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/12.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "mainViewController.h"
#import "blueToothManagerVC.h"

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
