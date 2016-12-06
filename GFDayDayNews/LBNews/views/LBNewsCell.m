//
//  LBNewsCell.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBNewsCell.h"
#import "UIImageView+WebCache.h"
@interface LBNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWitdth;
@end

@implementation LBNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _iconImageV.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageV.clipsToBounds = YES;
}

- (void)setModel:(LBNewsDetilsModel *)model {
    _model = model;
    _titleLable.text = model.title;
    if (model.imgsrc.length > 0 && model.imgsrc) {
        _imageWitdth.constant = 68;
    }else {
        _imageWitdth.constant = 0;
    }
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

@end
