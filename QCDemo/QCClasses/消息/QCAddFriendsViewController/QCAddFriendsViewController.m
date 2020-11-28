//
//  QCAddFriendsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddFriendsViewController.h"
#import "SWQRCodeConfig.h"
#import "SWQRCodeViewController.h"

//  搜索列表
#import "QCSearchViewController.h"
@interface QCAddFriendsViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView * searchView;
@property (nonatomic, strong) UITextField * searchTextField;

@end

@implementation QCAddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createSearchView];
    
}
- (void)initUI {
    self.title = @"添加好友";
    self.view.backgroundColor = KBACK_COLOR;
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(6), KSCALE_WIDTH(345) , KSCALE_WIDTH(38))];
    self.searchView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.view addSubview:self.searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(17), KSCALE_WIDTH(16) , KSCALE_WIDTH(16))];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [self.view addSubview:searchImageView];
    
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(6), KSCALE_WIDTH(300) , KSCALE_WIDTH(38))];
    self.searchTextField.placeholder = @"多多好/手机号";
    self.searchTextField.font = K_14_FONT;
    self.searchTextField.textColor = [QCClassFunction stringTOColor:@"#333333"];
    self.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchTextField.returnKeyType = UIReturnKeyDone;
    self.searchTextField.keyboardType =  UIKeyboardTypeASCIICapable;
    self.searchTextField.delegate = self;
    [self.view addSubview:self.searchTextField];
    
    NSArray * titleArr = @[@"微信邀请好友",@"扫一扫"];
    NSArray * imageArr = @[@"wechat",@"saoyisao"];

    for (NSInteger i = 0; i < 2; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(62) + i * KSCALE_WIDTH(72), KSCALE_WIDTH(375), KSCALE_WIDTH(62))];
        button.tag = i + 1;
        button.backgroundColor = KCLEAR_COLOR;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(62) + i * KSCALE_WIDTH(72), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [QCClassFunction filletImageView:imageView withRadius:KSCALE_WIDTH(26)];
        [self.view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(62) + KSCALE_WIDTH(72) * i, KSCALE_WIDTH(200), KSCALE_WIDTH(62))];
        label.text = titleArr[i];
        label.font = K_16_FONT;
        label.textColor = KTEXT_COLOR;
        [self.view addSubview:label];
    }
}


#pragma mark - tapAction
- (void)searchAction:(UIButton *)sender {
    
    QCSearchViewController * searchViewController = [[QCSearchViewController alloc] init];
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];

}
- (void)buttonAction:(UIButton *)sender {
    
    
    switch (sender.tag) {
        case 1:
            //  微信邀请好友
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];

            break;
        case 2:
            //  扫一扫
        {
            SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
            config.scannerType = SWScannerTypeBoth;
                        
            SWQRCodeViewController *qrcodeVC = [[SWQRCodeViewController alloc]init];
            qrcodeVC.codeConfig = config;
            [self.navigationController pushViewController:qrcodeVC animated:YES];
        }
            break;

            
        default:
            break;
    }
}

- (void)createSearchView {
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);

            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        //在这里做你响应return键的代码
        [self.searchTextField resignFirstResponder];
        QCSearchViewController * searchViewController = [[QCSearchViewController alloc] init];
        searchViewController.hidesBottomBarWhenPushed = YES;
        searchViewController.searchStr = self.searchTextField.text;
        
        [self.navigationController pushViewController:searchViewController animated:YES];
        self.searchTextField.text = nil;
        return NO;
    }
    return YES;
}

@end
