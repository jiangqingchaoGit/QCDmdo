//
//  QCHomeReusableView.h
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCAdModel.h"
#import "QCBanModel.h"

/*
 *  滚动切换视图
 */
#import "GKCycleScrollView.h"
//#import <JXCategoryView/JXCategoryView.h>
#import "GKPageControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCHomeReusableView : UICollectionReusableView<GKCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
//  轮播图
@property (nonatomic, strong) GKCycleScrollView * cycleScrollView;
@property (nonatomic, strong) NSMutableArray * bannerData;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * classData;
@property (nonatomic, strong) NSMutableArray * advertisingData;

@property (nonatomic, strong) UIButton * advertisingButton;
@property (nonatomic, strong) UIButton * recommendedButton;
@property (nonatomic, strong) UIButton * limitButton;
@property (nonatomic, strong) UIView * lineView;

- (void)fillSize;


@end

NS_ASSUME_NONNULL_END
