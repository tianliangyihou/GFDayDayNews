//
//  LBMineMsgVC.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBMineMsgVC.h"
#import "LBDowningVC.h"
#import "EMSDK.h"
#import "LBLoginViewController.h"

#define HEADER_HEIGHT 200.0

@interface LBMineMsgVC ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIImageView *headerImageView;

@property(nonatomic,strong)LBDowningVC *downingVC;

@end

@implementation LBMineMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(HEADER_HEIGHT, 0, 0, 0);
     UIImageView *imgV = ({
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -HEADER_HEIGHT, SCREEN_WIDTH, HEADER_HEIGHT)];
        imgV.image = [UIImage imageNamed:@"shouyemoren"];
        _headerImageView = imgV;
        imgV;
    });
    [self.tableView addSubview:imgV];
    UIButton *btn = [self setNavBarRightWithTitle:@"夜间" andSelectedTitle:@"白天"];
    if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:@"NORMAL"]) {
        btn.selected = NO;
    }else {
        btn.selected = YES;
    }
    DLog(@"%@",[DKNightVersionManager sharedManager].themeVersion);
}


#pragma mark -设置夜间模式-

- (void)rightBarButtonClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [DKNightVersionManager sharedManager].themeVersion = DKThemeVersionNight;
        
    }else {
        [DKNightVersionManager sharedManager].themeVersion = DKThemeVersionNormal;

    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"haha"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"haha"];
        cell.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"下载进度";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"登陆后聊天";
    }else {
        cell.textLabel.text = @"测试";
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 1) {
        LBLoginViewController *login = [[LBLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
    
    if (indexPath.row != 0 ) return;
    if (self.downingVC == nil) {
        LBDowningVC *downVC = [[LBDowningVC alloc]init];
        self.downingVC = downVC;
    }
    [self.navigationController pushViewController:self.downingVC animated:YES];
}

#pragma mark - scrolllerViewDelegate-

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsety = scrollView.contentOffset.y;
    DLog(@"%f",offsety);
    if (offsety >= -HEADER_HEIGHT) return;
    offsety = - offsety;
    _headerImageView.top = -offsety;
    _headerImageView.height = offsety;
    _headerImageView.width = SCREEN_WIDTH *(_headerImageView.height / HEADER_HEIGHT);
    _headerImageView.centerX = SCREEN_WIDTH/2.0;
}




@end
