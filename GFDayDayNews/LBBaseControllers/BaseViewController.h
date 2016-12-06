//
//  BaseViewController.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LB_Header.h"
#import "UIView+Frame.h"
@interface BaseViewController : UIViewController
- (UIButton *)setNavBarRightWithTitle:(NSString *)title andSelectedTitle:(NSString *)selectedTitle;
- (void)rightBarButtonClick:(UIButton *)btn;
@end
