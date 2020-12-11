//
//  QCMessageSearchViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCMessageSearchViewController.h"
#import "QCSearchCell.h"
#import "QCGroupChatViewController.h"
@interface QCMessageSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextField * searchTextField;
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footerView;

@end

@implementation QCMessageSearchViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

- (void)GETDATA {
    
}

#pragma mark - tapAction

- (void)resignAction {
    [self.searchTextField resignFirstResponder];
}

- (void)cancelAction:(UIButton *)sender {
    [self.searchTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];;

    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(6) + KStatusHight, KSCALE_WIDTH(305) , KSCALE_WIDTH(38))];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.view addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(18) + KStatusHight, KSCALE_WIDTH(14) , KSCALE_WIDTH(14))];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [self.view addSubview:searchImageView];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(6) + KStatusHight, KSCALE_WIDTH(200) , KSCALE_WIDTH(38))];
    self.searchTextField.placeholder = @"请输入搜索关键字";
    self.searchTextField.font = K_16_FONT;
    self.searchTextField.textColor = [QCClassFunction stringTOColor:@"#333333"];
    self.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySend;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:self.searchTextField];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(320), KSCALE_WIDTH(6) + KStatusHight, KSCALE_WIDTH(55), KSCALE_WIDTH(38))];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = K_16_FONT;
    [self.cancelButton setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavHight, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCSearchCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(20))];
    self.headerView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

    self.tableView.tableHeaderView = self.headerView;
    
}




#pragma mark - UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(82);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCChatModel * model = self.dataArr[indexPath.row];
    cell.nameLabel.text =  model.unick;
    cell.idLabel.text =  model.message;
    cell.timeLabel.text =  [QCClassFunction getDateDisplayString:[model.time integerValue]];
    [QCClassFunction sd_imageView:cell.headerImageView ImageURL:model.uhead AppendingString:@"" placeholderImage:@"header"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.searchTextField resignFirstResponder];
    QCChatModel * model = self.dataArr[indexPath.row];

    //  进入聊天界面
    QCGroupChatViewController * chatViewController = [[QCGroupChatViewController alloc] init];
    chatViewController.hidesBottomBarWhenPushed = YES;
    NSMutableArray * dataArr = [[QCDataBase shared] querywithListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,@"20"]];
    QCListModel * listModel = [dataArr firstObject];
    
    
    NSMutableArray * chatArr = [[QCDataBase shared] queryChatModel:listModel.listId];

    for (NSInteger i = 0; i <chatArr.count; i++) {
        QCChatModel * chatModel= chatArr[i];
        if ([model.msgid isEqualToString:chatModel.msgid]) {
            chatViewController.currentIndex = i;
            
            
            break;
        }
    }
    
    listModel.isRead = @"1";
    NSArray * arr = [listModel.listId componentsSeparatedByString:@"|"];
    chatViewController.groupId = [arr lastObject];
    chatViewController.model = listModel;
    [self.navigationController pushViewController:chatViewController animated:YES];
    
}



#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)sender {
    
    if (sender.text == nil ||  [sender.text isEqualToString:@""]){
        [self.dataArr removeAllObjects];
        [self.tableView reloadData];

    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        [self.dataArr removeAllObjects];

        if (textField.text == nil || [textField.text isEqualToString:@""]) {
            [self.dataArr removeAllObjects];
            [self.tableView reloadData];

        }else{
            self.dataArr  = [[QCDataBase shared] GETARRWithListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,@"20"] withContent:textField.text];
            if (self.dataArr.count != 0) {
                [self.tableView reloadData];
            }
            
        }
        
       
        
        return NO;

    }
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {

    
  if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){

      return NO;

   }

   return YES;

}

@end
