//
//  QCBookViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCBookViewController.h"
#import "QCBookCell.h"


//  搜索界面
#import "QCMessageSearchViewController.h"
//  聊天界面
#import "QCChatViewController.h"
//  我的新朋友列表
#import "QCNewFriendListViewController.h"
//  群聊
#import "QCGroupListViewController.h"

//  个人资料
#import "QCPersonCardViewController.h"

#import "QCAddFriendsViewController.h"

@interface QCBookViewController ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UITextField * searchTextField;

@property (nonatomic, strong) NSMutableArray * newfriendArr;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * keysArr;

@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, assign) NSInteger searchStatus;
@property (nonatomic, strong) NSMutableArray * searchArr;
@property (nonatomic, strong) NSMutableArray * searchKey;

@end

@implementation QCBookViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self GETDATA];
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
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.dataArr = [[NSMutableArray alloc] init];
    self.keysArr = [[NSMutableArray alloc] init];
    
    self.dataDic = [[NSMutableDictionary alloc] init];
    self.searchArr = [[NSMutableArray alloc] init];
    self.searchKey = [[NSMutableArray alloc] init];

    self.searchStatus = 0;

    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self GETDATA];
}


#pragma mark - GETDATA
- (void)GETDATA {
    QCAssociatedModel * model = [[QCAssociatedModel alloc] init];
    [self.newfriendArr removeAllObjects];
    self.newfriendArr = [[QCDataBase shared] queryAssociatedModel:model];

    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    [QCAFNetWorking QCPOST:@"/api/chat/friend" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            [self.keysArr removeAllObjects];

            
            NSMutableArray * modelArr = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCBookModel * model = [[QCBookModel alloc] initWithDictionary:dic error:nil];
                [modelArr addObject:model];
            }
            
            
            NSArray * arr  = [self sortObjectsAccordingToInitialWith:modelArr];
            self.dataArr = [arr firstObject];
            
            [self.keysArr addObject:@""];
            [self.keysArr addObjectsFromArray:[arr lastObject]];
            
            
            
            [self.tableView reloadData];
            
            
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


- (void)searchAction:(UIButton *)sender {
    //  搜索
    [self.searchTextField resignFirstResponder];

    QCMessageSearchViewController * messageSearchViewController = [[QCMessageSearchViewController alloc] init];
    messageSearchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageSearchViewController animated:YES];
}


- (void)rightAction:(UITapGestureRecognizer *)sender {
    
    QCAddFriendsViewController * addFriendsViewController = [[QCAddFriendsViewController alloc] init];
    addFriendsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addFriendsViewController animated:YES];
    
}
#pragma mark - initUI

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationItem.title = @"通讯录";
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add"]];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight - KTabHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCBookCell class] forCellReuseIdentifier:@"cell"];
    
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
        if (section == 0) {
            return 2;
        }else{
            NSArray * arr = self.dataArr[section - 1];
            return arr.count;
        }
    }else{
        NSArray * arr = self.searchArr[section];
        
        
        return arr.count;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(72);
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCBookCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    if (self.searchStatus == 0) {


        
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    if (self.newfriendArr.count > 0) {
                        cell.nameLabel.text = [NSString stringWithFormat:@"%ld位新申请",self.newfriendArr.count];
                        cell.nameLabel.textColor = [UIColor redColor];
                        cell.headerImageView.image = [UIImage imageNamed:@"add_f"];


                    }else{
                        cell.nameLabel.text = @"新的朋友";
                        cell.nameLabel.textColor = KTEXT_COLOR;
                        cell.headerImageView.image = [UIImage imageNamed:@"add_f"];
                        UITabBarItem * item = [[QCClassFunction getCurrentViewController].tabBarController.tabBar.items objectAtIndex:2];
                        item.badgeValue = nil;

                        
                    }
                    break;
                    
                default:
                    cell.nameLabel.text = @"群聊";
                    cell.headerImageView.image = [UIImage imageNamed:@"add_g"];


                    break;
            }
        }else{
            QCBookModel * model = self.dataArr[indexPath.section - 1][indexPath.row];
            [cell fillCellWithModel:model];
        }

    }else{

        QCBookModel * model = self.searchArr[indexPath.section][indexPath.row];
        [cell fillCellWithModel:model];
    }
    


    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.searchTextField resignFirstResponder];
    
    if (self.searchStatus == 0) {
        
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
                    
                    QCNewFriendListViewController * newFriendListViewController = [[QCNewFriendListViewController alloc] init];
                    newFriendListViewController.hidesBottomBarWhenPushed = YES;
                    QCAssociatedModel * model = [[QCAssociatedModel alloc] init];
                    [[QCDataBase shared] deleteAssociatedModel:model];
                    [self.navigationController pushViewController:newFriendListViewController animated:YES];
                }
                    break;
                case 1:
                {
                    
                    QCGroupListViewController * groupListViewController = [[QCGroupListViewController alloc] init];
                    groupListViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:groupListViewController animated:YES];
                }
                    break;
                    
                    
                    
                default:

                    break;
            }
        }else{
            QCBookModel * model = self.dataArr[indexPath.section - 1][indexPath.row];
            
            QCPersonCardViewController * personCardViewController = [[QCPersonCardViewController alloc] init];
            personCardViewController.hidesBottomBarWhenPushed = YES;
            personCardViewController.model = model;
            [self.navigationController pushViewController:personCardViewController animated:YES];
            

        }
        
    }else{
        QCBookModel * model = self.searchArr[indexPath.section][indexPath.row];
        
        QCPersonCardViewController * personCardViewController = [[QCPersonCardViewController alloc] init];
        personCardViewController.hidesBottomBarWhenPushed = YES;
        personCardViewController.model = model;
        [self.navigationController pushViewController:personCardViewController animated:YES];
        
    }
    

    
    
    

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.searchStatus == 0) {
        return self.keysArr.count;

    }else{
        return self.searchKey.count;

    }}


//添加TableView头视图标题

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (self.searchStatus == 0) {
        return self.keysArr[section];

    }else{
        return nil;

    }}

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
        [self.searchTextField resignFirstResponder];

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


-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {

    
    
  if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){

      return NO;

   }

   return YES;

}

@end
