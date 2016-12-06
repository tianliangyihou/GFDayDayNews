//
//  LB_Header.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#ifndef LB_Header_h
#define LB_Header_h

/***/
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif

#define WEAK_SELF(type)  __weak typeof(type) weakSelf = self;

/**常量*/
#define  NAVBAR_HEIGHT 64
#define  TABBAR_HEIGHT 49

#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define APP_DEFAULT_COLOR  [UIColor colorWithRed:237/255.0 green:67/255.0 blue:83/255.0 alpha:1.0]


/** 头文件*/
#import "MJRefresh.h"
#import "LBNewWorkTool.h"
#import "ZFPlayer.h"
#import "MJExtension.h"
#import "UIView+Frame.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import <DKNightVersion/DKNightVersion.h>
#endif /* LB_Header_h */
