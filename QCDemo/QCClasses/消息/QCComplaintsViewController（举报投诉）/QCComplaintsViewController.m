//
//  QCComplaintsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCComplaintsViewController.h"
#import "QCComplaintsCell.h"

#import "QCComplaintsView.h"
@interface QCComplaintsViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) QCComplaintsView * complaintsView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) UIButton * selectButton;
@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UITextView * contentTextView;

@property (nonatomic, strong) UIButton * sureButton;
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, strong) NSArray * imageArr;



@end

@implementation QCComplaintsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self createFooterView];

    [self GETDATA];
}


#pragma mark - tapAction
- (void)resignAction {
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.contentTextView resignFirstResponder];

}

- (void)sureAction:(UIButton *)sender {
    
    if (self.typeStr == nil || [self.typeStr isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请选择投诉原因" toView:self.view];
        return;
    }
    if (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请输入投诉人姓名" toView:self.view];
        return;
    }
    
    
    if (self.phoneTextField.text == nil || [self.phoneTextField.text isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请输入联系电话" toView:self.view];
        return;
    }
    
    if (self.contentTextView.text == nil || [self.contentTextView.text isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请输入投诉内容" toView:self.view];
        return;
    }
    
    NSString * str = [NSString stringWithFormat:@"attrs=%@&context=%@&mobile=%@&targer_id=%@&targer_type=%@&token=%@&type=%@&uid=%@",@"",self.contentTextView.text,self.phoneTextField.text,self.targer_id,self.status,K_TOKEN,self.typeStr,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"type":self.typeStr,@"attrs":@"",@"mobile":self.phoneTextField.text,@"targer_type":self.status,@"targer_id":self.targer_id,@"context":self.contentTextView.text,@"token":K_TOKEN,@"uid":K_UID};
    
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/user/complaints" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] intValue] == 1) {
            [QCClassFunction showMessage:@"提交成功,请耐心等候" toView:self.view];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
}
 
#pragma mark - GETDATA
- (void)GETDATA {
    
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/user/complaints_type" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCComplaintsModel * model = [[QCComplaintsModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

#pragma mark - initUI
- (void)initUI {
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.backgroundColor = KBACK_COLOR;
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionFooterHeight = 0.01;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCComplaintsCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_HEIGHT(375), KSCALE_WIDTH(52))];
    self.headerView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.tableView.tableHeaderView = self.headerView;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    label.text = @"选择投诉该群（成员）的原因";
    label.font = K_14_FONT;
    label.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.headerView addSubview:label];
    
}
- (void)createFooterView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_HEIGHT(375), KSCALE_WIDTH(850))];
    self.footerView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    self.tableView.tableFooterView = self.footerView;
    

    
    
    UIView * contentLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(0), KSCALE_WIDTH(375), KSCALE_WIDTH(52))];
    contentLabelView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.footerView addSubview:contentLabelView];
    
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    contentLabel.text = @"投诉内容";
    contentLabel.font = K_14_FONT;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [contentLabelView addSubview:contentLabel];
    
    
    NSArray * titleArr = @[@"投诉人",@"联系电话",@"投诉内容(200字以内必填):"];
    NSArray * placeholderArr = @[@"请输入投诉人姓名",@"请输入联系电话"];

    for (NSInteger i = 0;i < 3; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(52) + i * KSCALE_WIDTH(52), KSCALE_WIDTH(100), KSCALE_WIDTH(52))];
        label.text = titleArr[i];
        label.font = K_14_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.footerView addSubview:label];
        
        if (i < 2) {
            UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(52) + KSCALE_WIDTH(52) * i, KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
            textField.placeholder = placeholderArr[i];
            textField.font = K_14_FONT;
            textField.textColor = KTEXT_COLOR;
            [self.footerView addSubview:textField];
            if (i == 0) {
                self.nameTextField = textField;
            }else{
                self.phoneTextField = textField;
                textField.keyboardType = UIKeyboardTypeNumberPad;

            }

        }else {
            label.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(52) + i * KSCALE_WIDTH(52), KSCALE_WIDTH(200), KSCALE_WIDTH(52));
        }

    }
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(208), KSCALE_WIDTH(335), KSCALE_WIDTH(120))];
    self.contentTextView.textColor = KTEXT_COLOR;
    self.contentTextView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.contentTextView.font = K_14_FONT;
    [QCClassFunction filletImageView:self.contentTextView withRadius:KSCALE_WIDTH(5)];
    [self.footerView addSubview:self.contentTextView];
    
    UILabel * placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入投诉内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [QCClassFunction stringTOColor:@"#cacaca"];
    [placeHolderLabel sizeToFit];
    [self.contentTextView addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    
    
    UILabel * imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(328), KSCALE_WIDTH(100), KSCALE_WIDTH(52))];
    imageLabel.text = @"图片证据(选填)";
    imageLabel.font = K_14_FONT;
    imageLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.footerView addSubview:imageLabel];
    
    
    self.complaintsView = [[QCComplaintsView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(380), KSCALE_WIDTH(335), KSCALE_WIDTH(90))];
    self.complaintsView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.complaintsView withRadius:KSCALE_WIDTH(5)];
    [self.footerView addSubview:self.complaintsView];
    
    
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(648), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFBA00"];
    [self.sureButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(5)];
    [self.footerView addSubview:self.sureButton];
    
    UILabel * complaintsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(700), KSCALE_WIDTH(335), KSCALE_WIDTH(80))];
    complaintsLabel.text = @"请您如实填写投诉信息与联系电话，投诉专员将在2个工作日内与您联系。如信息不实或电话无法联系，此投诉将不被受理。";
    complaintsLabel.font = K_14_FONT;
    complaintsLabel.numberOfLines = 0;
    complaintsLabel.textColor = [QCClassFunction stringTOColor:@"#FFBA00"];
    [self.footerView addSubview:complaintsLabel];
    
    
    /*
     *      UIView * labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(52))];
     labelView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
     [self.footerView addSubview:labelView];
     
     UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
     label.text = @"投诉须知";
     label.font = K_14_FONT;
     label.textColor = [QCClassFunction stringTOColor:@"#666666"];
     [labelView addSubview:label];
     

     */
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCComplaintsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCComplaintsModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(52);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCComplaintsCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectButton.selected = NO;
    cell.chooseButton.selected = YES;
    self.selectButton = cell.chooseButton;
    QCComplaintsModel * model = self.dataArr[indexPath.row];
    self.typeStr = model.id;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {

    
  if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){

      return NO;

   }
    
    if([touch.view isDescendantOfView:self.complaintsView.collectionView]){
        return NO;
    }

   return YES;

}
@end
