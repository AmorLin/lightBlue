//
//  locationListViewController.h
//  lightBlue
//
//  Created by wlinlin on 2017/6/14.
//  Copyright © 2017年 wlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class locationListViewController;
@protocol locationListViewControllerDelegate<NSObject>

-(void)updateMap:(NSDictionary *)dict;

@end

@interface locationListViewController : UIViewController

@property (nonatomic,strong) NSArray *locationArray;
@property (nonatomic,weak) id<locationListViewControllerDelegate> delegate;

@end
