//
//  QCPersonCodeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonCodeViewController.h"
#import "QCGroupSetModel.h"
@interface QCPersonCodeViewController ()
//  我的二维码
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UILabel * idLabel;
@property (nonatomic, strong) UIImageView * codeImageView;
@property (nonatomic, strong) NSString * codeStr;

@end

@implementation QCPersonCodeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    if (self.groupDataArr) {
        [self GETGroupDATA];
    }else{
        [self GETDATA];
    }
    
}
#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/setcode" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            self.codeStr  = responseObject[@"data"][@"code"];
            [self logoQrCode];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)GETGroupDATA {
    QCGroupSetModel * model = [self.groupDataArr firstObject];
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head_img AppendingString:nil placeholderImage:@"header"];
    self.nickLabel.text = model.name;
    self.idLabel.text = [NSString stringWithFormat:@"群号:%@",model.group_code];
    self.codeStr  = model.code;
    [self logoQrCode];

    
}

#pragma mark - tapAction
- (void)backAction:(UIButton *)sender {
    
}



- (void)share
{

    
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession Withtag:0];

    
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType Withtag:(NSInteger)tag
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //设置分享的图片
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIImage *image = [self snapshot:window/*你要截取的视图*/];
    
    shareObject.shareImage = image;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
//        [self.photoIV removeFromSuperview];
//        self.button.hidden = NO;
//        self.photoIV = nil;
    }];
}

//ShareMenuViewDelegate
- (void)UMSocialShareMenuViewDidDisappear {

}





- (void)buttonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            //  保存
        {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIImage *image = [self snapshot:window/*你要截取的视图*/];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }
            break;
        case 2:
            //  分享
            [self share];
            break;
            
        default:
            break;
    }
}

#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(266) + KTabHight)];
    backView.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.view addSubview:backView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    
    UIView * codeView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(37.5), KNavHight + KSCALE_WIDTH(35), KSCALE_WIDTH(300), KSCALE_WIDTH(470))];
    codeView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:codeView withRadius:KSCALE_WIDTH(6)];
    [self.view addSubview:codeView];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(36), KSCALE_WIDTH(80), KSCALE_WIDTH(80))];
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:K_HEADIMAGE AppendingString:nil placeholderImage:@"header"];

    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(40)];
    [codeView addSubview:self.headerImageView];
    
    self.nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(130), KSCALE_WIDTH(300), KSCALE_WIDTH(30))];
    self.nickLabel.text = K_NICK;
    
    self.nickLabel.font = K_18_BFONT;
    self.nickLabel.textAlignment = NSTextAlignmentCenter;
    self.nickLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [codeView addSubview:self.nickLabel];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(160), KSCALE_WIDTH(300), KSCALE_WIDTH(30))];
    self.idLabel.text = [NSString stringWithFormat:@"多多号:%@",K_ACCOUNT];
    self.idLabel.font = K_14_FONT;
    self.idLabel.textAlignment = NSTextAlignmentCenter;
    self.idLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [codeView addSubview:self.idLabel];


    self.codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(88), KSCALE_WIDTH(210), KSCALE_WIDTH(124), KSCALE_WIDTH(124))];
    [codeView addSubview:self.codeImageView];
    
    UILabel * codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(340), KSCALE_WIDTH(300), KSCALE_WIDTH(20))];
    codeLabel.text = @"我的多多专属二维码";
    codeLabel.font = K_14_FONT;
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [codeView addSubview:codeLabel];
    
    //  https://www.jianshu.com/p/51b9c624aa61 按钮和图片
    NSArray * imageArr = @[@"store",@"share"];
    NSArray * titleArr = @[@"保存",@"分享"];

    for (NSInteger i = 0; i < 2; i++) {


        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i * KSCALE_WIDTH(150) + KSCALE_WIDTH(40), KSCALE_WIDTH(380), KSCALE_WIDTH(70), KSCALE_WIDTH(70))];
        view.backgroundColor = [UIColor clearColor];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(17), 0, KSCALE_WIDTH(36), KSCALE_WIDTH(36))];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(40), KSCALE_WIDTH(70), KSCALE_WIDTH(20))];
        label.text = titleArr[i];
        label.font = K_14_FONT;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [view addSubview:label];
        [codeView addSubview:view];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * KSCALE_WIDTH(150) + KSCALE_WIDTH(40), KSCALE_WIDTH(380), KSCALE_WIDTH(70), KSCALE_WIDTH(70))];
        button.tag = i + 1;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [codeView addSubview:button];

    }
    
}



-(void)logoQrCode{
    
    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrImageFilter setDefaults];
    NSData *qrImageData = [self.codeStr dataUsingEncoding:NSUTF8StringEncoding];
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    CIImage *qrImage = [qrImageFilter outputImage];
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    UIGraphicsBeginImageContext(qrUIImage.size);
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.codeImageView.image = finalyImage;
}




//  截屏
- (UIImage *)snapshot:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    NSString *message = @"保存失败";

    if (!error) {

        message = @"成功保存到相册";

    }else {

        message = [error description];

    }
    
    [QCClassFunction showMessage:message toView:self.view];


}
@end
