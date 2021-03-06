//
//  SuperViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "AboutMyViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD+YZZ.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self superAboutMy];
    [self netStatusChange];
}

- (void)superAboutMy{
    UIButton *superButton=[UIButton buttonWithType:UIButtonTypeSystem];
    superButton.frame=CGRectMake(0, 0, 40, 40);
    UIImage *superImage=[[UIImage imageNamedWithTabBar:@"weibo_profile_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [superButton setImage:superImage forState:UIControlStateNormal];
    [superButton addTarget:self action:@selector(aboutMy) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:superButton];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
}

#pragma mark - action
- (void)aboutMy
{
    AboutMyViewController *avc=[[AboutMyViewController alloc] init];
    avc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:avc animated:YES];
}
- (void)netStatusChange
{
    YZWeakSelf(self)
    [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingReachabilityDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusReachableViaWiFi) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            MBProgressHUD *hud=[MBProgressHUD showMessage:@"WIFI中断,请退出程序" toView:weakself.navigationController.view];
            hud.labelColor=[UIColor redColor];
            [hud hide:YES afterDelay:2.0f];
        }
    }];
}
- (void)becomeBlack
{
    UIView *blackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    blackView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:blackView];
}



@end
