//
//  QCChatFooterView.h
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PPStickerInputView.h"
//#import "PPUtil.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCChatFooterView : UIView
@property (nonatomic, strong) UITextView * contentTextView;
@property (nonatomic, strong) NSString * keyboardStr;

- (void)packUp;
- (void)getParent;
- (void)updataSize;

- (void)sendTime;
- (void)storeMessageWithModel:(NSMutableDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
