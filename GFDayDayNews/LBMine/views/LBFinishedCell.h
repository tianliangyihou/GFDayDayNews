//
//  LBFinishedCell.h
//  GFDayDayNews
//
//  Created by llb on 2016/12/2.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFDownloadManager.h"
@interface LBFinishedCell : UITableViewCell
@property(nonatomic,strong)ZFFileModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end
