//
//  LBVideoHeader.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/29.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBVideoHeader.h"
#import "LB_Header.h"

@implementation LBVideoHeader

+ (LBVideoHeader *)videoHeader {
    return  [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        self.backgroundColor = [UIColor whiteColor];
        [self initCategoryCellView];
    }
    return self;
}

- (void)initCategoryCellView {
    NSArray *imageNames = @[@"mingxing",@"qiche",@"sheji",@"sheying"];
    NSArray *titles = @[@"奇葩",@"萌物",@"美女",@"精品"];
    for (int i = 0 ; i < imageNames.count; i ++) {
       UIView *cell = [self categoryCellWithTitles:titles[i] andWithImage:[UIImage imageNamed:imageNames[i]] andWithTag:i];
        [self addSubview:cell];
    }

}


- (UIView *)categoryCellWithTitles:(NSString *)title andWithImage:(UIImage *)image andWithTag:(int)tag {
    UIView *cell = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4.0, 60)];
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setBackgroundImage:image forState:UIControlStateNormal];
    imageBtn.frame = CGRectMake(0, 0, 40, 40);
    imageBtn.tag = tag;
    [imageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageBtn.left, imageBtn.bottom,SCREEN_WIDTH/4.0, 20)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    cell.left = tag*cell.width;
    imageBtn.centerX = cell.width/2.0;
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [cell addSubview:imageBtn];
    [cell addSubview:titleLabel];
    return cell;
}

- (void)setHeaderCallBack:(HeaderBlock)headerCallBack {
    _headerCallBack = headerCallBack;
}

- (void)btnClick:(UIButton *)btn {
    DLog(@"-------%d------",btn.tag);
    if (_headerCallBack) {
        _headerCallBack(btn);
    }
}

@end
