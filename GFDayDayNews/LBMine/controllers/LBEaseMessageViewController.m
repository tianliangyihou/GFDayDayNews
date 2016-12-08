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
    self.delegate = self;
    self.dataSource = self;
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

#pragma - 代理方法-

//具体创建自定义Cell的样例：
- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
{
    return nil;
}

- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    return 0.f;
}



- (BOOL)messageViewController:(EaseMessageViewController *)viewController
        didSelectMessageModel:(id<IMessageModel>)messageModel {
    DLog(@"didSelectMessageModel");
    return NO;
}
- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    
    DLog(@"点击了头像");

}
//长按收拾回调样例：
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    //样例给出的逻辑是所有cell都允许长按
    return YES;
}
//具体样例：
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];//默认头像
    if ([message.from isEqualToString:[EMClient sharedClient].currentUsername]) {
        model.avatarURLPath = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1481184638&di=c8a8a9de81df48b1081edf5160ad4478&src=http://f.hiphotos.baidu.com/zhidao/pic/item/1c950a7b02087bf41fb5695ef1d3572c11dfcf2f.jpg";//头像网络地址
        model.nickname = @"狗剩";//用户昵称

    }else {
        model.nickname = @"大神";//用户昵称
        model.avatarURLPath = @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=412a4e9acb177f3e1061f40b40ff17ff/a2cc7cd98d1001e9a9e3c823ba0e7bec54e7973b.jpg";
    }
    return model;
}
@end
