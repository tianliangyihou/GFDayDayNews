//
//  LBVideoCell.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBVideoCell.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "LB_Header.h"
@interface LBVideoCell ()<ZFPlayerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *watchCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property(nonatomic,weak) IBOutlet UIImageView *imgv;

@end

@implementation LBVideoCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self bringSubviewToFront:_imgBtn];
    _daysLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setModel:(LBCellDetilsModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    [_timeBtn setTitle:[NSString stringWithFormat:@"%@",model.timeLength] forState:UIControlStateNormal];
    _daysLabel.text = model.category;
    [_watchCountBtn setTitle:[NSString stringWithFormat:@"播放:%@",@"12"] forState:UIControlStateNormal];
    [_imgv sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed] placeholderImage:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

- (void)setPlayingCallBack:(LBCellisPlayingCallBack)playingCallBack {
    _playingCallBack = playingCallBack;
}

- (IBAction)playBtnClick:(UIButton *)sender {
    // model
    
    if (_playingCallBack) {
        _playingCallBack(self);
    }


}

- (void)cellStopPlayVideo {

//  [self.playerController stop]
}


@end
