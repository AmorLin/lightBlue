//
//  FDAlertView.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/13.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAlertView : UIView

- (void)showRemind:(NSString *)remindStr;
- (void)showRemindWithCancelButton:(NSString *)remindStr;

-(void)dismissAlert;
@end
