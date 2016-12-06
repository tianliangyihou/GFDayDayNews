//
//  LBwebImgModel.h
//  GFDayDayNews
//
//  Created by llb on 2016/12/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseModel.h"

@interface LBwebImgModel : BaseModel
@property (nonatomic, copy) NSString *src;
/** 图片尺寸 */
@property (nonatomic, copy) NSString *pixel;
/** 图片所处的位置 */
@property (nonatomic, copy) NSString *ref;
@end
