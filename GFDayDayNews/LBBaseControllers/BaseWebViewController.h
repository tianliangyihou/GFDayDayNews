//
//  BaseWebViewController.h
//  GFDayDayNews
//
//  Created by llb on 2016/12/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController <UIWebViewDelegate>

@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,weak)UIWebView *webView;

@end
