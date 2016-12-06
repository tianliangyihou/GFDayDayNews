//
//  LBCollectionViewCell.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBPhotosModel.h"
@interface LBCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong)LBPhotosModel *model;

@end
