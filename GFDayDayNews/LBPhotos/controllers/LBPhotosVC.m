//
//  LBPhotosVC.m
//  GFDayDayNews
//
//  Created by llb on 2016/11/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "LBPhotosVC.h"
#import "HMWaterflowLayout.h"
#import "LBCollectionViewCell.h"
#import "LBPhotosModel.h"
#import "MWPhotoBrowser.h"
@interface LBPhotosVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *datas;

@property(nonatomic,strong)NSMutableArray *imgs;


@end

@implementation LBPhotosVC


- (NSMutableArray *)datas {
    if (!_datas) {
        
        _datas = [[NSMutableArray alloc]init];
        
    }
    return _datas;
}


- (UICollectionView *)collectionView {

    if (!_collectionView) {
    
        HMWaterflowLayout *flowLayout = [[HMWaterflowLayout alloc]init];
        [flowLayout setHeightBlock:^CGFloat(CGFloat width, NSIndexPath *indexPath) {
            LBPhotosModel *model = self.datas[indexPath.row];
                CGFloat imgWith = (SCREEN_WIDTH - 16) / 2.0;
                CGFloat imgHeight = (model.mid_height * imgWith / (model.image_width * 1.0));
                return imgHeight;
        }];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, ScreenHeight - NAVBAR_HEIGHT - 49) collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        NSString *ID = NSStringFromClass([LBCollectionViewCell class]);
        UINib *nib = [UINib nibWithNibName:ID bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
        collectionView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self initDatas];
    
}

- (void)initDatas {
    
    WEAK_SELF(self);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"pn"] = @"0";
    dic[@"rn"] = @60;
    NSString *tag1 = @"美女";
    NSString *tag2 = @"性感";
    NSString *urlstr = [NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",tag1,tag2];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [LBNewWorkTool getWithParams:dic urlString:urlstr success:^(id responseObject) {
        NSArray *modelArr = [LBPhotosModel mj_objectArrayWithKeyValuesArray:responseObject[@"imgs"]];
        [self.datas addObjectsFromArray:modelArr];
        [weakSelf.collectionView reloadData];
    } fail:^(id error) {
        DLog(@"%@",error);
    }];
    
    
}

#pragma mark -  collection的代理方法-

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = NSStringFromClass([LBCollectionViewCell class]);
    LBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_imgs == nil){
        NSMutableArray *imgs = [[NSMutableArray alloc]init];
        for (LBPhotosModel *model in self.datas) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.image_url]];
            photo.caption = model.title;
            [imgs addObject:photo];
        }
        _imgs = imgs;
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:_imgs];
    browser.zoomPhotosToFill = NO;
    browser.enableGrid = YES;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:indexPath.row];
    [self.navigationController pushViewController:browser animated:YES];
}




@end
