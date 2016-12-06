//
//  LBVideoHeader.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderBlock)(UIButton *btn);
@interface LBVideoHeader : UIView

@property(nonatomic,copy)HeaderBlock headerCallBack;

+ (LBVideoHeader *)videoHeader;

- (void)setHeaderCallBack:(HeaderBlock)headerCallBack;

@end
