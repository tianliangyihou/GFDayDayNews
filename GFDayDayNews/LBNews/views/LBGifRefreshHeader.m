
//
//  LBGifRefreshHeader.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBGifRefreshHeader.h"

@implementation LBGifRefreshHeader

- (void)prepare {
    [super prepare];
    NSMutableArray *beginLoadArr = [[NSMutableArray alloc]init];
    for (int i = 1 ; i <= 60; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"dropdown_anim__000%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [beginLoadArr addObject:image];
    }
    [self setImages:beginLoadArr forState:MJRefreshStateIdle];
    
    NSMutableArray *pullingArr = [[NSMutableArray alloc]init];
    for (int i = 1 ; i <= 3; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_0%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [pullingArr addObject:image];
    }
    [self setImages:pullingArr forState:MJRefreshStatePulling];
    [self setImages:pullingArr forState:MJRefreshStateRefreshing];
    
}

@end
