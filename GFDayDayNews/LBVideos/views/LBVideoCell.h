//
//  LBVideoCell.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCellDetilsModel.h"
@class LBVideoCell;
typedef void(^LBCellisPlayingCallBack)( LBVideoCell *cell);
@interface LBVideoCell : UITableViewCell

@property(nonatomic,strong)LBCellDetilsModel *model;

@property(nonatomic,copy)LBCellisPlayingCallBack playingCallBack;

@property(nonatomic,weak)UITableView *tableView;

- (void)setPlayingCallBack:(LBCellisPlayingCallBack)playingCallBack;

- (void)cellStopPlayVideo;
@end
