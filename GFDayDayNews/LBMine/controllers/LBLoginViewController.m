//
//  LBLoginViewController.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/5.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBLoginViewController.h"
#import "EMSDK.h"
#import "LBEaseMessageViewController.h"

#define   userDefaults    [NSUserDefaults standardUserDefaults]
@interface LBLoginViewController ()<EMContactManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;

@end

@implementation LBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nameTf.text = [userDefaults objectForKey:@"name"];
    _pwdTf.text = [userDefaults objectForKey:@"pwd"];
        [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];}


- (IBAction)loginBtnClick:(id)sender {
    if (_nameTf.text.length == 0 || _pwdTf.text.length == 0) {
        [MBProgressHUD showError:@"注册信息不能为空" toView:nil];
        return;
    }
    WEAK_SELF(self);
    [[EMClient sharedClient] loginWithUsername:_nameTf.text
                                      password:_pwdTf.text
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            DLog(@"登陆成功");
                                            LBEaseMessageViewController *chatController = [[LBEaseMessageViewController alloc] initWithConversationChatter:@"123" conversationType:EMConversationTypeChat];
                                            [weakSelf.navigationController pushViewController:chatController animated:YES];

                                        } else {
                                            DLog(@"登陆失败");
                                        }
                                    }];
    

}
- (IBAction)resginBtnClick:(id)sender {
    if (_nameTf.text.length == 0 || _pwdTf.text.length == 0) {
        [MBProgressHUD showError:@"注册信息不能为空" toView:nil];
        return;
    }
    WEAK_SELF(self);
    [[EMClient sharedClient]registerWithUsername:_nameTf.text password:_pwdTf.text completion:^(NSString *aUsername, EMError *aError) {
        DLog(@"%@-----%@",aUsername,aError);
        if (aError == nil) {
            [userDefaults setObject:weakSelf.nameTf.text forKey:@"name"];
            [userDefaults setObject:weakSelf.pwdTf.text  forKey:@"pwd"];
            [userDefaults synchronize];
             [weakSelf loginBtnClick:nil];
        }
    }];
}
#pragma mark - 好友的申请-
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {


}

- (void)dealloc {
    [[EMClient sharedClient].contactManager removeDelegate:self];

}
@end
