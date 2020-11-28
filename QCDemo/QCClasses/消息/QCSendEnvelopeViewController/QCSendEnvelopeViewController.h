//
//  QCSendEnvelopeViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SendBlock)(NSMutableDictionary * envelopeDic);

@interface QCSendEnvelopeViewController : UIViewController
@property (nonatomic, strong) NSString * type;
@property (nonatomic, copy)SendBlock myBlock;

@end

NS_ASSUME_NONNULL_END
