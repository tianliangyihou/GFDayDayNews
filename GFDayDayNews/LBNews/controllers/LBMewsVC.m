//
//  LBMewsVC.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBMewsVC.h"
#import "LBNewsCell.h"
#import "LBGifRefreshHeader.h"
#import "LBNewsModel.h"
#import "LBNewsWebViewVC.h"
@interface LBMewsVC ()

@end

@implementation LBMewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WEAK_SELF(self);
    LBGifRefreshHeader *header = [LBGifRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.header = header;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.tableView.footer endRefreshing];
    }];
    [self initWithDatas];
}


- (void)initWithDatas {
    WEAK_SELF(self);
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    dic[@"page"] = @"1";
//    NSString *urlstr = [NSString stringWithFormat:@"http://api.huceo.com/%@/other/?key=c32da470996b3fdd742fabe9a2948adb&num=20",@"guonei"];
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%d-20.html",30];
    [LBNewWorkTool getWithParams:nil urlString:urlStr success:^(id responseObject) {
        DLog(@"%@",responseObject);
        LBNewsModel *model = [LBNewsModel mj_objectWithKeyValues:responseObject];
        [self.datas addObjectsFromArray:model.T1348647853363];
        [weakSelf.tableView reloadData];
    } fail:^(id error) {
        
        
    }];

}



- (void)tableViewRegisterCellWithTableView:(UITableView *)tableView {
    NSString *ID  = NSStringFromClass([LBNewsCell class]);
    UINib *nib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
    
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID  = NSStringFromClass([LBNewsCell class]);
    LBNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    cell.model = self.datas[indexPath.row];
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBNewsDetilsModel *model = self.datas[indexPath.row];
    LBNewsWebViewVC *webViewVC = [[LBNewsWebViewVC alloc]init];
    webViewVC.urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",model.docid];
    webViewVC.docid = model.docid;
    [self.navigationController pushViewController:webViewVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
