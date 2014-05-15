//
//  ViewController.m
//  BackTest
//
//  Created by cyh on 14-5-14.
//  Copyright (c) 2014年 cyh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSTimer *enterBackgroundTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                                     target:self
                                                                   selector:@selector(handleTimer:)
                                                                   userInfo:nil
                                                                    repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:enterBackgroundTimer forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleTimer:(NSTimer *)timer
{
    NSLog(@"handleTimer2222");
}

@end
