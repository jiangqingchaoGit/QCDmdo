//
//  QCRollingView.h
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCRollingView : UIView
@property (nonatomic, strong) NSMutableArray * imageArr;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

NS_ASSUME_NONNULL_END
