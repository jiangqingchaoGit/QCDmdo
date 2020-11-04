
#import <UIKit/UIKit.h>

/**
 手势密码视图
 */
@class RSHandlePWDView;


@protocol RSHandlePWDViewDelegate<NSObject>

@optional

/**
 手势完成回调

 @param handleView 手势视图对象
 @param complateResult 手势密码
 */
- (void)handlePWDView:(RSHandlePWDView*)handleView inputComplate:(NSArray*)complateResult;
@end

@interface RSHandlePWDView : UIView



/**
 大圆默认颜色
 */
@property(nonatomic,strong) UIColor*                bigCircleStrokeColor;

/**
 大圆选中颜色
 */
@property(nonatomic,strong) UIColor*                bigCircleSelectedStrokeColor;


/**
 小圆选中颜色
 */
@property(nonatomic,strong) UIColor*                smallCircleSelectedStrokeColor;

/**
 小圆填充色
 */
@property(nonatomic,strong) UIColor*                smallCircleFillColor;

/**
 线颜色
 */
@property(nonatomic,strong) UIColor*                lineStrokeColor;

/**
 代理
 */
@property(nonatomic,weak) id<RSHandlePWDViewDelegate>       delegate;
@end
