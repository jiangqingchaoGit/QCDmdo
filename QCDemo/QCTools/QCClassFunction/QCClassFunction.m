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
@implementation QCClassFunction


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
+(void)Save:(NSString*)str Key:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:key];
    [defaults synchronize];
}
+(id)Read:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
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
    //    [image sd_setImageWithURL:[NSURL URLWithString:[imageURL stringByAppendingString:string ? string : @""]] placeholderImage:[UIImage imageNamed:placeholderImage]];
    
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
+(void)filletImageView:(UIImageView *)imageView {
    imageView.layer.cornerRadius = 5;
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

@end
