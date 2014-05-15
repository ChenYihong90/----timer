//
//  AppDelegate.h
//  BackTest
//
//  Created by cyh on 14-5-14.
//  Copyright (c) 2014年 cyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability *hostReach;
}

@property (strong, nonatomic) UIWindow *window;

@end
