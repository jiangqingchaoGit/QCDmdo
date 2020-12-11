//
//  QCSetViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSetViewController.h"
#import "QCSetCell.h"
#import "AppDelegate.h"
//  安全
#import "QCSaveViewController.h"
@interface QCSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footView;


@end

@implementation QCSetViewController


-(void)viewWillAppear:(BOOL)animated {
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
- (void)dissolutionAction:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[QCWebSocket shared] RMWebSocketClose];
    [QCClassFunction getSelectTabViewControllerWithSelected:0];
    

}


#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"设置";
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375),KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCSetCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(130))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(137.5), KSCALE_WIDTH(5), KSCALE_WIDTH(100), KSCALE_WIDTH(100))];
    headerImageView.image = [UIImage imageNamed:@"safety"];
    headerImageView.contentMode = UIViewContentModeCenter;
    [self.headerView addSubview:headerImageView];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_HEIGHT(667) - KNavHight - KSCALE_WIDTH(51), KSCALE_WIDTH(375), KSCALE_WIDTH(51))];
    [self.view addSubview:self.footView];

    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.footView addSubview:lineView];
    
    UIButton * dissolutionButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(1), KSCALE_WIDTH(375), KSCALE_WIDTH(45))];
    dissolutionButton.backgroundColor = KBACK_COLOR;
    dissolutionButton.titleLabel.font =K_18_FONT;
    [dissolutionButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [dissolutionButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [dissolutionButton addTarget:self action:@selector(dissolutionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:dissolutionButton];
    
    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;

            break;
        case 2:
            return 2;

            break;

            
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return KSCALE_WIDTH(11);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = KCLEAR_COLOR;
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(5), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

    if (section != 2) {
        [view addSubview:lineView];

    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(46);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * titleArr = @[@[@"安全",@"绑定微信"],@[@"新消息通知",@"隐私"],@[@"清除缓存",@"版本信息"]];
    QCSetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.onSwitch.hidden = YES;
    cell.contentLabel.hidden = YES;
    [cell.onSwitch addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventValueChanged | UIControlEventTouchDragExit];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.onSwitch.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            cell.contentLabel.hidden = NO;
            cell.contentLabel.text = @"已绑定微信";
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            cell.contentLabel.hidden = NO;
            if (indexPath.row == 0) {
                cell.contentLabel.text = [NSString stringWithFormat:@"%.2fM",[self filePath]];

            }else{
                cell.contentLabel.text = @"当前版本1.1";

            }
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    QCSaveViewController * saveViewController = [[QCSaveViewController alloc] init];
                    saveViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:saveViewController animated:YES];
                }
                    break;
                case 1:
                    
                    break;

                    
                default:
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;

                    
                default:
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self clearFile];

                    break;
                case 1:
                    break;
                case 2:
                    
                    break;
                    
                default:
                    break;
            }
            break;
        default:
            break;
    }
}






-( float )filePath

{

   

   NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];

   

   return [ self folderSizeAtPath :cachPath];

   

}

- ( long long ) fileSizeAtPath:( NSString *) filePath{

   

   NSFileManager * manager = [ NSFileManager defaultManager ];

   

   if ([manager fileExistsAtPath :filePath]){

       

       return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];

   }

   

   return 0 ;

   

}

- ( float ) folderSizeAtPath:( NSString *) folderPath{

   

   NSFileManager * manager = [ NSFileManager defaultManager ];

   

   if (![manager fileExistsAtPath :folderPath]) return 0 ;

   

   NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];

   

   NSString * fileName;

   

   long long folderSize = 0 ;

   

   while ((fileName = [childFilesEnumerator nextObject ]) != nil ){

       

       NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];

       

       folderSize += [ self fileSizeAtPath :fileAbsolutePath];

       

   }

   

   return folderSize/( 1024.0 * 1024.0 );

   

}

- (void)clearFile

{

   NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory ,NSUserDomainMask , YES ) firstObject ];

   

   NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];

   

   NSLog ( @"cachpath = %@" , cachPath);

   

   for ( NSString * p in files) {

       

       NSError * error = nil ;

       

       NSString * path = [cachPath stringByAppendingPathComponent :p];

       

       if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
           [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];

       }

       

   }

   

   [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];

   

}

-(void)clearCachSuccess {

    [QCClassFunction showMessage:@"清理成功" toView:self.view];
   NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:2];//刷新
   [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)switchBtnAction:(UISwitch *)sender {
    if (sender.on) {
        //  接收推送消息
    }else{
        //  关闭推送消息
    }
}




@end
