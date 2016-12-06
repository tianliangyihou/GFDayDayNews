//
//  LBNewWorkTool.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id responseObject);
typedef void(^failBlock)(id error);
@interface LBNewWorkTool : NSObject

+ (void)getWithParams:(NSDictionary *)params urlString:(NSString *)urlString success:(successBlock)success fail:(failBlock)fail;

@end
