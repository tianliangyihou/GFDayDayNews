//
//  LBCollectionViewCell.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface LBCollectionViewCell ()


@end

@implementation LBCollectionViewCell


- (void)setModel:(LBPhotosModel *)model {
    _model = model;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:nil];
    _titleLabel.text = model.title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
