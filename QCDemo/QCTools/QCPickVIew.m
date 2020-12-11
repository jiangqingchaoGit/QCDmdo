//
//  QCPickVIew.m
//  QCDemo
//
//  Created by JQC on 2020/12/1.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPickVIew.h"
#import "QCReleaseViewController.h"
#import "QCAddressViewController.h"
@interface QCPickVIew()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView * pickerView;

@property (nonatomic,retain) NSArray *provinceArray;//存储所有的省的名称
@property (nonatomic,retain) NSArray *cityArray;//存储对应省份下的所有城市名
@property (nonatomic,retain) NSArray *countyArray;//存储所有的县区名
@end
@implementation QCPickVIew

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KBACK_COLOR;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(50))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self addSubview:view];
    
    UIButton * cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(0), KSCALE_WIDTH(60), KSCALE_WIDTH(50))];
    cancleButton.titleLabel.font = K_14_FONT;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[QCClassFunction stringTOColor:@"#333333"] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleButton];
    
    UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(315), KSCALE_WIDTH(0), KSCALE_WIDTH(60), KSCALE_WIDTH(50))];
    sureButton.titleLabel.font = K_14_FONT;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:sureButton];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(50), KSCALE_WIDTH(375), KSCALE_WIDTH(150))];
    self.pickerView.backgroundColor = KBACK_COLOR;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self loadData];
    [self addSubview:self.pickerView];
    
}

- (void)cancleAction:(UIButton *)sender {
    [[self superview] removeFromSuperview];
}

- (void)sureAction:(UIButton *)sender {
    [[self superview] removeFromSuperview];
    if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCReleaseViewController class]]) {
        QCReleaseViewController * releaseViewController = (QCReleaseViewController *)[QCClassFunction getCurrentViewController];
        NSDictionary * dic = [self getCurrentSelectedInfo];
        releaseViewController.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",dic[@"province"],dic[@"city"],dic[@"country"]];
        releaseViewController.addressStr = [NSString stringWithFormat:@"%@%@%@",dic[@"province"],dic[@"city"],dic[@"country"]];
        releaseViewController.addressLabel.textColor =KTEXT_COLOR;

    }
    
    if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCAddressViewController class]]) {
        QCAddressViewController * addressViewController = (QCAddressViewController *)[QCClassFunction getCurrentViewController];
        NSDictionary * dic = [self getCurrentSelectedInfo];
        addressViewController.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",dic[@"province"],dic[@"city"],dic[@"country"]];
        addressViewController.addressStr = [NSString stringWithFormat:@"%@%@%@",dic[@"province"],dic[@"city"],dic[@"country"]];
        addressViewController.addressLabel.textColor =KTEXT_COLOR;
        addressViewController.addressDic = dic;
    }

}
#pragma mark - UIPickerViewDataSource和UIPickerViewDelegate
// 设置列的返回数量
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return KSCALE_WIDTH(50);
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return KSCALE_WIDTH(375) / 3.0;
}
//设置列里边组件的个数 component:组件
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //如果是第一列
    if (component == 0)
    {
        //返回省的个数
        return self.provinceArray.count;
    }
    //如果是第二列
    else if (component == 1)
    {
        //返回市的个数
        return self.cityArray.count;
    }
    else
    {
        //返回县区的个数
        return self.countyArray.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSString * name;
    if (component == 0) {
        // 设置第0列的标题信息
        NSDictionary *provinceDict = [self.provinceArray objectAtIndex:row];
        name = provinceDict[@"n"];
    } else if (component == 1) {
        // 设置第1列的标题信息
        NSDictionary *cityDict = [self.cityArray objectAtIndex:row];
         name = cityDict[@"n"];
    } else {
        // 设置第2列的标题信息
        NSDictionary *countryDict = [self.countyArray objectAtIndex:row];
        name = countryDict[@"n"];
    }
    UILabel * pickerLabel = nil;
    pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375) / 3.0, KSCALE_WIDTH(30))];
    pickerLabel.font = K_14_FONT;
    pickerLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    pickerLabel.text = name;
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.adjustsFontSizeToFitWidth = YES;

    return pickerLabel;
}


//选择器选择的方法  row：被选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //选择第0列执行的方法
    if (component == 0) {
        [pickerView selectedRowInComponent:0];
        
        /**
         *  选中第0列时需要刷新第1列和第二列的数据
         */
        NSDictionary *provinceDict = [self.provinceArray objectAtIndex:row];
        self.cityArray = provinceDict[@"l"];
        [pickerView reloadComponent:1];
        
        NSDictionary *cityDict = [self.cityArray firstObject];
        self.countyArray = cityDict[@"l"];
        [pickerView reloadComponent:2];
        
    } else if (component == 1) {
        [pickerView selectedRowInComponent:1];
        
        /**
         *  选中第一列时需要刷新第二列的数据信息
         */
        NSDictionary *cityDict = [self.cityArray objectAtIndex:row];
        self.countyArray = cityDict[@"l"];
        [pickerView reloadComponent:2];
        
    } else if (component == 2) {
        [pickerView selectedRowInComponent:2];
        
    }
    
}


- (NSDictionary *)getCurrentSelectedInfo {
    // 获取当前选中的信息
    NSInteger proviceIndex = [self.pickerView selectedRowInComponent:0];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent:1];
    NSInteger countryIndex = [self.pickerView selectedRowInComponent:2];
    NSString *provice = self.provinceArray[proviceIndex][@"n"];
    NSString *city = self.cityArray.count != 0 ? self.cityArray[cityIndex][@"n"] : @"";
    NSString *country = self.countyArray.count != 0 ? self.countyArray[countryIndex][@"n"] : @"";
    NSLog(@"%@,%@,%@",provice,city,country);
    NSDictionary *info = @{@"province":provice,@"city":city,@"country":country};
    return info;
}

#pragma mark - 加载数据
- (void)loadData
{
    // 从MainBundle中加载文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citylist" ofType:@"data"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray  *jsonArray = [NSJSONSerialization
                           JSONObjectWithData:data options:NSJSONReadingAllowFragments
                           error:nil];
    // 取出默认的省市信息
    self.provinceArray = jsonArray;
    
    // 取出默认的城市信息
    NSDictionary *provinceDict = [self.provinceArray firstObject];
    self.cityArray = provinceDict[@"l"];
    
    // 取出默认的区信息
    NSDictionary *cityDict = [self.cityArray firstObject];
    self.countyArray = cityDict[@"l"];
}



@end
