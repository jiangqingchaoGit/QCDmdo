//
//  QCGroupChatFooterView.h
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupChatFooterView : UIView
@property (nonatomic, strong) UITextView * contentTextView;
@property (nonatomic, strong) NSString * keyboardStr;

- (void)packUp;
- (void)getParent;
- (void)updataSize;

- (void)sendTime;
- (void)storeMessageWithModel:(NSMutableDictionary *)dataDic;

- (void)banned;
- (void)disBanned;
@end

NS_ASSUME_NONNULL_END
