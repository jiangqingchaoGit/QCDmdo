//
//  QCHomeReusableView.m
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHomeReusableView.h"
#import "QCClassItem.h"
#import "QCHtmlUrlViewController.h"
@implementation QCHomeReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createRollView];
        [self createCollectionView];
        [self createButton];
    }
    return self;
}
#pragma mark - tapAction
- (void)advertisingAction:(UIButton *)sender {
    //  广告图的点击事件
    //    QCHtmlUrlViewController * htmlUrlViewController = [[QCHtmlUrlViewController alloc] init];
    //    htmlUrlViewController.hidesBottomBarWhenPushed = YES;
    //    [[QCClassFunction parentController:self].navigationController pushViewController:htmlUrlViewController animated:YES];
    
}

- (void)recommendedAction:(UIButton *)sender {

    
    
    
}



- (void)limitAction:(UIButton *)sender {
    

}

#pragma mark - initUI
- (void)createRollView {
    self.cycleScrollView = [[GKCycleScrollView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(16), KSCREEN_WIDTH , KSCALE_WIDTH(130))];
    self.cycleScrollView.backgroundColor = [UIColor clearColor];
    self.cycleScrollView.dataSource = (id)self;
    self.cycleScrollView.delegate = (id)self;
    self.cycleScrollView.isChangeAlpha = NO;
    self.cycleScrollView.isAutoScroll = YES;
    self.cycleScrollView.isInfiniteLoop = YES;
    self.cycleScrollView.leftRightMargin = KSCALE_WIDTH(32);
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView reloadData];
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KSCALE_WIDTH(55),KSCALE_WIDTH(65));
    layout.minimumInteritemSpacing = KSCALE_WIDTH(10);
    layout.minimumLineSpacing =  KSCALE_WIDTH(15);
    layout.sectionInset = UIEdgeInsetsMake(0, KSCALE_WIDTH(30), 0, KSCALE_WIDTH(30));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,KSCALE_WIDTH(166),KSCALE_WIDTH(375),KSCALE_WIDTH(145)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = KBACK_COLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    
    [self.collectionView registerClass:[QCClassItem class] forCellWithReuseIdentifier:@"item"];
    
    [self addSubview:self.collectionView];
}

- (void)createButton {
    self.advertisingButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(330), KSCALE_WIDTH(345), KSCALE_WIDTH(125))];
    [self.advertisingButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.advertisingButton addTarget:self action:@selector(advertisingAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.advertisingButton withRadius:KSCALE_WIDTH(20)];
    [self addSubview:self.advertisingButton];
    
    self.recommendedButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(485), KSCALE_WIDTH(90), KSCALE_WIDTH(30))];
    [self.recommendedButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.recommendedButton setImage:KHeaderImage forState:UIControlStateSelected];
    [self.recommendedButton setTitle:@"多多推荐" forState:UIControlStateNormal];
    [self.recommendedButton addTarget:self action:@selector(recommendedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.recommendedButton];
    
    self.limitButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(485), KSCALE_WIDTH(90), KSCALE_WIDTH(30))];
    [self.limitButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.limitButton setImage:KHeaderImage forState:UIControlStateSelected];
    [self.limitButton setTitle:@"限时秒杀" forState:UIControlStateNormal];
    [self.limitButton addTarget:self action:@selector(limitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.limitButton];
    
    //    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(330), KSCALE_WIDTH(90), KSCALE_WIDTH(5))];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(515), KSCALE_WIDTH(90), KSCALE_WIDTH(5))];
    
    self.lineView.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    [self addSubview:self.lineView];
    
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCClassItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}




#pragma mark - GKCycleScrollViewDataSource

- (NSInteger)numberOfCellsInCycleScrollView:(GKCycleScrollView *)cycleScrollView {
    return 10;
}

- (void)cycleScrollView:(GKCycleScrollView *)cycleScrollView didSelectCellAtIndex:(NSInteger)index {
    
    
    
    
}
- (GKCycleScrollViewCell *)cycleScrollView:(GKCycleScrollView *)cycleScrollView cellForViewAtIndex:(NSInteger)index {
    GKCycleScrollViewCell *cell = [cycleScrollView dequeueReusableCell];
    if (!cell) {
        cell = [GKCycleScrollViewCell new];
        cell.layer.cornerRadius = KSCALE_WIDTH(10.0f);
        cell.layer.masksToBounds = YES;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
    }
    
    //    QCBannerModel * model = self.bannerData[index];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    cell.imageView.image = KHeaderImage;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.layer.cornerRadius = KSCALE_WIDTH(10.0f);
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

@end


