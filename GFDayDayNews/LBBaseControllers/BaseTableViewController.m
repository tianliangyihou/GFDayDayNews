//
//  BaseTableViewController.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()



@end

@implementation BaseTableViewController


- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT - NAVBAR_HEIGHT)];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [self tableViewRegisterCellWithTableView:tableView];
        tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableViewRegisterCellWithTableView:(UITableView *)tableView {


}


@end
