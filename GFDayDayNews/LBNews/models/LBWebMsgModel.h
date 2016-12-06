//
//  LBWebMsgModel.h
//  GFDayDayNews
//
//  Created by llb on 2016/12/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseModel.h"

@interface LBWebMsgModel : BaseModel

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 内容 */
@property (nonatomic, copy) NSString *body;
/** 配图 */
@property (nonatomic, strong) NSArray *img;
@end
