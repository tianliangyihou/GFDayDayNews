
//
//  LBDowningVC.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBDowningVC.h"
#import "ZFDownloadManager.h"
#import "LBDownLoadingCell.h"
#import "LBFinishedCell.h"
#define  DownloadManager  [ZFDownloadManager sharedDownloadManager]

@interface LBDowningVC ()<ZFDownloadDelegate>
@property(nonatomic,strong)NSMutableArray *downloadObjectArr;

@end

@implementation LBDowningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    DownloadManager.downloadDelegate = self;
    [self tableView];
}

- (void)tableViewRegisterCellWithTableView:(UITableView *)tableView {
    NSString *ID  = NSStringFromClass([LBDownLoadingCell class]);
    NSString *ID1  = NSStringFromClass([LBFinishedCell class]);
    UINib *nib = [UINib nibWithNibName:ID bundle:nil];
    UINib *nib1 = [UINib nibWithNibName:ID1 bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
    [tableView registerNib:nib1 forCellReuseIdentifier:ID1];

}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self initData];
}

- (void)initData {
    [DownloadManager startLoad];
    NSMutableArray *downladed = DownloadManager.finishedlist;
    NSMutableArray *downloading = DownloadManager.downinglist;
    self.downloadObjectArr = @[].mutableCopy;
    [self.downloadObjectArr addObject:downloading];
    [self.downloadObjectArr addObject:downladed];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.downloadObjectArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.downloadObjectArr[section];
    return arr.count;
    
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        NSString *ID  = NSStringFromClass([LBDownLoadingCell class]);
        LBDownLoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        ZFHttpRequest *request = self.downloadObjectArr[indexPath.section][indexPath.row];
        ZFFileModel *fileInfo = [request.userInfo objectForKey:@"File"];
        cell.model = fileInfo;
        cell.request = request;
        WEAK_SELF(self);
        [cell setCallBack:^{
            [weakSelf initData];
        }];
        cell.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        return cell;
    }else {
        NSString *ID  = NSStringFromClass([LBFinishedCell class]);
        LBFinishedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        ZFFileModel *model = self.downloadObjectArr[indexPath.section][indexPath.row];
        cell.model = model;
        cell.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 57;
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)  return @"下载中";
    return @"下载完成";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *arr = self.downloadObjectArr.firstObject;
    if (arr.count ==0  && section == 0) return 0;
    return 30;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ZFFileModel *fileInfo = self.downloadObjectArr[indexPath.section][indexPath.row];
        [DownloadManager deleteFinishFile:fileInfo];
    }else if (indexPath.section == 0) {
        ZFHttpRequest *request = self.downloadObjectArr[indexPath.section][indexPath.row];
        [DownloadManager deleteRequest:request];
    }
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark -更新进度条-
// 开始下载
- (void)startDownload:(ZFHttpRequest *)request
{
    NSLog(@"~~~开始下载!~~~");
}
// 下载中
- (void)updateCellProgress:(ZFHttpRequest *)request
{
    ZFFileModel *fileInfo = [request.userInfo objectForKey:@"File"];
    [self performSelectorOnMainThread:@selector(updateCellOnMainThread:) withObject:fileInfo waitUntilDone:YES];
}
// 更新下载进度
- (void)updateCellOnMainThread:(ZFFileModel *)fileInfo
{
    NSArray *cellArr = [self.tableView visibleCells];
    for (id obj in cellArr) {
        if([obj isKindOfClass:[LBDownLoadingCell class]]) {
            LBDownLoadingCell *cell = (LBDownLoadingCell *)obj;
            if([cell.model.fileURL isEqualToString:fileInfo.fileURL]) {
                cell.model = fileInfo;
            }
        }
    }
}

// 下载完成
- (void)finishedDownload:(ZFHttpRequest *)request
{
    
    [self initData];
}

- (void)dealloc {
    DLog(@"界面被销毁了");
}

@end
