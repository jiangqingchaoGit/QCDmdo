#import "RSHandlePWDView.h"

#define RS_HandleBigCircleRadus     30.f
#define RS_HandleSmallCircleRadus   15.f
#define RS_CIRCLE_NOT_NEED_UPDATA   -1

@interface RSHandlePWDView()


/**
 显示默认圆（初始状态）
 */
@property(nonatomic,strong) CAShapeLayer*               circleLayer;

/**
 显示选中大圆
 */
@property(nonatomic,strong) CAShapeLayer*               selectedBigCircleLayer;

/**
 显示选中小圆
 */
@property(nonatomic,strong) CAShapeLayer*               selectedCircleLayer;

/**
 显示选中圆与圆之间的线
 */
@property(nonatomic,strong) CAShapeLayer*               linesLayer;

/**
 正在进行划线的起点
 */
@property(nonatomic,assign) CGPoint                     startPoint;

/**
 正在进行划线的终点
 */
@property(nonatomic,assign) CGPoint                     endPoint;

/**
 圆frame集合
 */
@property(nonatomic,strong) NSMutableArray*             bigCircleFrames;

/**
 保存手势数据
 */
@property(nonatomic,strong) NSMutableArray*             selectedValues;

/**
 选中小圆
 */
@property(nonatomic,strong) UIBezierPath*               selectedCirclePath;

/**
 选中大圆
 */
@property(nonatomic,strong) UIBezierPath*               selectedBigCirclePath;

/**
 选中圆之间的线
 */
@property(nonatomic,strong) UIBezierPath*               linePath;

/**
 临时layer，用于显示正在进行的划线
 */
@property(nonatomic,strong) CAShapeLayer*               tmpLayer;

/**
 临时线
 */
@property(nonatomic,strong) UIBezierPath*               tmpPath;
@end

@implementation RSHandlePWDView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark - override
- (void)layoutSubviews{
    [super layoutSubviews];
    self.circleLayer.frame = self.bounds;
    self.selectedCircleLayer.frame = self.bounds;
    self.selectedBigCircleLayer.frame = self.bounds;
    self.linesLayer.frame = self.bounds;
    self.tmpLayer.frame = self.bounds;
    if (!self.circleLayer.superlayer) {
        [self.layer addSublayer:self.circleLayer];
        [self RS_drawBigCircle];
    }
    if (!self.selectedCircleLayer.superlayer) {
        [self.layer addSublayer:self.selectedCircleLayer];
    }
    if (!self.selectedBigCircleLayer.superlayer) {
        [self.layer addSublayer:self.selectedBigCircleLayer];
    }
    if (!self.linesLayer.superlayer) {
        [self.layer addSublayer:self.linesLayer];
    }
    if (!self.tmpLayer.superlayer) {
        [self.layer addSublayer:self.tmpLayer];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = touches.anyObject;
    CGPoint startPoint = [touch locationInView:self];
    NSInteger index = [self RS_checkPointIfNeedSelect:startPoint];
    if (index != RS_CIRCLE_NOT_NEED_UPDATA) {
        self.startPoint = [self RS_setIndexSelectedAndReturnCircleCenterPoint:index];
    }else{
        self.startPoint = startPoint;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tmpPath removeAllPoints];
    [self.tmpPath moveToPoint:self.startPoint];
    UITouch* touch = touches.anyObject;
    CGPoint movePoint = [touch locationInView:self];
    NSInteger index = [self RS_checkPointIfNeedSelect:movePoint];
    if (index != RS_CIRCLE_NOT_NEED_UPDATA) {
        CGPoint center = [self RS_setIndexSelectedAndReturnCircleCenterPoint:index];
        self.startPoint = center;
    }else{
        self.endPoint = movePoint;
        if ([self RS_checkPointInsideCircle:self.startPoint]) {
            [self.tmpPath addLineToPoint:self.endPoint];
            self.tmpLayer.path = self.tmpPath.CGPath;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePWDView:inputComplate:)]) {
        [self.delegate handlePWDView:self inputComplate:self.selectedValues.copy];
    }
    [self RS_reset];
}

#pragma mark - private

/**
 绘制初始状态大圆
 */
- (void)RS_drawBigCircle{
    UIBezierPath* path = [UIBezierPath bezierPath];
    CGFloat margin = (CGRectGetWidth(self.bounds) -3*2*RS_HandleBigCircleRadus)/2.0;
    for (int index = 0; index < 9; index++) {
        CGRect frame = CGRectMake(index%3*(2*RS_HandleBigCircleRadus+margin), (index/3)*(2*RS_HandleBigCircleRadus+margin), 2*RS_HandleBigCircleRadus, 2*RS_HandleBigCircleRadus);
        UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
        [path appendPath:circlePath];
        [self.bigCircleFrames addObject:NSStringFromCGRect(frame)];
    }
    self.circleLayer.path = path.CGPath;
    [self.circleLayer setNeedsDisplay];
}

/**
 重置状态
 */
- (void)RS_reset{
    [self.selectedValues removeAllObjects];
    self.startPoint = CGPointZero;
    self.endPoint = CGPointZero;
    [self.selectedCirclePath removeAllPoints];
    self.selectedCircleLayer.path = self.selectedCirclePath.CGPath;
    [self.selectedBigCirclePath removeAllPoints];
    self.selectedBigCircleLayer.path = self.selectedBigCirclePath.CGPath;
    [self.linePath removeAllPoints];
    self.linesLayer.path = self.linePath.CGPath;
    [self.tmpPath removeAllPoints];
    self.tmpLayer.path = self.tmpPath.CGPath;
}


/**
 检测坐标点位置是否需要更新圆的状态
 
 @param point 坐标点
 @return 需要更新->对应圆的索引;不需要->RS_CIRCLE_NOT_NEED_UPDATA
 */
- (NSInteger)RS_checkPointIfNeedSelect:(CGPoint)point{
    __block NSInteger index = RS_CIRCLE_NOT_NEED_UPDATA;
    [self.bigCircleFrames enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(CGRectFromString(obj), point) && ![self.selectedValues containsObject:@(idx)]) {
            index = idx;
            return ;
        }
    }];
    return index;
}

/**
 验证点是否在任意园内
 
 @param point 坐标点
 @return YES/NO
 */
- (BOOL)RS_checkPointInsideCircle:(CGPoint)point{
    __block BOOL isInside = NO;
    [self.bigCircleFrames enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(CGRectFromString(obj), point)) {
            isInside = YES;
            return ;
        }
    }];
    return isInside;
}

/**
 设置index索引所对用的圆为选中
 
 @param index 索引
 @return index所对用圆的中心点
 */
- (CGPoint)RS_setIndexSelectedAndReturnCircleCenterPoint:(NSInteger)index{
    CGRect frame = CGRectFromString(self.bigCircleFrames[index]);
    CGPoint center = CGPointMake( CGRectGetMaxX(frame)-RS_HandleBigCircleRadus, CGRectGetMaxY(frame)-RS_HandleBigCircleRadus);
    //绘制小圆
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:RS_HandleSmallCircleRadus startAngle:0 endAngle:2*M_PI clockwise:1];
    [self.selectedCirclePath appendPath:circlePath];
    self.selectedCircleLayer.path = self.selectedCirclePath.CGPath;
    //绘制大圆（选中状态）
    UIBezierPath* bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [self.selectedBigCirclePath appendPath:bigCirclePath];
    self.selectedBigCircleLayer.path = self.selectedBigCirclePath.CGPath;
    //绘制圆与圆之间的线
    self.selectedValues.count == 0 ? [self.linePath moveToPoint:center] : [self.linePath addLineToPoint:center];
    self.linesLayer.path = self.linePath.CGPath;
    [self.selectedValues addObject:@(index)];
    return center;
}

#pragma mark - setter
- (void)setBigCircleStrokeColor:(UIColor *)bigCircleStrokeColor{
    _bigCircleStrokeColor = bigCircleStrokeColor;
    self.circleLayer.strokeColor = _bigCircleStrokeColor.CGColor;
}

- (void)setBigCircleSelectedStrokeColor:(UIColor *)bigCircleSelectedStrokeColor{
    _bigCircleSelectedStrokeColor = bigCircleSelectedStrokeColor;
    self.selectedBigCircleLayer.strokeColor = _bigCircleSelectedStrokeColor.CGColor;
}

- (void)setSmallCircleSelectedStrokeColor:(UIColor *)smallCircleSelectedStrokeColor{
    _smallCircleSelectedStrokeColor = smallCircleSelectedStrokeColor;
    self.selectedCircleLayer.strokeColor = _smallCircleSelectedStrokeColor.CGColor;
}

- (void)setSmallCircleFillColor:(UIColor *)smallCircleFillColor{
    _smallCircleFillColor = smallCircleFillColor;
    self.selectedCircleLayer.fillColor = _smallCircleFillColor.CGColor;
}

- (void)setLineStrokeColor:(UIColor *)lineStrokeColor{
    _lineStrokeColor = lineStrokeColor;
    self.linesLayer.strokeColor = _lineStrokeColor.CGColor;
    self.tmpLayer.strokeColor = _lineStrokeColor.CGColor;
}

#pragma mark - getter
- (CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.lineWidth = 2.0;
        _circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _circleLayer;
}

- (CAShapeLayer *)selectedCircleLayer{
    if (!_selectedCircleLayer) {
        _selectedCircleLayer = [CAShapeLayer layer];
        _selectedCircleLayer.lineWidth = 2.0;
        _selectedCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _selectedCircleLayer.fillColor = [UIColor colorWithRed:25/255.0 green:177/255.0 blue:1.0 alpha:1.0].CGColor;
    }
    return _selectedCircleLayer;
}

- (CAShapeLayer*)selectedBigCircleLayer{
    if (!_selectedBigCircleLayer) {
        _selectedBigCircleLayer = [CAShapeLayer layer];
        _selectedBigCircleLayer.lineWidth = 2.0;
        _selectedBigCircleLayer.strokeColor = [UIColor yellowColor].CGColor;
        _selectedBigCircleLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _selectedBigCircleLayer;
}

- (CAShapeLayer *)linesLayer{
    if (!_linesLayer) {
        _linesLayer = [CAShapeLayer layer];
        _linesLayer.lineWidth = 2.0;
        _linesLayer.strokeColor = [UIColor colorWithRed:25/255.0 green:177/255.0 blue:1.0 alpha:1.0].CGColor;
        _linesLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _linesLayer;
}

- (NSMutableArray *)bigCircleFrames{
    if (!_bigCircleFrames) {
        _bigCircleFrames = @[].mutableCopy;
    }
    return _bigCircleFrames;
}

- (NSMutableArray *)selectedValues{
    if (!_selectedValues) {
        _selectedValues = @[].mutableCopy;
    }
    return _selectedValues;
}

- (UIBezierPath *)selectedCirclePath{
    if (!_selectedCirclePath) {
        _selectedCirclePath = [UIBezierPath bezierPath];
    }
    return _selectedCirclePath;
}

- (UIBezierPath*)selectedBigCirclePath{
    if (!_selectedBigCirclePath) {
        _selectedBigCirclePath = [UIBezierPath bezierPath];
    }
    return _selectedBigCirclePath;
}

- (UIBezierPath *)linePath{
    if (!_linePath) {
        _linePath = [UIBezierPath bezierPath];
    }
    return _linePath;
}

- (CAShapeLayer *)tmpLayer{
    if (!_tmpLayer) {
        _tmpLayer = [CAShapeLayer layer];
        _tmpLayer.lineWidth = 2.0;
        _tmpLayer.strokeColor = [UIColor colorWithRed:25/255.0 green:177/255.0 blue:1.0 alpha:1.0].CGColor;
        _tmpLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _tmpLayer;
}

- (UIBezierPath *)tmpPath{
    if (!_tmpPath) {
        _tmpPath = [UIBezierPath bezierPath];
    }
    return _tmpPath;
}
@end
