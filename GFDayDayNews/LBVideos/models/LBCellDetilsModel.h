//
//  LBCellDetilsModel.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LBVideoResolutionModel.h"
@interface LBCellDetilsModel : NSObject


/** 标题 */
@property (nonatomic, copy  ) NSString *title;
/** 描述 */
@property (nonatomic, copy  ) NSString *video_description;
/** 视频地址 */
@property (nonatomic, copy  ) NSString *playUrl;
/** 封面图 */
@property (nonatomic, copy  ) NSString *coverForFeed;
/** 视频分辨率的数组 */
@property (nonatomic, strong) NSMutableArray *playInfo;

@property(nonatomic,assign)long long int duration;

@property(nonatomic,copy)NSString *category;



- (NSString *)timeLength ;
@end
