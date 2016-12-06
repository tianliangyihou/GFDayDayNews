//
//  BaseTableViewController.h
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datas;


- (void)tableViewRegisterCellWithTableView:(UITableView *)tableView;


@end
