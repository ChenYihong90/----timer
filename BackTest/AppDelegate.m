//
//  AppDelegate.m
//  BackTest
//
//  Created by cyh on 14-5-14.
//  Copyright (c) 2014年 cyh. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //加上下面的代码后，如果你从音乐播放器切换到你的app，你会发现音乐播放器停止播放了。
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryErr];
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
    
    //注册网络变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachableChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
   
    NSTimer *enterBackgroundTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                            target:self
                                                          selector:@selector(handleTimer:)
                                                          userInfo:nil
                                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:enterBackgroundTimer forMode:NSDefaultRunLoopMode];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
-(void)handleTimer:(NSTimer *)timer
{
    NSLog(@"handleTimer");
}

//网络变化通知
-(void)reachableChanged:(NSNotification *)note
{
    NSLog(@"reachableChanged");
    Reachability *curReach = [note object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        //初始化通知
        UILocalNotification *netChangeNotification = [[UILocalNotification alloc] init];
        
        //设置推送时间
        netChangeNotification.fireDate = [NSDate date];
        
        //设置时区
        netChangeNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        //推送声音
        netChangeNotification.soundName = UILocalNotificationDefaultSoundName;
        
        //内容
        netChangeNotification.alertBody = [[NSString alloc] initWithFormat:@"网络已断开链接，请重新登录"];
        
        //添加推送到uiapplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:netChangeNotification];
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络已断开链接，请重新连接wifi" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}
@end
