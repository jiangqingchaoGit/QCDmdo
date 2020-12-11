//
//  QCGroupViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupViewController.h"
#import "QCGroupCell.h"
#import "QCGroupChatViewController.h"

@interface QCGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITapGestureRecognizer * rightTap;
@property (nonatomic, strong) UITextField * searchTextField;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UILabel * numberLabel;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * keysArr;

@property (nonatomic, strong) NSMutableArray * peopleArr;
@property (nonatomic, assign) NSInteger peopleNum;

@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, assign) NSInteger searchStatus;
@property (nonatomic, strong) NSMutableArray * searchArr;
@property (nonatomic, strong) NSMutableArray * searchKey;


@end

@implementation QCGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.dataArr = [[NSMutableArray alloc] init];
    self.keysArr = [[NSMutableArray alloc] init];
    self.peopleArr = [[NSMutableArray alloc] init];
    
    self.dataDic = [[NSMutableDictionary alloc] init];
    self.searchArr = [[NSMutableArray alloc] init];
    self.searchKey = [[NSMutableArray alloc] init];
    
    self.searchStatus = 0;
    self.peopleNum = 0;
    
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self GETDATA];
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/friend" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            
            NSMutableArray * modelArr = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCBookModel * model = [[QCBookModel alloc] initWithDictionary:dic error:nil];
                [modelArr addObject:model];
            }
            
            
            NSArray * arr  = [self sortObjectsAccordingToInitialWith:modelArr];
            self.dataArr = [arr firstObject];
            
            [self.keysArr addObjectsFromArray:[arr lastObject]];
            
            
            
            [self.tableView reloadData];
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)GETGROUPDATA {
    
    NSString * otherId = [self.peopleArr componentsJoinedByString:@","];
    NSString * str = [NSString stringWithFormat:@"fuid=%@&token=%@&uid=%@",otherId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":otherId,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/add_group" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            
            //  成功直接到群聊天界面
            QCTarBarController * tab = [QCClassFunction getSelectTabViewControllerWithSelected:1];
            QCGroupChatViewController * groupChatViewController = [[QCGroupChatViewController alloc] init];
            QCListModel * listModel = [[QCListModel alloc] init];
            listModel.listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,responseObject[@"data"][@"group_id"]];
            listModel.type = @"chat";
            listModel.uid = responseObject[@"data"][@"group_id"];
            listModel.rid = K_UID;
            listModel.msgid = [NSString stringWithFormat:@"%@|%@|%@",K_UID,[QCClassFunction getNowTimeTimestamp3],responseObject[@"data"][@"group_id"]];;
            listModel.message = @"";
            listModel.time = [QCClassFunction getNowTimeTimestamp3];
            listModel.count = @"0";
            listModel.headImage = @"imgUrl";
            listModel.isTop = @"0";
            listModel.isRead = @"1";
            listModel.isChat = @"2";
            listModel.cType = @"1";
            
            listModel.tohead = K_HEADIMAGE;
            listModel.tonick = K_NICK;
            
            listModel.uhead = @"";
            listModel.unick= @"";
            listModel.mtype = @"0";
            listModel.ghead = responseObject[@"data"][@"head_img"];
            listModel.gname = responseObject[@"data"][@"name"];
            listModel.disturb = @"";
            listModel.isBanned = @"0";

            groupChatViewController.hidesBottomBarWhenPushed = YES;
            groupChatViewController.model = listModel;
            groupChatViewController.groupId = responseObject[@"data"][@"group_id"];
            
            
            [tab.selectedViewController pushViewController:groupChatViewController animated:YES];
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



#pragma mark - tapAction

- (void)resignAction {
    [self.searchTextField resignFirstResponder];
}

- (void)rightAction:(UIButton *)sender {
    //  创建群
    [self.searchTextField resignFirstResponder];
    
    [self.peopleArr addObject:K_UID];
    [self GETGROUPDATA];
    
}


- (void)chooseAction:(UIButton *)sender {
    [self.searchTextField resignFirstResponder];
    QCGroupCell * cell = (QCGroupCell *)[[sender superview]superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    QCBookModel * model;
    if (self.searchStatus == 0) {
        model = self.dataArr[indexPath.section][indexPath.row];
        
    }else{
        model = self.searchArr[indexPath.section][indexPath.row];
        
        
    }
    self.rightTap.enabled = YES;
    self.numberLabel.alpha = 1;
    
    
    if ([self.peopleArr containsObject:K_UID]) {
        [self.peopleArr removeObject:K_UID];
        
    }
    if (sender.selected == YES) {
        sender.selected = NO;
        self.peopleNum = self.peopleNum - 1;
        [self.peopleArr removeObject:model.fuid];
        
        if (self.peopleNum == 0) {
            self.numberLabel.text = @"确认";
            self.numberLabel.alpha = 0.5;
            self.rightTap.enabled = NO;
            
            
        }else{
            self.numberLabel.text = [NSString stringWithFormat:@"确认(%ld)",self.peopleNum];
            
        }
        
    }else{
        sender.selected = YES;
        self.peopleNum = self.peopleNum + 1;
        self.numberLabel.text = [NSString stringWithFormat:@"确认(%ld)",self.peopleNum];
        [self.peopleArr addObject:model.fuid];
        
    }
    
    
}

#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationItem.title = @"添加群成员";
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(60), KSCALE_WIDTH(44))];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(7), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
    self.numberLabel.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.numberLabel.text = @"确认";
    self.numberLabel.alpha = 0.5;
    self.numberLabel.textColor = KBACK_COLOR;
    self.numberLabel.font = K_14_FONT;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [QCClassFunction filletImageView:self.numberLabel withRadius:KSCALE_WIDTH(3)];
    [view addSubview:self.numberLabel];
    
    self.rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    self.rightTap.enabled = NO;
    [view addGestureRecognizer:self.rightTap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
}



- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCGroupCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(6), KSCALE_WIDTH(345) , KSCALE_WIDTH(38))];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.headerView addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(17), KSCALE_WIDTH(16) , KSCALE_WIDTH(16))];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [self.headerView addSubview:searchImageView];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(0), KSCALE_WIDTH(280) , KSCALE_WIDTH(38))];
    self.searchTextField.placeholder = @"请输入搜索关键字";
    self.searchTextField.font = K_15_FONT;
    self.searchTextField.textColor = [QCClassFunction stringTOColor:@"#333333"];
    self.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [searchView addSubview:self.searchTextField];
    
    
    
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (self.searchStatus == 0) {
        NSArray * arr = self.dataArr[section];
        return arr.count;
    }else{
        NSArray * arr = self.searchArr[section];
        
        
        return arr.count;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(72);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.searchStatus == 0) {
        
        QCBookModel * model = self.dataArr[indexPath.section][indexPath.row];
        [cell fillCellWithModel:model];
        if (self.listModel) {
            if ([self.listModel.uid isEqualToString:model.fuid]) {
                cell.chooseButton.selected = YES;
                self.peopleNum = self.peopleNum + 1;
                [self.peopleArr addObject:model.fuid];
                
                if (self.peopleNum == 0) {
                    self.numberLabel.text = @"确认";
                    self.numberLabel.alpha = 0.5;
                    self.rightTap.enabled = NO;
                    
                    
                }else{
                    self.numberLabel.text = [NSString stringWithFormat:@"确认(%ld)",self.peopleNum];
                    self.rightTap.enabled = YES;
                    self.numberLabel.alpha = 1;
                }
                
            }else{
                cell.chooseButton.selected = NO;
                
            }
        }
        
    }else{
        QCBookModel * model = self.searchArr[indexPath.section][indexPath.row];
        [cell fillCellWithModel:model];
        if (self.listModel) {
            if ([self.listModel.uid isEqualToString:model.fuid]) {
                cell.chooseButton.selected = YES;
                self.peopleNum = self.peopleNum + 1;
                [self.peopleArr addObject:model.fuid];
                if (self.peopleNum == 0) {
                    self.numberLabel.text = @"确认";
                    self.numberLabel.alpha = 0.5;
                    self.rightTap.enabled = NO;
                    
                    
                }else{
                    self.numberLabel.text = [NSString stringWithFormat:@"确认(%ld)",self.peopleNum];
                    self.rightTap.enabled = YES;
                    self.numberLabel.alpha = 1;
                }
                
            }else{
                cell.chooseButton.selected = NO;
                
            }
            
        }
        
    }
    [cell.chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.searchStatus == 0) {
        return self.keysArr.count;
        
    }else{
        return self.searchKey.count;
        
    }
}


//添加TableView头视图标题

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (self.searchStatus == 0) {
        return self.keysArr[section];
        
    }else{
        return nil;
        
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.searchStatus == 0) {
        return self.keysArr;
        
    }else{
        return nil;
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
}

//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index]; // -1 添加了搜索标识
    }
}




// 按首字母分组排序数组
-(NSArray *)sortObjectsAccordingToInitialWith:(NSMutableArray *)arr {
    
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //将每个名字分到某个section下
    for (QCBookModel *personModel in arr) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [collation sectionForObject:personModel collationStringSelector:@selector(nick)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:personModel];
    }
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(nick)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //删除空的数组
    NSMutableArray * finalArr = [NSMutableArray new];
    NSMutableArray * keysArr = [NSMutableArray new];
    
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (((NSMutableArray *)(newSectionsArray[index])).count != 0) {
            
            int asciiCode = (int)index + 65;
            NSString * string =[NSString stringWithFormat:@"%c",asciiCode]; //A
            [keysArr addObject:string];
            [finalArr addObject:newSectionsArray[index]];
            
            [self.dataDic setObject:newSectionsArray[index] forKey:string];
            
            
        }
    }
    
    
    return @[finalArr,keysArr];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    
    [self.searchArr removeAllObjects];
    [self.searchKey removeAllObjects];
    
    if (sender.text == nil || [sender.text isEqualToString:@""]) {
        self.searchStatus = 0;
        
    }else {
        self.searchStatus = 1;
        
        NSArray * keyArr = [self.dataDic allKeys];
        NSString * str = [sender.text uppercaseString];
        
        if ([keyArr containsObject:str]) {
            [self.searchArr addObject:self.dataDic[str]];
            [self.searchKey addObject:str];
        }else {
            
        }
        
        
        
    }
    [self.tableView reloadData];
    
    
    
}


@end
