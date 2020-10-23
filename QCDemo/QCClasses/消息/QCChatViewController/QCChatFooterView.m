//
//  QCChatFooterView.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChatFooterView.h"

@interface QCChatFooterView ()<UITextViewDelegate>

@property (nonatomic, strong) UIButton * voiceButton;
@property (nonatomic, strong) UIButton * speakButton;
@property (nonatomic, strong) UITextView * contentTextView;
@property (nonatomic, strong) UIButton * expressionButton;
@property (nonatomic, strong) UIButton * functionButton;
@end
@implementation QCChatFooterView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(12), KSCALE_WIDTH(12), KSCALE_WIDTH(34), KSCALE_WIDTH(34))];
        self.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.voiceButton setImage:KHeaderImage forState:UIControlStateNormal];
        [self addSubview:self.voiceButton];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(7), KSCALE_WIDTH(213), KSCALE_WIDTH(44))];
        view.backgroundColor = KBACK_COLOR;
        [self addSubview:view];
        
        self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(13), KSCALE_WIDTH(213), KSCALE_WIDTH(32))];
        self.contentTextView.font = K_16_FONT;
        self.contentTextView.backgroundColor = KBACK_COLOR;
        self.contentTextView.delegate = self;
        [self addSubview:self.contentTextView];
        
        
    }
    return self;;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    
}



@end
