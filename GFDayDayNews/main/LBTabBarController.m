
//
//  LBTabBarController.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBTabBarController.h"
#import "LBMineMsgVC.h"
#import "LBMewsVC.h"
#import "LBPhotosVC.h"
#import "LBVideosVC.h"
#import "LBNavigationController.h"
@interface LBTabBarController ()

@end

@implementation LBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configTabberControllers];
}


- (void)configTabberControllers {
    
    LBNavigationController *newsNav = [self targetVCforTabber:[LBMewsVC class] andWithTabberTitle:@"新闻" andWithNormalImg:@"tabbar_news" andWithSelectedImg:@"tabbar_news_hl"];
    
    LBNavigationController *photoNav = [self targetVCforTabber:[LBPhotosVC class] andWithTabberTitle:@"图片" andWithNormalImg:@"tabbar_picture" andWithSelectedImg:@"tabbar_picture_hl"];
    
    LBNavigationController *videoNav =[self targetVCforTabber:[LBVideosVC class] andWithTabberTitle:@"视频" andWithNormalImg:@"tabbar_video" andWithSelectedImg:@"tabbar_video_hl"];
    
    LBNavigationController *mineNav = [self targetVCforTabber:[LBMineMsgVC class] andWithTabberTitle:@"我的" andWithNormalImg:@"tabbar_setting" andWithSelectedImg:@"tabbar_setting_hl"];
    self.tabBar.tintColor = APP_DEFAULT_COLOR;
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    self.viewControllers = @[newsNav,photoNav,videoNav,mineNav];
}


/**返回目标控制器*/
- (LBNavigationController *)targetVCforTabber:(Class)VCClass andWithTabberTitle:(NSString *)title andWithNormalImg:(NSString *)normalImg andWithSelectedImg:(NSString *)selectedImg{
    UIViewController *vc = [[VCClass alloc] init];
    LBNavigationController *nav = [[LBNavigationController alloc]initWithRootViewController:vc];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:normalImg]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return nav;
}



@end
