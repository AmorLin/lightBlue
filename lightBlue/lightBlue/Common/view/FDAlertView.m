//
//  FDAlertView.m
//  lightBlue
//
//  Created by wlinlin on 2017/6/13.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import "FDAlertView.h"
@interface FDAlertView()

@property (nonatomic,strong) UIAlertView *alert;

@end


@implementation FDAlertView

- (void)showRemind:(NSString *)remindStr
{
    
    _alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                        message:remindStr
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];
    [_alert show];
}

- (void)showRemindWithCancelButton:(NSString *)remindStr{
    _alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                        message:remindStr
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定",nil];
    [_alert show];
}

- (void)dismissAlert
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
     
//    [_alert dismissWithClickedButtonIndex:_alert.firstOtherButtonIndex animated:YES];
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
    _alert = nil;
    
}

- (UIAlertView *)alert
{
    return _alert;
}

- (void)didShowAlert:(UIAlertView *)alert
{
    _alert = alert;
}


@end
