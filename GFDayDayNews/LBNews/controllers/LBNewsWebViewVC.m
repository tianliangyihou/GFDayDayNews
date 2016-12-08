
//
//  LBNewsWebViewVC.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBNewsWebViewVC.h"
#import "LBWebMsgModel.h"
#import "LBwebImgModel.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface LBNewsWebViewVC ()
@property(nonatomic,assign)int fontSize;

@end

@implementation LBNewsWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.urlString.length == 0 || self.urlString == nil) {
        DLog(@"urlString 不存在 ");
    }
    _fontSize = 100;
    WEAK_SELF(self);
    [LBNewWorkTool getWithParams:nil urlString:self.urlString success:^(id responseObject) {
        LBWebMsgModel *model = [LBWebMsgModel mj_objectWithKeyValues:responseObject[self.docid]];
        [weakSelf loadMsgInWebViewWithModel:model];
    } fail:^(id error) {
        
    }];
   
}

- (void)btnClick:(UIButton *)btn {
    _fontSize = _fontSize + 10;
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",_fontSize];
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    
}

- (void)loadMsgInWebViewWithModel:(LBWebMsgModel *)model {
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Detail.css" withExtension:nil];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",url];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self handledBodyWithModel:model]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)handledBodyWithModel:(LBWebMsgModel *)model {
    
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",model.title];
    [body appendFormat:@"<div class=\"time\">%@<div>",model.ptime];
    if (model.body) {
        [body appendString:model.body];
    }
    
    for (LBwebImgModel *imgModel  in model.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        NSArray *pixel = [imgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [pixel.firstObject floatValue];
        CGFloat height = [pixel.lastObject floatValue];
        CGFloat maxWidth = SCREEN_WIDTH * 0.96;
        if (width > maxWidth) {
            height = maxWidth/width * height;
            width = maxWidth;
        }
        NSString *onload = @"this.onclick = function() {\
        lbImageClick(this.src);\
        };";
        [imgHtml appendFormat:@"<img class=\"imgs\" onload=\"%@\" width=\"95%%\" height=\"auto\" src=\"%@\">",onload,imgModel.src];
        [imgHtml appendString:@"</div>"];
        [body replaceOccurrencesOfString:imgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];

    }
    return body;
}


#pragma mark - 拦截链接

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePictureToAlbum:src];
        return NO;
    }
    return YES;
}

- (void)savePictureToAlbum:(NSString *)src {

     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != NULL) {
        DLog(@"下载失败");
    }else {
        DLog(@"保存成功");
    }
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIBarButtonItem *rightSharBt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(btnClick:)];
    NSArray *buttonItem = @[rightSharBt];
    self.navigationItem.rightBarButtonItems = buttonItem;
    [super webViewDidFinishLoad:webView];
    JSContext *context = [webView  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"lbImageClick"] = ^(NSString *src) {
        
        [self savePictureToAlbum:src];
        
    };
//    NSString *jsGetImages = @"function getImages(){\
//    var objs = document.getElementsByTagName(\"img\"); \
//    for(var i = 0 ; i <objs.length; i++){\
//    objs[i].onclick = function(){\
//    \
//    }\
//    }\
//    return objs.length;\
//    }";
//    
//     [webView stringByEvaluatingJavaScriptFromString:jsGetImages];
//    NSString *length = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
//    DLog(@"%@",length);
    
}

@end
