//
//  LBDownLoadingCell.m
//  GFDayDayNews
//
//  Created by llb on 2016/12/2.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBDownLoadingCell.h"

@implementation LBDownLoadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _progress.progress = 0.0;
}

- (void)setModel:(ZFFileModel *)model {
    _model = model;
//    NSString *currentSize = [ZFCommonHelper getFileSizeString:model.fileReceivedSize];
//    NSString *totalSize = [ZFCommonHelper getFileSizeString:model.fileSize];
    _titleLabel.text = model.fileName;
    if ([model.fileSize longLongValue] == 0 && !(model.downloadState == ZFDownloading)) {
        if (model.downloadState == ZFStopDownload) {
            [self.optionBtn setTitle:@"已暂停" forState:UIControlStateNormal];
        } else if (model.downloadState == ZFWillDownload) {
            [self.optionBtn setTitle:@"等待下载" forState:UIControlStateNormal];
        }
        self.progress.progress = 0.0;
        return;
    }

    // 下载进度
    float progress = (float)[model.fileReceivedSize longLongValue] / [model.fileSize longLongValue];
    _progress.progress = progress;
    
}
- (IBAction)optionBtnClick:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    ZFDownloadManager *mgr = [ZFDownloadManager sharedDownloadManager];
    if (_model.downloadState == ZFDownloading) {
        sender.selected = YES;
        [mgr stopRequest:self.request];
    }else {
        sender.selected = NO;
        [mgr resumeRequest:self.request];
    }
    if (_callBack) {
        _callBack();
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.userInteractionEnabled = YES;
    });
}


- (void)setCallBack:(optionBtnClick)callBack {
    _callBack = callBack;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
