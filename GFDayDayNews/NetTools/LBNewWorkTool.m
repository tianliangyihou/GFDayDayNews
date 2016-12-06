//
//  LBNewWorkTool.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBNewWorkTool.h"
#import "AFNetworking.h"
@implementation LBNewWorkTool

+ (void)getWithParams:(NSDictionary *)params urlString:(NSString *)urlString success:(successBlock)success fail:(failBlock)fail{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
//        NSLog(@"%@",error);
    }];

}

@end
