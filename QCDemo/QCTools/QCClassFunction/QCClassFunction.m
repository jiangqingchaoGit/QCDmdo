//
//  QCClassFunction.m
//  E大夫在线3.0
//
//  Created by Leesin on 2017/1/23.
//  Copyright © 2017年 baisui. All rights reserved.
//

#import "QCClassFunction.h"
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <sys/utsname.h>//要导入头文件
#import <sys/utsname.h>
#import "AppDelegate.h"


#define gIv @"8227833840494928" //可以自行定义16位，向量，

@interface QCClassFunction ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * backView;
@end

//  声明全局变量关键字
static QCClassFunction * _classFunction = nil;







@implementation QCClassFunction

+ (QCClassFunction *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _classFunction = [[QCClassFunction alloc] init];
    });
    return _classFunction;
    
}

/*
 *  三元素获取颜色的类方法
 */
+ (UIColor *) stringTOColor:(NSString *)str

{
    
    if (!str || [str isEqualToString:@""]) {
        
        return nil;
        
    }
    
    unsigned red,green,blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 1;
    
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    
    range.location = 3;
    
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    
    range.location = 5;
    
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    
    return color;
    
}

/*
 *  获取父视图的类方法
 */

+(UIViewController *)parentController:(UIView*)Self
{
    //    在iOS中UIResponder类是专门用来响应用户的操作处理各种事件的，包括触摸事件(Touch Events)、运动事件(Motion Events)、远程控制事件(Remote Control Events)
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = [Self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

/*
 *  动态计算label的高度的方法
 */
+ (CGSize)getStrSize:(NSString *)textStr andTexFont:(UIFont *)font andMaxSize:(CGSize)maxSize

{
    
    NSDictionary *textAttDict = @{NSFontAttributeName : font};
    
    
    
    return [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttDict context:nil].size;
    
}
+(CGFloat)getHeighWithString:(NSString*)textStr andFontSize:(CGFloat)fontSize andConstrainedWidth:(CGFloat)width
{
    CGRect rect = [textStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return (int)(rect.size.height+1);
}

+(CGFloat)getWidthWithString:(NSString*)textStr andFontSize:(CGFloat)fontSize andConstrainedHeight:(CGFloat)height
{
    CGRect rect = [textStr boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return (int)(rect.size.width+1);
}

//手机的号码检查   错误为真  正确为假
+(BOOL)isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return NO;
    }
    
    return YES;
}


//NSUserDefaults
+(void)Save:(id)str Key:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:key];
    [defaults synchronize];
}
+(id)Read:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}
+ (void)removeAllInfo {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    NSUserDefaults * defautls = [NSUserDefaults standardUserDefaults];  [defautls removePersistentDomainForName:appDomain];
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}
+(NSString *)descriptionWithDictionary:(NSDictionary*)locale
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [locale enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

+(NSString *)descriptionWithArray:(NSMutableArray*)locale
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [locale enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

//获取图片
+(void)sd_imageView:(UIImageView*)image ImageURL:(NSString*)imageURL AppendingString:(NSString*)string placeholderImage:(NSString*)placeholderImage{
    [image sd_setImageWithURL:[NSURL URLWithString:[imageURL stringByAppendingString:string ? string : @""]] placeholderImage:[UIImage imageNamed:placeholderImage]];
    
}
+(NSMutableAttributedString *)getFontWithString:(NSString *)textStr andTargetString:(NSString *)targetString withFont:(CGFloat )font andTargetFont:(CGFloat )targetFont{
    const CGFloat fontSize = font;
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSUInteger length = [textStr length];
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont *boldFont = [UIFont systemFontOfSize:targetFont];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[textStr rangeOfString:targetString]];
    return attrString;
}

+(NSMutableAttributedString *)getBoldWithString:(NSString *)textStr andTargetString:(NSString *)targetString withFont:(CGFloat)font{
    const CGFloat fontSize = font;
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSUInteger length = [textStr length];
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont *boldFont = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[textStr rangeOfString:targetString]];
    return attrString;
}


+(NSMutableAttributedString *)getBoldWithString:(NSString *)textStr andTargetString:(NSString *)targetString andTargetString1:(NSString *)targetString1 withFont:(CGFloat)font{
    const CGFloat fontSize = font;
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSUInteger length = [textStr length];
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont *boldFont = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[textStr rangeOfString:targetString]];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[textStr rangeOfString:targetString1]];
    
    return attrString;
}

+(NSMutableAttributedString *)getColorWithString:(NSString *)textStr andTargetString:(NSString *)targetString withColor:(UIColor *)color{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:textStr];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:[textStr rangeOfString:targetString]];
    return attrString;
}

+(NSMutableAttributedString *)getColorAndFontWithString:(NSString *)textStr andTargetString:(NSString *)targetString withColor:(UIColor *)color withFont:(CGFloat )font andTargetFont:(CGFloat )targetFont {
    
    const CGFloat fontSize = font;
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSUInteger length = [textStr length];
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont *boldFont = [UIFont systemFontOfSize:targetFont];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[textStr rangeOfString:targetString]];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:[textStr rangeOfString:targetString]];
    
    return attrString;
    
    
}
+(void)filletImageView:(id)view withRadius:(CGFloat)radius{
    
    UIImageView * imageView = (UIImageView *)view;
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
}


//设置状态栏背景色
+ (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView * statusBar = [[UIView alloc] init];
    if (@available(iOS 13.0, *)) {
        
        //获取keyWindow
        UIWindow *keyWindow = [self getKeyWindow];
        statusBar.frame = keyWindow.windowScene.statusBarManager.statusBarFrame;
        [keyWindow addSubview:statusBar];
        
    } else {
        statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        
    }
    
    
    NSLog(@"statusBar.backgroundColor--->%@",statusBar.backgroundColor);
    
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (UIWindow *)getKeyWindow
{
    // 获取keywindow
    NSArray *array = [UIApplication sharedApplication].windows;
    UIWindow *window = [array objectAtIndex:0];
    if (!window.hidden || window.isKeyWindow) { //  判断取到的window是不是keywidow
        return window;
    }
    //  如果上面的方式取到的window 不是keywidow时  通过遍历windows取keywindow
    for (UIWindow *window in array) {
        if (!window.hidden || window.isKeyWindow) {
            return window;
        }
    }
    return nil;
}



- (void)createLocalStatusBar{
    
}

- (void)statusBar{
    
}

/*
 *  隐藏导航栏
 */
+ (void)hiddenNavigationBarWithUINavigationBar:(UINavigationBar *)navigationBar {
    //去掉透明后导航栏下边的黑边
    [navigationBar setShadowImage:[[UIImage alloc] init]];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigationBar.translucent = YES;
}


/*
 *  显示导航栏
 */
+ (void)accordingNavigationBarWithUINavigationBar:(UINavigationBar *)navigationBar {
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
    navigationBar.translucent = NO;
}

/*
 *  获取根控制器
 */
+ (UIViewController *)getRootViewController {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

/*
 *  获取当前页面控制器
 */
+ (UIViewController *)getCurrentViewController
{
    UIViewController* currentViewController = [self getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind)
    {
        if (currentViewController.presentedViewController)
        {
            /**
             *  通过此方法可以查找到通过 presented 模态方式(显示与隐士) 方式推出的当前控制器。
             例如: AViewController --> BViewController 通过模态方式推出.
             则使用 AViewController.presentedViewController 能获取到 BViewController。
             */
            currentViewController = currentViewController.presentedViewController;
        }
        else if ([currentViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        }
        else if ([currentViewController isKindOfClass:[UITabBarController class]])
        {
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        }
        else
        {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0)
            {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            }
            else
            {
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}


+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message; // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText; // YES代表需要蒙版效果 //
    [hud hideAnimated:YES afterDelay:2];
    return hud;
    
}




+ (void)showGifToView:(UIView *)view{
    
    //这里最好加个判断，让这个加载动画添加到window上，调用的时候，这个view传个nil就行了！
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //使用SDWebImage 放入gif 图片--(因为项目中使用的都是同一个加载动画，所以在这里我把图片写死了)
    
    NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"加载修改.gif" ofType:nil];
    NSData *imagedata = [NSData dataWithContentsOfFile:filepath];
    UIImage *image = [UIImage sd_imageWithGIFData:imagedata];
    
    
    //自定义imageView
    
    UIImageView *cusImageV = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(150), KSCREEN_HEIGHT / 2.0 - KSCALE_WIDTH(75) / 2.0, KSCALE_WIDTH(75), KSCALE_WIDTH(75))];
    cusImageV.image = image;
    //设置hud模式
    
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    
    hud.removeFromSuperViewOnHide = YES;
    
    //设置提示性文字
    
    //    hud.label.text = @"正在加载中";
    
    //    // 设置文字大小
    
    //    hud.label.font = [UIFont systemFontOfSize:20];
    
    //    //设置文字的背景颜色
    
    //    //    hud.label.backgroundColor = [UIColor redColor];
    
    //
    
    //设置方框view为该模式后修改颜色才有效果
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //设置方框view背景色
    
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    //设置总背景view的背景色，并带有透明效果
    
    //    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    hud.customView = cusImageV;
    
}






//时间戳变为格式时间
+ (NSString *)ConvertStrToTime:(NSString *)timeStr withType:(NSString *)timeType {
    
    long long time=[timeStr longLongValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:timeType];
    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
    
}
//
//+(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
//    
//    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
//    
//    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
//    
//    double  distance  = [curLocation distanceFromLocation:otherLocation];
//    
//    return  distance;
//    
//}

+(NSString*)getWeekDay:(NSString*)currentStr

{
    
    long long time=[currentStr longLongValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    
    return[weekdays objectAtIndex:theComponents.weekday];
    
}

+ (CAGradientLayer *) getCAGradientLayerWithColors:(NSArray *)colors andFrame:(CGRect)frame {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors =colors;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}


+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
    
    
}

+(NSString *)getNowTimeTimestamp{
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}

+ (UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

//递归
+ (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}


//  AES加密
+ (NSData *)AES128_Encrypt:(NSString *)key encryptData:(NSData *)data{
    
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


//AES128解密data(带自定义向量)
+ (NSData *)AES128_Decrypt:(NSString *)key encryptData:(NSData *)data{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}


+ (NSString *)AES128_Decrypt:(NSString *)key withStr:(NSString *)str {
    
    NSData *data1 = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData * data2 = [QCClassFunction AES128_Decrypt:key encryptData:data1];
    
    NSString *output1 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    
    return output1;
}



//  字符串转json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSError *err;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//  json转字符串
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return jsonString;
}




//  MD5 加密
+ (NSString *)MD5:(NSString *)str {
    // 判断传入的字符串是否为空
    if (! str) return nil;
    // 转成utf-8字符串
    const char *cStr = str.UTF8String;
    // 设置一个接收数组
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    // 对密码进行加密
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *md5Str = [NSMutableString string];
    // 转成32字节的16进制
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}


+ (NSString *)iphoneType {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}


- (UIView *)createBackView {
    self.backView = [[UIView alloc] initWithFrame:KSCREEN_BOUNDS];
    self.backView.backgroundColor = KTEXT_COLOR;
    self.backView.backgroundColor = [KTEXT_COLOR colorWithAlphaComponent:0.5];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    tapGestureRecognizer.delegate = self;
    [self.backView addGestureRecognizer:tapGestureRecognizer];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    return self.backView;;
}

- (void)resignAction {
    [self removeBackView];
}


- (void)removeBackView {
    [self.backView removeFromSuperview];
    
}

+ (QCTarBarController *)getSelectTabViewControllerWithSelected:(NSInteger)seleted {
    QCTarBarController * tarBarController = [[QCTarBarController alloc] init];
    tarBarController.selectedIndex = seleted;
    if (@available(iOS 10.0, *)) {
        AppDelegate * appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = tarBarController;
        
    } else {
        
    }
    return tarBarController;
}


+ (void)loginWithWebsocket {
    //  连接登录 websocket
    NSString * str = [NSString stringWithFormat:@"token=%@&type=login&uid=%@",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"type":@"login",@"uid":K_UID};
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[QCWebSocket shared] sendDataToServer:jsonString];
}

+ (void)noticeWithmsgId:(NSString *)migId {
    //  连接登录 websocket
    NSString * str = [NSString stringWithFormat:@"smsid=%@&token=%@&type=notice&uid=%@",migId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"smsid":migId,@"token":K_TOKEN,@"type":@"notice",@"uid":K_UID};
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[QCWebSocket shared] sendDataToServer:jsonString];
}


+ (void)chatPermissions:(NSDictionary *)info success:(successChange)successBlock failure:(failureChange)failureBlock{
    //  连接登录 websocket
    NSString * str = [NSString stringWithFormat:@"fuid=%@&token=%@&type=%@&uid=%@",info[@"fuid"],K_TOKEN,info[@"type"],K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":info[@"fuid"],@"token":K_TOKEN,@"type":info[@"type"],@"uid":K_UID};
    
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    [QCAFNetWorking QCPOST:@"/api/chat/verify_chat" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        
        
        if ([responseObject[@"status"] intValue] == 1) {
            successBlock(@"1");
            
        }else{
            failureBlock(responseObject[@"msg"]);
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        successBlock(@"1");

    }];
    

}


//获取当前时间戳  （以毫秒为单位）

+(NSString *)getNowTimeTimestamp3{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}


+ (NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}




//时间显示内容
//+(NSString *)getDateDisplayString:(long long) miliSeconds{
//    NSLog(@"-时间戳---%lld_----",miliSeconds);
//
//    NSTimeInterval tempMilli = miliSeconds;
//    NSTimeInterval seconds = tempMilli/1000.0;
//    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
//
//    NSCalendar *calendar = [ NSCalendar currentCalendar ];
//    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
//    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
//
//    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
//
//    //2. 指定日历对象,要去取日期对象的那些部分.
//    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
//
//    if (nowCmps.year != myCmps.year) {
//        dateFmt.dateFormat = @"yyyy-MM-dd HH:mm";
//    } else {
//        if (nowCmps.day==myCmps.day) {
//            dateFmt.AMSymbol = @"上午";
//            dateFmt.PMSymbol = @"下午";
//            dateFmt.dateFormat = @"aaa hh:mm";
//
//        } else if((nowCmps.day-myCmps.day)==1) {
//            dateFmt.dateFormat = @"昨天";
//        } else {
//            if ((nowCmps.day-myCmps.day) <=7) {
//                switch (comp.weekday) {
//                    case 1:
//                        dateFmt.dateFormat = @"星期日";
//                        break;
//                    case 2:
//                        dateFmt.dateFormat = @"星期一";
//                        break;
//                    case 3:
//                        dateFmt.dateFormat = @"星期二";
//                        break;
//                    case 4:
//                        dateFmt.dateFormat = @"星期三";
//                        break;
//                    case 5:
//                        dateFmt.dateFormat = @"星期四";
//                        break;
//                    case 6:
//                        dateFmt.dateFormat = @"星期五";
//                        break;
//                    case 7:
//                        dateFmt.dateFormat = @"星期六";
//                        break;
//                    default:
//                        break;
//                }
//            }else {
//                dateFmt.dateFormat = @"MM-dd HH:mm";
//            }
//        }
//    }
//    return [dateFmt stringFromDate:myDate];
//}


//时间显示内容
+(NSString *)getDateDisplayString:(long long) miliSeconds{
    
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    //2. 指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy-MM-dd HH:mm";
    } else {
        if (nowCmps.day==myCmps.day) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"aaa hh:mm";
            
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天 aaahh:mm";

        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                
                dateFmt.AMSymbol = @"上午";
                dateFmt.PMSymbol = @"下午";
                
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日 aaahh:mm";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一 aaahh:mm";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二 aaahh:mm";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三 aaahh:mm";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四 aaahh:mm";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五 aaahh:mm";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六 aaahh:mm";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"MM-dd HH:mm";
            }
        }
    }
    return [dateFmt stringFromDate:myDate];
}


+ (NSMutableAttributedString *)stringToAttributeString:(NSString *)text{
    //先把普通的字符串text转化生成Attributed类型的字符串
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:text];
    //正则表达式 ,例如  [(呵呵)] = 😑
    NSString * zhengze = @"\\[[a-zA-Z0-9\u4e00-\u9fa5]+\\]";
    NSError * error;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:zhengze options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re)
    {
        //打印错误😓
        NSLog(@"error😓=%@",[error localizedDescription]);
    }
    NSArray * arr = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    NSDictionary *emotions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ChatEmotions" ofType:@"plist"]];
    NSArray * face = [emotions allValues];


    [attStr addAttribute:NSFontAttributeName
                     value:K_15_FONT
                     range:[text rangeOfString:text]];

    
    //如果有多个表情图，必须从后往前替换，因为替换后Range就不准确了
    for (int j =(int) arr.count - 1; j >= 0; j--) {
        //NSTextCheckingResult里面包含range
        NSTextCheckingResult * result = arr[j];
        for (int i = 0; i < face.count; i++) {
            
            
            
            if ([[text substringWithRange:result.range] isEqualToString:face[i]])//从数组中的字典中取元素
            {
                NSString * imageName = [NSString stringWithString:face[i]];
                //添加附件,图片
                NSTextAttachment * textAttachment = [[NSTextAttachment alloc]init];
                //调节表情大小
                textAttachment.bounds=CGRectMake(0, 0, KSCALE_WIDTH(20), KSCALE_WIDTH(20));
                textAttachment.image = [UIImage imageNamed:imageName];
                NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //替换未图片附件
                [attStr replaceCharactersInRange:result.range withAttributedString:imageStr];
                break;
            }
        }
    }

    return attStr;
}

+(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr

{
    
    NSData * decodedImageData   = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage * decodedImage      = [UIImage imageWithData:decodedImageData];
    
    return  decodedImage;
    
}

/**
*  根据图片url获取网络图片尺寸
*/
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/

            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
@end
