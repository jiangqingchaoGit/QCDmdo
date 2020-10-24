//
//  QCClassFunction.h
//  E大夫在线3.0
//
//  Created by Leesin on 2017/1/23.
//  Copyright © 2017年 baisui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface QCClassFunction : NSObject

/*
 *  设置颜色
 */
+(UIColor *) stringTOColor:(NSString *)str;

/*
 *  父视图控制器
 */
+(UIViewController *)parentController:(UIView*)Self;

/*
 *  获取label的size
 */
+ (CGSize)getStrSize:(NSString *)textStr andTexFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/*
 *  手机号码验证
 */
+(BOOL)isMobile:(NSString *)mobileNumbel;

/*
 *  NSUserDefaults
 */
+(void)Save:(id)str Key:(NSString*)key;
+(id)Read:(NSString*)key;

/*
 *  身份证号验证
 */
+ (BOOL) validateIdentityCard: (NSString *)cardNo;

/*
 *  label的高度
 */
+(CGFloat)getHeighWithString:(NSString*)textStr andFontSize:(CGFloat)fontSize andConstrainedWidth:(CGFloat)width;
+(CGFloat)getWidthWithString:(NSString*)textStr andFontSize:(CGFloat)fontSize andConstrainedHeight:(CGFloat)height;

+(NSString *)descriptionWithDictionary:(NSDictionary*)locale;
+(NSString *)descriptionWithArray:(NSArray*)locale;
//获取图片
+(void)sd_imageView:(UIImageView*)image ImageURL:(NSString*)imageURL AppendingString:(NSString*)string placeholderImage:(NSString*)placeholderImage;

/*
 *  字体加粗处理
 */
+(NSMutableAttributedString *)getFontWithString:(NSString *)textStr andTargetString:(NSString *)targetString withFont:(CGFloat )font andTargetFont:(CGFloat )targetFont;
+(NSMutableAttributedString *)getBoldWithString:(NSString *)textStr andTargetString:(NSString *)targetString withFont:(CGFloat )font;

+(NSMutableAttributedString *)getBoldWithString:(NSString *)textStr andTargetString:(NSString *)targetString andTargetString1:(NSString *)targetString1 withFont:(CGFloat)font;
/*
 *  字体颜色处理
 */
+(NSMutableAttributedString *)getColorWithString:(NSString *)textStr andTargetString:(NSString *)targetString withColor:(UIColor *)color;

/*
 *  字体颜色处理
 */
+(NSMutableAttributedString *)getColorAndFontWithString:(NSString *)textStr andTargetString:(NSString *)targetString withColor:(UIColor *)color withFont:(CGFloat )font andTargetFont:(CGFloat )targetFont;

/*
 *  倒圆角
 */
+(void)filletImageView:(id)view withRadius:(CGFloat)radius;

/*
 *  设置状态栏背景颜色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color;

/*
 *  隐藏导航栏
 */
+ (void)hiddenNavigationBarWithUINavigationBar:(UINavigationBar *)navigationBar;


/*
 *  显示导航栏
 */
+ (void)accordingNavigationBarWithUINavigationBar:(UINavigationBar *)navigationBar;

/*
 *  获取根控制器
 */
+ (UIViewController *)getRootViewController;

/*
 *  获取当前页面控制器
 */
+ (UIViewController *)getCurrentViewController;

/*
 *  提示
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showGifToView:(UIView *)view;

/*
*  时间戳转时间
*/
+ (NSString *)ConvertStrToTime:(NSString *)timeStr withType:(NSString *)timeType;

/*
*  根据经纬度算距离
*/
+(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2;
+(NSString*)getWeekDay:(NSString*)currentStr;

/*
 *  渐变色
 */

+ (CAGradientLayer *) getCAGradientLayerWithColors:(NSArray *)colors andFrame:(CGRect)frame;

+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+(NSString *)getNowTimeTimestamp;

+ (UINavigationController *)currentNC;

+ (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc;


/*
 *  AES加密
 */
+ (NSData *)AES128_Encrypt:(NSString *)key encryptData:(NSData *)data;

+ (NSData *)AES128_Decrypt:(NSString *)key encryptData:(NSData *)data;

+ (NSString *)AES128_Decrypt:(NSString *)key withStr:(NSString *)str;

/*
 *  字符串转json
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/*
 *  json转字符串
 */
+ (NSString *) jsonStringWithDictionary:(NSDictionary *)dic;

/*
 *  MD5加密
 */
+ (NSString *)MD5:(NSString *)str;

+ (NSString *)iphoneType;
@end
