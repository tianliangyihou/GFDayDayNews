//
//  LBDownLoadingCell.h
//  GFDayDayNews
//
//  Created by llb on 2016/12/2.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFDownloadManager.h"

typedef void(^optionBtnClick)(void);
@interface LBDownLoadingCell : UITableViewCell
@property(nonatomic,strong)ZFFileModel *model;
@property(nonatomic,strong)ZFHttpRequest *request;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionBtn;
@property(nonatomic,copy)optionBtnClick callBack;
- (void)setCallBack:(optionBtnClick)callBack;

@end
