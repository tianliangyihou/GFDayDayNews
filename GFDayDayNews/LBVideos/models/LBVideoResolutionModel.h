//
//  LBVideoResolutionModel.h
//  GFDayDayNews
//
//  Created by llb on 2016/12/4.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseModel.h"

@interface LBVideoResolutionModel : BaseModel
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy  ) NSString  *name;
@property (nonatomic, copy  ) NSString  *type;
@property (nonatomic, copy  ) NSString  *url;
@end
