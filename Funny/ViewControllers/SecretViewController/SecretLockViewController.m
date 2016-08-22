//
//  SecretLockViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/27.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SecretLockViewController.h"
#import "SecretPasswordViewController.h"
#import "LockView.h"
#import "MBProgressHUD+YZZ.h"

@interface SecretLockViewController ()
@property (weak, nonatomic) IBOutlet LockView *lockView;
@property (weak, nonatomic) IBOutlet UIImageView *backGImageV;

@end

@implementation SecretLockViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:PasswordIsYES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordIsWrong) name:PasswordIsWrong object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.lockView renewOriginalStatus];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"解锁";
    _backGImageV.image = [UIImage imageNamedWithFunny:@"Home_refresh_bg"];
}
#pragma mark - notify Action
- (void)login
{
    SecretPasswordViewController *vc=[[SecretPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)passwordIsWrong
{
    [MBProgressHUD showError:@"密码错误,请重新输入" toView:self.view];
    [self.lockView performSelector:@selector(renewOriginalStatus) withObject:nil afterDelay:0.7];
}
@end
