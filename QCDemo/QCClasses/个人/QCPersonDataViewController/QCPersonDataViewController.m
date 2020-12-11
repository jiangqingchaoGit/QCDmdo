//
//  QCPersonDataViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonDataViewController.h"
#import "QCPersonDataCell.h"
#import "QCChangeNicknameViewController.h"
#import "QCPersonCodeViewController.h"
#import "QCAddressListsViewController.h"

@interface QCPersonDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * idLabel;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSString * nickName;

@property (nonatomic, strong) NSData * headerImageData;//图片数据
@property (nonatomic,strong)UIImagePickerController * picker1;
@property (nonatomic,strong)UIImagePickerController * picker2;

@end

@implementation QCPersonDataViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}


//在页面消失的时候就让navigationbar还原样式

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}


#pragma mark - tapAction
- (void)copyAction:(UIButton *)sender {
    
}

- (void)headerAction:(UIButton *)sender {
    //     改变头像
    [self takePhoto];
}

#pragma mark - UIImagePickerController
-(void)takePhoto
{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 判断是否可以打开相机，模拟器无法使用此功能
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            weakself.picker1 = [[UIImagePickerController alloc]init];
            // 允许编辑
            weakself.picker1.allowsEditing = YES;
            weakself.picker1.delegate = self;
            // 调用打开相机
            weakself.picker1.sourceType = UIImagePickerControllerSourceTypeCamera;
            weakself.picker1.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:weakself.picker1 animated:YES completion:nil];
            
        } else {
            
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 从相册选择相片
        weakself.picker2 = [[UIImagePickerController alloc]init];
        weakself.picker2.allowsEditing = YES;
        weakself.picker2.delegate = self;
        weakself.picker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        weakself.picker2.videoQuality=UIImagePickerControllerQualityTypeLow;
        weakself.picker2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:weakself.picker2 animated:NO completion:nil];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}


//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [[UIImage alloc] init];
    image = info[UIImagePickerControllerEditedImage];
    if (picker == _picker1) {
        // 1. 拍照，要把拍下来的照片保存到相册里面
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    
    
    self.headerImageData = UIImageJPEGRepresentation(image, .1);
    if (self.headerImageData.length>100*1024) {
        if (self.headerImageData.length>1024*1024) {//1M以及以上
            self.headerImageData = UIImageJPEGRepresentation(image, .1);
        }else if (self.headerImageData.length>512*1024) {//0.5M-1M
            self.headerImageData =UIImageJPEGRepresentation(image, .5);
            
        }else if (self.headerImageData.length>200*1024) {//0.25M-0.5M
            self.headerImageData = UIImageJPEGRepresentation(image, .9);
        }
    }
    self.headerImageView.image = [UIImage imageWithData:self.headerImageData];
    [self UploadImageWithImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


// MARK: -- 上传图片
- (void)UploadImageWithImage:(UIImage *)img {
    
    NSString * encodedImageStr = [self.headerImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];;
    NSString * str = [NSString stringWithFormat:@"file=%@&name=%@&token=%@&uid=%@",encodedImageStr,@".png",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"file":encodedImageStr,@"name":@".png",@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};


    [QCAFNetWorking QCPOST:@"/api/user/head" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}




#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title  = @"个人资料";
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCPersonDataCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(195))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(154.5), KSCALE_WIDTH(20), KSCALE_WIDTH(66), KSCALE_WIDTH(66))];
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:K_HEADIMAGE AppendingString:nil placeholderImage:@"header"];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(33)];
    [self.headerView addSubview:self.headerImageView];
    
    UIButton * headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(154.5), KSCALE_WIDTH(20), KSCALE_WIDTH(66), KSCALE_WIDTH(66))];
    headerButton.backgroundColor = KCLEAR_COLOR;
    [headerButton addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:headerButton];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(90), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.idLabel.text = [NSString stringWithFormat:@"多多号:%@",K_ACCOUNT];
    self.idLabel.font = K_14_FONT;
    self.idLabel.textAlignment = NSTextAlignmentCenter;
    self.idLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.headerView addSubview:self.idLabel];
    
//    UIButton * copyButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(160), KSCALE_WIDTH(120), KSCALE_WIDTH(55), KSCALE_WIDTH(30))];
//    copyButton.titleLabel.font = K_12_FONT;
//    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
//    [copyButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
//    [copyButton addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:copyButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(179), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.headerView addSubview:lineView];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(50);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * titleArr = @[@"电话",@"昵称",@"我的二维码",@"收货地址"];
    NSArray * contentArr = @[K_PHONE,K_NICK?K_NICK:@"",@"",@""];

    QCPersonDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = titleArr[indexPath.row];
    cell.contentLabel.text = contentArr[indexPath.row];
    cell.picImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.row == 2) {
        cell.picImageView.hidden = NO;
    }
    if (indexPath.row == 3) {
        cell.picImageView.hidden = YES;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
        {
//            QCChangeNicknameViewController * changeNicknameViewController = [[QCChangeNicknameViewController alloc] init];
//            changeNicknameViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//            [self presentViewController:changeNicknameViewController animated:YES completion:nil];
//
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置昵称" message:@""preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入昵称";
            }];

            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField * userName = alertController.textFields.firstObject;
                //  修改群名称
                self.nickName = userName.text;
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSString * str = [NSString stringWithFormat:@"nick=%@&token=%@&uid=%@",self.nickName,K_TOKEN,K_UID];
                NSString * signStr = [QCClassFunction MD5:str];
                NSDictionary * dic = @{@"nick":self.nickName,@"token":K_TOKEN,@"uid":K_UID};
                NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
                NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
                [QCAFNetWorking QCPOST:@"/api/user/nickname" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([responseObject[@"status"] intValue] == 1) {
                        QCPersonDataCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
                        cell.contentLabel.text = self.nickName;
                    }else{
                        [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
                    }

                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
                }];
                
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:loginAction];
            
            // 3.显示警报控制器
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        case 2:
        {
            QCPersonCodeViewController * personCodeViewController = [[QCPersonCodeViewController alloc] init];
            personCodeViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personCodeViewController animated:YES];
        }
            break;
            
        case 3:
        {
            QCAddressListsViewController * addressListsViewController = [[QCAddressListsViewController alloc] init];
            addressListsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressListsViewController animated:YES];
        }
            break;
            
            
            
        default:
            break;
    }
    
}



@end
