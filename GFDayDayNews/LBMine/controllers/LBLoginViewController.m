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
@interface LBLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;

@end

@implementation LBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nameTf.text = [userDefaults objectForKey:USER_NAME];
    _pwdTf.text = [userDefaults objectForKey:USER_PWD];
    if ([EMClient sharedClient].isLoggedIn) {
        EMError *error = nil;
        NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            LBEaseMessageViewController *chatController = [[LBEaseMessageViewController alloc] initWithConversationChatter:userlist.firstObject conversationType:EMConversationTypeChat];
            [self.navigationController pushViewController:chatController animated:YES];
        }
    }
}

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
                                            [userDefaults setObject:weakSelf.nameTf.text forKey:USER_NAME];
                                            [userDefaults setObject:weakSelf.pwdTf.text  forKey:USER_PWD];
                                            [userDefaults synchronize];
                                            [[EMClient sharedClient].options setIsAutoLogin:YES];
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
            [userDefaults setObject:weakSelf.nameTf.text forKey:USER_NAME];
            [userDefaults setObject:weakSelf.pwdTf.text  forKey:USER_PWD];
            [userDefaults synchronize];
             [weakSelf loginBtnClick:nil];
        }
    }];
}



@end
