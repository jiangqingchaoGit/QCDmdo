//
//  QCGroupDataViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/21.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupDataViewController.h"
//  群资料
@interface QCGroupDataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;


@end

@implementation QCGroupDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createCollectionView];
}

#pragma mark - initUI
- (void)initUI {
    
}
- (void)createCollectionView {
    
}
@end
