//
//  LBEaseMessageViewController.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBEaseMessageViewController.h"
@interface LBEaseMessageViewController ()

@end

@implementation LBEaseMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarRightWithTitle:@"添加" andSelectedTitle:@"添加"];
    NSData *defalutData = [[NSUserDefaults standardUserDefaults] objectForKey:[[EMClient sharedClient] currentUsername]];
    NSArray *ary = [NSKeyedUnarchiver unarchiveObjectWithData:defalutData];
    DLog(@"%@",ary);

}
- (void)rightBarButtonClick:(UIButton *)btn {
    [[EMClient sharedClient].contactManager addContact:@"123"
                                               message:@"我想加您为好友"
                                            completion:^(NSString *aUsername, EMError *aError) {
                                                if (!aError) {
                                                    [MBProgressHUD showSuccess:@"已发送" toView:nil];
                                                }
                                            }];
    
}


@end
