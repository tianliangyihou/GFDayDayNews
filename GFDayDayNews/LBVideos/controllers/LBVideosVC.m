//
//  LBVideosVC.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBVideosVC.h"
#import "LBVideoCell.h"
#import "LBVideoHeader.h"
#import "LBVideoCellModel.h"
#import "ZFDownloadManager.h"


@interface LBVideosVC ()<ZFPlayerDelegate>
@property(nonatomic,strong)NSIndexPath *lastIndexPath;

@property(nonatomic,strong)ZFPlayerView *playerView;

@property(nonatomic,strong)ZFPlayerControlView *playerController;

@property(nonatomic,strong)ZFPlayerModel *playerModel;

@end

@implementation LBVideosVC


/**
 这里使用三方库 zfplayer
 */
- (ZFPlayerView *)playerView {
    if (!_playerView) {
        ZFPlayerView *playerView = [ZFPlayerView sharedPlayerView];
        _playerView = playerView;
    }
    return _playerView;
}

- (ZFPlayerControlView *)playerController {
    
    if (!_playerController) {
        _playerController = [[ZFPlayerControlView alloc]init];
    }
    return _playerController;
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc]init];
    }
    return _playerModel;
}


- (void)tableViewRegisterCellWithTableView:(UITableView *)tableView {
    NSString *ID = NSStringFromClass([LBVideoCell class]);
    UINib *nib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.tableHeaderView = ({
        LBVideoHeader *header = [LBVideoHeader videoHeader];
        header;
    });
    [self requestData];
}

- (void)requestData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *videoList = [rootDict objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        LBCellDetilsModel *model = [[LBCellDetilsModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        [self.datas addObject:model];
    }
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
    
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF(self);
    NSString *ID = NSStringFromClass([LBVideoCell class]);
    LBVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    cell.model = self.datas[indexPath.row];
    [cell setPlayingCallBack:^(LBVideoCell *cell) {
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = cell.model.title;
        playerModel.videoURL         = [NSURL URLWithString:cell.model.playUrl];
        playerModel.placeholderImageURLString = cell.model.coverForFeed;
        playerModel.tableView        = weakSelf.tableView;
        playerModel.indexPath        = [weakSelf.tableView indexPathForCell:cell];
        // player的父视图
        playerModel.fatherView       = cell;
        [weakSelf.playerView playerControlView:weakSelf.playerController playerModel:playerModel];
        // delegate
        weakSelf.playerView.delegate = self;
        // auto play the video
        [weakSelf.playerView autoPlayTheVideo];
        weakSelf.playerView.hasDownload = YES;
    }];
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 164;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 播放的点击事件-
/** 返回按钮事件 */
- (void)zf_playerBackAction {
    
    DLog(@"点击返回按钮了");
    
}
/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url {
    
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [self.playerView resetPlayer];
}

@end
