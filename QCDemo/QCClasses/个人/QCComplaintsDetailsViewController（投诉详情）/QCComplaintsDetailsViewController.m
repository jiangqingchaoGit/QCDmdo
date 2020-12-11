//
//  QCComplaintsDetailsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCComplaintsDetailsViewController.h"

@interface QCComplaintsDetailsViewController ()
@property (nonatomic, strong) NSArray * imageArr;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIButton * cancleButton;

@end

@implementation QCComplaintsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = @"投诉详情";
    self.view.backgroundColor = KBACK_COLOR;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight)];
    self.scrollView.backgroundColor = KBACK_COLOR;
    [self.view addSubview:self.scrollView];
    
    
    UIView * messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_HEIGHT(375), KSCALE_WIDTH(52))];
    messageView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.scrollView addSubview:messageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    label.text = @"投诉信息";
    label.font = K_14_FONT;
    label.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [messageView addSubview:label];
    
    NSString * statusStr;
    
    switch ([self.model.status intValue]) {
        case 1:
            statusStr = @"待处理";
            break;
        case 2:
            statusStr = @"处理中";

            break;
        case 3:
            statusStr = @"已处理";

            break;
        case 4:
            statusStr = @"已撤销";

            break;
            
        default:
            break;
    }
    NSArray * titleArr = @[@"投诉状态",@"投诉时间",@"投诉类型",@"投诉对象",@"投诉内容"];
    NSArray * messageArr = @[statusStr,self.model.create_time,self.model.type_name,self.model.targer_name,@""];

    for (NSInteger i = 0;i < 5; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(52) + i * KSCALE_WIDTH(42), KSCALE_WIDTH(100), KSCALE_WIDTH(42))];
        label.text = titleArr[i];
        label.font = K_14_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.scrollView addSubview:label];
        
        UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(52) + i * KSCALE_WIDTH(42), KSCALE_WIDTH(255), KSCALE_WIDTH(42))];
        messageLabel.text = messageArr[i];
        messageLabel.font = K_14_FONT;
        messageLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.scrollView addSubview:messageLabel];
        
        if (i == 0) {
            messageLabel.textColor = [QCClassFunction stringTOColor:@"#FFBA00"];
        }

    }
    
     UITextView * contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(262), KSCALE_WIDTH(335), KSCALE_WIDTH(120))];
    contentTextView.textColor = KTEXT_COLOR;
    contentTextView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    contentTextView.font = K_14_FONT;
    contentTextView.text = self.model.context;
    contentTextView.userInteractionEnabled = NO;
    [QCClassFunction filletImageView:contentTextView withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:contentTextView];
    
    if ([self.model.attrs isEqualToString:@""]) {
        
    }else{
        self.imageArr = [self.model.attrs componentsSeparatedByString:@","];

    }
    
    
    
    if (self.imageArr.count > 0) {
        for (int i = 0;  i < (int)ceil(self.imageArr.count / 4.0); i++) {
            for (int j = 0; j < 4; j++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20) + j * KSCALE_WIDTH(85), KSCALE_WIDTH(400) + i * KSCALE_WIDTH(90), KSCALE_WIDTH(80), KSCALE_WIDTH(80))];
                [QCClassFunction sd_imageView:imageView ImageURL:self.imageArr[i * 4 + j] AppendingString:@"" placeholderImage:@"header"];
                [self.scrollView addSubview:imageView];
            }
        }
    }



    
    UIView * replyView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(400) + (int)ceil(self.imageArr.count / 4.0) * KSCALE_WIDTH(90), KSCALE_HEIGHT(375), KSCALE_WIDTH(52))];
    replyView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.scrollView addSubview:replyView];
    
    UILabel * replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    replyLabel.text = @"反馈信息";
    replyLabel.font = K_14_FONT;
    replyLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [replyView addSubview:replyLabel];
    
    UILabel * conetentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(452) + (int)ceil(self.imageArr.count / 4.0) * KSCALE_WIDTH(80), KSCALE_WIDTH(335), KSCALE_WIDTH(100))];
    conetentLabel.text = self.model.handle_context?self.model.handle_context:@"";
    conetentLabel.font = K_14_FONT;
    conetentLabel.numberOfLines = 0;
    conetentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.scrollView addSubview:conetentLabel];
    
    
    self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(600) + (int)ceil(self.imageArr.count / 4.0) * KSCALE_WIDTH(80), KSCALE_WIDTH(345), KSCALE_WIDTH(52))];
    self.cancleButton.titleLabel.font = K_16_FONT;
    self.cancleButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.cancleButton setTitle:@"撤销投诉" forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.cancleButton withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.cancleButton];
    
    self.cancleButton.hidden = YES;

    switch ([self.model.status intValue]) {
        case 1:
            statusStr = @"待处理";
            self.cancleButton.hidden = NO;

            break;
        case 2:
            statusStr = @"处理中";

            break;
        case 3:
            statusStr = @"已处理";

            break;
        case 4:
            statusStr = @"已撤销";

            break;
            
        default:
            break;
    };
    
    self.scrollView.contentSize = CGSizeMake(KSCALE_WIDTH(375), KSCALE_WIDTH(700) + (int)ceil(self.imageArr.count / 4.0) * KSCALE_WIDTH(80));
}

- (void)cancleAction:(UIButton *)sender {
    NSString * str = [NSString stringWithFormat:@"id=%@&token=%@&uid=%@",self.model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"id":self.model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/complaintsrevoke" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        
        if ([responseObject[@"status"] intValue] == 1) {

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }



    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];

    }];
    
}



@end
