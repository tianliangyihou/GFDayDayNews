

//
//  LBNavigationController.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBNavigationController.h"
#import "BaseViewController.h"
#import  "LBMewsVC.h"
@interface LBNavigationController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) BaseViewController* currentShowVC;

@end

@implementation LBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WEAK_SELF(self);
    self.delegate = weakSelf;
    self.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = NO;
}
@end
