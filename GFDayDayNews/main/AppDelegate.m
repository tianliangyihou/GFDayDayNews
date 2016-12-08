//
//  AppDelegate.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "AppDelegate.h"
#import "LBTabBarController.h"
#import "EMSDK.h"
@interface AppDelegate ()<EMClientDelegate,EMContactManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self EMSDKInit];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LBTabBarController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)EMSDKInit {

    EMOptions *options = [EMOptions optionsWithAppkey:@"xiwowangyiyangliuyiyi#zhuxian"];
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}
#pragma mark - 监听自动登录  账号的登录和登出-

- (void)didAutoLoginWithError:(EMError *)aError {
    NSLog(@"didAutoLoginWithError ------ %@",aError);
}

- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState {
    NSLog(@"didConnectionStateChanged ---%d",aConnectionState);
}
/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice{
    NSLog(@"didLoginFromOtherDevice ");
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer {

    NSLog(@"didRemovedFromServer");

}
#pragma mark - 好友的申请-
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
    if (!error) {
        NSLog(@"发送同意成功");
    }
    NSLog(@"didReceiveFriendInvitationFromUsername   %@",aUsername);
}
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {
    NSLog(@"你可以和%@自由的聊天了",aUsername);
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername {


}


@end
