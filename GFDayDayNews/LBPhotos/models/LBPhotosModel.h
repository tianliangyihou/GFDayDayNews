//
//  LBPhotosModel.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBPhotosModel : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *image_url;

@property(nonatomic,copy)NSString *mid_url;

@property(nonatomic,assign)int image_width;

@property(nonatomic,assign)int mid_height;

@end
