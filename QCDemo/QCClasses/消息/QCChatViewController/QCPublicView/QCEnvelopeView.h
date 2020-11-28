//
//  QCEnvelopeView.h
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCEnvelopeView : UIView

@property (nonatomic, strong) QCChatModel * model;

- (void)grabEnvelopeWithStatus:(NSString *)envelopeStatus withModel:(QCChatModel *)chatModel;;
@end

NS_ASSUME_NONNULL_END
