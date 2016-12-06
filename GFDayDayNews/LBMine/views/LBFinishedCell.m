
//
//  LBFinishedCell.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/2.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBFinishedCell.h"

@implementation LBFinishedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZFFileModel *)model {
    _model = model;
    NSString *totalSize = [ZFCommonHelper getFileSizeString:model.fileSize];
    _titleLabel.text = model.fileName;
    _sizeLabel.text =totalSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
