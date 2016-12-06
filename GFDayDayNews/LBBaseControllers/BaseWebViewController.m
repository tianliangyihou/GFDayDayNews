//
//  BaseWebViewController.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

- (UIWebView *)webView {

    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, ScreenWidth, ScreenHeight - NAVBAR_HEIGHT)];
        webView.delegate = self;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    
}
@end
