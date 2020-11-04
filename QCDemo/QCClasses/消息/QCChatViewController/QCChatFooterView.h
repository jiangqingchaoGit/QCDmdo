//
//  QCChatFooterView.h
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCChatFooterView : UIView
@property (nonatomic, strong) UITextView * contentTextView;
- (void)packUp;
- (void)getParent;

@end

NS_ASSUME_NONNULL_END
