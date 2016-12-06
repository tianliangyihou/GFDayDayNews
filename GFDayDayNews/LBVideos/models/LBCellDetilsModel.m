
//
//  LBCellDetilsModel.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBCellDetilsModel.h"

@implementation LBCellDetilsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // 转换系统关键字description
    if ([key isEqualToString:@"description"]) {
        self.video_description = [NSString stringWithFormat:@"%@",value];
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"playInfo"]) {
        self.playInfo = @[].mutableCopy;
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dataDic in value) {
            LBVideoResolutionModel *resolution = [[LBVideoResolutionModel alloc] init];
            [resolution setValuesForKeysWithDictionary:dataDic];
            [array addObject:resolution];
        }
        [self.playInfo removeAllObjects];
        [self.playInfo addObjectsFromArray:array];
    } else if ([key isEqualToString:@"title"]) {
        self.title = value;
    } else if ([key isEqualToString:@"playUrl"]) {
        self.playUrl = value;
    } else if ([key isEqualToString:@"coverForFeed"]) {
        self.coverForFeed = value;
    }else if ([key isEqualToString:@"duration"]) {
        self.duration = [value longLongValue];
    }else if ([key isEqualToString:@"category"]) {
        self.category = value;
    }


    
}

- (NSString *)timeLength {
    long long int time = _duration;
    int mins = time / 60;
    int sec = time % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",mins,sec];
}

@end
