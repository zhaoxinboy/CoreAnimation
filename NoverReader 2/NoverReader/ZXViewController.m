//
//  ZXViewController.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/9.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "ZXViewController.h"
#import "ZXNumView.h"
#import <GLKit/GLKit.h>
#import <GLKit/GLKMatrix3.h>
#import <GLKit/GLKMatrix4.h>
#import <CoreText/CoreText.h>
#import "ReflectionView.h"
#import "ScrollView.h"
#import <AVFoundation/AVFoundation.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

#define sWIDTH 10
#define sHEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500
#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)






@interface ZXViewController ()<CALayerDelegate, CAAnimationDelegate>

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIView *coneView;

@property (nonatomic, strong) UIView *shipView;

@property (nonatomic, strong) UIView  *iglooView;

@property (nonatomic, strong) UIView *anchorView;


@property (nonatomic, strong) UIView *button1;

@property (nonatomic, strong) UIView *button2;


@property (nonatomic, strong) UIView *greenView;

@property (nonatomic, strong) UIView *redView;


@property (nonatomic, strong) CALayer *blueLayer;


@property (nonatomic, strong) UIView *layerView1;

@property (nonatomic, strong) UIView *layerView2;

@property (nonatomic, strong) UIView *shadowView;


@property (nonatomic, strong) UIImageView *imageView;


@property (nonatomic, strong) UIView *outerView;

@property (nonatomic, strong) UIView *innerView;

@property (nonatomic, strong) UIView *containerView;  //骰子容器
@property (nonatomic, strong) ZXNumView *view1;
@property (nonatomic, strong) ZXNumView *view2;
@property (nonatomic, strong) ZXNumView *view3;
@property (nonatomic, strong) ZXNumView *view4;
@property (nonatomic, strong) ZXNumView *view5;
@property (nonatomic, strong) ZXNumView *view6;
@property (nonatomic, strong) NSMutableArray *faces;      // 数组


@property (nonatomic, strong) UIView *glView;      //
@property (nonatomic, strong) EAGLContext *glcontext;      //
@property (nonatomic, strong) CAEAGLLayer *glLayer;      //
@property (nonatomic, assign) GLuint framebuffer;      // 大小缓冲
@property (nonatomic, assign) GLuint colorRenderbuffer;      // 颜色渲染缓冲
@property (nonatomic, assign) GLint framebufferWidth;      // 缓冲宽度
@property (nonatomic, assign) GLint framebufferHeight;      // 缓冲高度
@property (nonatomic, strong) GLKBaseEffect *effect;      // 效果

// 隐式动画
@property (nonatomic, strong) UIView *layerView;      //
@property (nonatomic, strong) CALayer *colorLayer;      //

// 显式动画
@property (nonatomic, strong) UIImageView *imageView1;      //
@property (nonatomic, strong) NSArray *images;      //


@property (nonatomic, strong) CALayer *shipLayer;      // 船



@property (nonatomic, strong) UITextField *durationField;      //
@property (nonatomic, strong) UITextField *repeatField;      //
@property (nonatomic, strong) UIButton *startButton;      //

@property (nonatomic, strong) CALayer *doorLayer;      //

@property (nonatomic, strong) UIScrollView *scrollView;      //


@end

@implementation ZXViewController

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = kRGBColor(100, 100, 100);
        _containerView.frame = CGRectMake(10, 10, kWindowW - 20, kWindowH - 20);
        [self.view addSubview:_containerView];
    }
    return _containerView;
}

- (ZXNumView *)view1 {
    if (!_view1) {
        _view1 = [[ZXNumView alloc] init];
        _view1.bounds = CGRectMake(0, 0, 200, 200);
        [_view1 setlabelNum:1];
    }
    return _view1;
}
- (ZXNumView *)view2 {
    if (!_view2) {
        _view2 = [[ZXNumView alloc] init];
        _view2.bounds = CGRectMake(0, 0, 200, 200);
        [_view2 setlabelNum:2];
    }
    return _view2;
}
- (ZXNumView *)view3 {
    if (!_view3) {
        _view3 = [[ZXNumView alloc] init];
        _view3.bounds = CGRectMake(0, 0, 200, 200);
        [_view3 setlabelNum:3];
    }
    return _view3;
}
- (ZXNumView *)view4 {
    if (!_view4) {
        _view4 = [[ZXNumView alloc] init];
        _view4.bounds = CGRectMake(0, 0, 200, 200);
        [_view4 setlabelNum:4];
    }
    return _view4;
}
- (ZXNumView *)view5 {
    if (!_view5) {
        _view5 = [[ZXNumView alloc] init];
        _view5.bounds = CGRectMake(0, 0, 200, 200);
        [_view5 setlabelNum:5];
    }
    return _view5;
}
- (ZXNumView *)view6 {
    if (!_view6) {
        _view6 = [[ZXNumView alloc] init];
        _view6.bounds = CGRectMake(0, 0, 200, 200);
        [_view6 setlabelNum:6];
    }
    return _view6;
}


- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
//        _whiteView.layer.cornerRadius = 100;
        
//        _whiteView.layer.shadowColor = [UIColor blueColor].CGColor;//shadowColor阴影颜色
//        _whiteView.layer.shadowOffset = CGSizeMake(0, -3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        _whiteView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//        _whiteView.layer.shadowRadius = 4;//阴影半径，默认
//        
//        _whiteView.clipsToBounds = NO;
        [self.view addSubview:_whiteView];
        [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
        
//        CALayer *redLayer = [CALayer layer];
//        redLayer.frame = CGRectMake(50, 50, 100, 100);
//        redLayer.backgroundColor = [UIColor redColor].CGColor;
//        [_whiteView.layer addSublayer:redLayer];
//        
//        redLayer.masksToBounds = YES;
//        redLayer.cornerRadius = 50;
    }
    return _whiteView;
}




#pragma mark -
- (void)oc_addSubviews{
    [self whiteView];
    
    UIImage *image = [UIImage imageNamed:@"timg-1"];
    self.whiteView.layer.contents = (__bridge id)image.CGImage;
    self.whiteView.layer.contentsGravity = kCAGravityCenter; // 此属性对应UIview中的cotentMode属性
    self.whiteView.layer.contentsScale = image.scale;
    
}




#pragma mark - 图片拼接  contentsRect

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

- (void)oc_addcontentsRect {
    
    self.coneView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, 100, 100)];
    [self.view addSubview:self.coneView];
    self.shipView = [[UIView alloc] initWithFrame:CGRectMake(130, 60, 100, 100)];
    [self.view addSubview:self.shipView];
    self.iglooView = [[UIView alloc] initWithFrame:CGRectMake(20, 160, 100, 100)];
    [self.view addSubview:self.iglooView];
    self.anchorView = [[UIView alloc] initWithFrame:CGRectMake(140, 180, 100, 100)];
    [self.view addSubview:self.anchorView];
    
    
    UIImage *image = [UIImage imageNamed:@"timg-1"];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.coneView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.anchorView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.shipView.layer];
    
}

#pragma mark - contentsCenter

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsCenter = rect;
}

- (void)oc_addcontentsCenter {
    self.button1 = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    [self.view addSubview:self.button1];
    self.button2 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [self.view addSubview:self.button2];
    
    UIImage *image = [UIImage imageNamed:@"timg-1"];
    [self addStretchableImage:image withContentCenter:CGRectMake(0.1, 0.1, 0.1, 0.1) toLayer:self.button1.layer];
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.button2.layer];
}

#pragma mark - CALayerDelegate

- (void)oc_addCALayerDelegate {
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.whiteView.layer addSublayer:blueLayer];
    [blueLayer display];
}

// display 后 调用此方法（CALayerDelegate方法实现） 参数一个为调用ddisplay的实例 另一个为在此实例上新创建的一个画布
- (void)drawLayer:(CALayer *)layer inContext:(nonnull CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


#pragma mark - zPosition     z坐标，变换视图显示层次

// 注意 zPosition虽然能改变图层显示顺序，但无法改变事件的传递顺序
- (void)oc_addzPosition {
    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    self.greenView.layer.zPosition = 1.0f;
}


#pragma mark - containsPoint  and hitTest

- (void)oc_addContainsPoint {
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50, 50, 100, 100);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.whiteView.layer addSublayer:self.blueLayer];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
////     containsPoint
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    point = [self.whiteView.layer convertPoint:point fromLayer:self.view.layer];
//    if ([self.whiteView.layer containsPoint:point]) {
//        point = [self.blueLayer convertPoint:point fromLayer:self.whiteView.layer];
//        if ([self.blueLayer containsPoint:point]) {
//            [[[UIAlertView alloc] initWithTitle:@"点击了蓝色layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles: nil] show];
//        }else{
//            [[[UIAlertView alloc] initWithTitle:@"点击了白色layer"
//                                         message:nil
//                                        delegate:nil
//                               cancelButtonTitle:@"OK"
//                               otherButtonTitles:nil] show];
//        }
//    }
//    
//     // hitTest
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    CALayer *layer = [self.whiteView.layer hitTest:point];
//    if (layer == self.blueLayer) {
//        [[[UIAlertView alloc] initWithTitle:@"点击了蓝色layer"
//                                    message:nil
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles: nil] show];
//    }else if (layer == self.whiteView.layer) {
//        [[[UIAlertView alloc] initWithTitle:@"点击了白色layer"
//                                    message:nil
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil] show];
//    }
//}


#pragma mark - showView    解决阴影裁切问题(添加一个额外的视图)
- (void)oc_solveShowView {
    self.layerView1 = [[UIView alloc] initWithFrame:CGRectMake((kWindowW - 100) / 2, 100, 100, 100)];
    self.layerView1.backgroundColor = [UIColor whiteColor];
    self.layerView1.layer.cornerRadius = 20;
    self.layerView1.layer.borderWidth = 5;
    self.layerView1.layer.shadowOpacity = 0.5;
    self.layerView1.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layerView1.layer.shadowRadius = 5;
    [self.view addSubview:_layerView1];
    self.layerView2 = [[UIView alloc] initWithFrame:CGRectMake((kWindowW - 100) / 2, 300, 100, 100)];
    self.layerView2.backgroundColor = [UIColor whiteColor];
    self.layerView2.layer.cornerRadius = 20;
    self.layerView2.layer.borderWidth = 5;
    self.layerView2.layer.masksToBounds = YES;
    [self.view addSubview:_layerView2];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(-20, -20, 50, 50)];
    view1.backgroundColor = [UIColor redColor];
    [self.layerView1 addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(-20, -20, 50, 50)];
    view2.backgroundColor = [UIColor redColor];
    [self.layerView2 addSubview:view2];
    
}

#pragma mark - shadowPath 指定任意阴影形状
- (void)oc_addShadowPath {
    self.layerView1 = [[UIView alloc] initWithFrame:CGRectMake((kWindowW - 100) / 2, 100, 100, 100)];
    self.layerView1.layer.shadowOpacity = 0.5;
    self.layerView1.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    [self.view addSubview:_layerView1];
    self.layerView2 = [[UIView alloc] initWithFrame:CGRectMake((kWindowW - 100) / 2, 300, 100, 100)];
    self.layerView2.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    self.layerView2.layer.shadowOpacity = 0.5;
    [self.view addSubview:_layerView2];
    
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, self.layerView1.bounds);
    
    self.layerView1.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.layerView2.bounds);
    
    self.layerView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
}

#pragma mark - mask
- (void)oc_addMask {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg-1"]];
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:self.imageView];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, 50, 50);
    UIImage *maskimage = [UIImage imageNamed:@"timg-1"];
    maskLayer.contents = (__bridge id)maskimage.CGImage;
    
    self.imageView.layer.mask = maskLayer;
}


#pragma mark - minificationFilter magnificationFilter 拉伸过滤
- (void)oc_addlashen {
    UIImage *digits = [UIImage imageNamed:@"000"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 500, 50)];
    [self.view addSubview:view];
    view.layer.contents = (__bridge id)digits.CGImage;
    view.layer.contentsRect = CGRectMake(0, 0, 1, 1.0);
    view.layer.contentsGravity = kCAGravityResizeAspect;
    view.layer.magnificationFilter = kCAFilterNearest;
}

#pragma mark - shouldRasterize 组透明问题
- (UIButton *)customButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 110, 30)];
    label.text = @"hello world";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}

- (void)oc_addShouldRasterize {
    
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(100, 150);
    [self.view addSubview:button1];
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(100, 300);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    button2.layer.shouldRasterize = YES;
    
    // 防止出现图片像素化问题
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
}

- (void)oc_addAffineTransform {
//    self.whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
//    self.whiteView.layer.affineTransform = transform;
    
    //组合变换
    self.whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    CGAffineTransform transform = CGAffineTransformIdentity;// 初始化一个空的transform
    transform = CGAffineTransformScale(transform, 0.5, 0.5);//缩放50%
    transform = CGAffineTransformRotate(transform, M_PI / 180 * 30.0);//旋转30度
    transform = CGAffineTransformTranslate(transform, 200, 0); //移动200个点
    self.whiteView.layer.affineTransform = transform;
}

- (void)oc_addCATransform3D {
    // 失真的3D变换
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    self.whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
//    self.whiteView.layer.transform = transform;
    
    
    // 通过修改m34保真
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    self.whiteView.layer.transform = transform;
}


#pragma mark - sublayerTransform
- (void)oc_addSublayerTransform {
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    
    self.layerView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    self.layerView1.backgroundColor = [UIColor whiteColor];
    self.layerView1.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    [self.view addSubview:_layerView1];
    
    self.layerView2 = [[UIView alloc] initWithFrame:CGRectMake(kWindowW - 110, 100, 100, 100)];
    self.layerView2.backgroundColor = [UIColor whiteColor];
    self.layerView2.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    [self.view addSubview:_layerView2];
    
    
    
    
    //如果有多个图层需要3D变换，那么就需要设置相同的m34值来保证视觉效果，那么 可以设置父视图的sublayerTransform来影响所有图层
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    
    self.layerView1.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    
    self.layerView2.layer.transform = transform2;
    
    
}

#pragma mark - doubleSided 绘制图层的背面是否要被绘制
- (void)oc_addDoubleSided {
    self.layerView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    self.layerView1.backgroundColor = [UIColor whiteColor];
    self.layerView1.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    [self.view addSubview:_layerView1];
    
    self.layerView2 = [[UIView alloc] initWithFrame:CGRectMake(kWindowW - 110, 100, 100, 100)];
    self.layerView2.backgroundColor = [UIColor whiteColor];
    self.layerView2.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
    [self.view addSubview:_layerView2];
    
    
    self.layerView2.layer.doubleSided = NO; //此属性控制图层的背面是否需要绘制
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    
    self.layerView1.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    
    self.layerView2.layer.transform = transform2;
    
}


#pragma mark - 扁平化图层
- (void)oc_reverseRotation {
    self.outerView = [[UIView alloc] initWithFrame:CGRectMake(kWindowW / 2 - 50, 100, 100, 100)];
    self.outerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.outerView];
    
    self.innerView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    self.innerView.backgroundColor = [UIColor grayColor];
    [self.outerView addSubview:self.innerView];
    
    
    
//    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
//    self.outerView.layer.transform = outer;
//    
//    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
//    self.innerView.layer.transform = inner;
    
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.outerView.layer.transform = outer;
    
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.innerView.layer.transform = inner;
    
}


#pragma mark - 正方体

// 如果想让3相应点击事件，必须遵循事件响应链

// 给正方体加上投影效果
- (void)applyLightingToFace:(CALayer *)face {
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应做一次float到CGFloat的转换
    
    
    
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
    
    // 给正方体加投影效果，无效果，具体原因不清楚。。。。

}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    ZXNumView *face = self.faces[index];
    [self.containerView addSubview:face];
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
    [self applyLightingToFace:face.layer];
}

- (void)oc_addzhengfangti {
    self.faces = [[NSMutableArray alloc] init];
    [self.faces addObject:self.view1];
    [self.faces addObject:self.view2];
    [self.faces addObject:self.view3];
    [self.faces addObject:self.view4];
    [self.faces addObject:self.view5];
    [self.faces addObject:self.view6];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    
    
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}


#pragma mark - CAShapeLayer
- (void)oc_addCAShapeLayer {
    // 火柴人
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:(2*M_PI) clockwise:yellow_color];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 170)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
    
    //部分圆角路径
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.strokeColor = [UIColor redColor].CGColor;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.lineWidth = 5;
    shapelayer.lineJoin = kCALineJoinRound;
    shapelayer.lineCap = kCALineJoinRound;
    shapelayer.path = path.CGPath;
    [self.containerView.layer addSublayer:shapelayer];
    
    
}


#pragma mark - CATextLayer
- (void)oc_addCATextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:textLayer];
    
    textLayer.contentsScale = [UIScreen mainScreen].scale; //防止像素化
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified; //对齐方式
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
//    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
//    textLayer.font = fontRef;
//    textLayer.fontSize = font.pointSize;
//    CGFontRelease(fontRef);
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    CFStringRef fontName = (__bridge CGPDFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    NSDictionary *attribs = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName : (__bridge id)fontRef};
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName : (__bridge id)fontRef};
    
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    CFRelease(fontRef);
    
    textLayer.string = string; // string属性为id类型，所以既可以用NSString也可以用NSAttributedString
}

#pragma mark - CATransformlayer  变换组
- (CALayer *)faceWithTransform:(CATransform3D)transform {
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    face.transform = transform;
    return face;
}
- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    CATransformLayer *cubt = [CATransformLayer layer]; // 必须有变换才能真实存在 在这里相当于创建了一个正方体对象
    
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cubt addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubt addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubt addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cubt addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cubt addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cubt addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.containerView.bounds.size;
    cubt.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    //apply the transform and return
    cubt.transform = transform;
    return cubt;
}



- (void)oc_addCATransformlayer {
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    
    self.containerView.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.containerView.layer addSublayer:cube1];
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cube2];
}

#pragma mark - CAGradientLayer  颜色渐变
- (void)oc_addCAGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor , (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.0, @0.1, @0.2];     //这两个数组的元素个数必须相同，否则会有空白 若不设置locations，颜色渐变将是均匀的
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

#pragma mark - CAReplicatorLayer  重复图层
- (void)oc_addCAReplicatorLayer {
    UIView *conview = [[UIView alloc] initWithFrame:CGRectMake(kWindowW / 2 - 50, kWindowH / 2 - 50, 100, 100)];
    conview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:conview];
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    
    replicator.frame = conview.bounds;
    [conview.layer addSublayer:replicator];
    
    replicator.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

#pragma mark - 反转效果 reflection
- (void)oc_addReflectionView {
//    ReflectionView *view = [[ReflectionView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.layer.contents = (__bridge id)[UIImage imageNamed:@"timg-1"].CGImage;
//    [self.view addSubview:view];
    
    
    ScrollView *sview = [[ScrollView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    sview.layer.contents = (__bridge id)[UIImage imageNamed:@"a01"].CGImage;
    [self.view addSubview:sview];
}

#pragma mark - CAEmitterLayer 粒子效果
- (void)oc_addCAEmitterLayer {
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    self.containerView.frame = CGRectMake(100, 100, 100, 100);
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    emitter.renderMode = kCAEmitterLayerUnordered;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"11-1"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    emitter.emitterCells = @[cell];
}

#pragma mark - CAEAGLLayer
- (void)viewDidUnload
{
    [self tearDownBuffers];
    [super viewDidUnload];
}

- (void)dealloc
{
    [self tearDownBuffers];
    [EAGLContext setCurrentContext:nil];
}

- (void)oc_addCAEAGLLayer {
    
    self.glView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.glView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.glView];
    
    self.glcontext = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.glcontext];
    
    //set up layer
    self.glLayer = [CAEAGLLayer layer];
    self.glLayer.frame = self.glView.bounds;
    [self.glView.layer addSublayer:self.glLayer];
    self.glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@NO, kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8};
    
    //set up base effect
    self.effect = [[GLKBaseEffect alloc] init];
    
    //set up buffers
    [self setUpBuffers];
    
    //draw frame
    [self drawFrame];
}

- (void)setUpBuffers {
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glGenRenderbuffers(1, &_colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderbuffer);
    [self.glcontext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.glLayer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_framebufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_framebufferHeight);
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"Failed to make complete framebuffer object: %i", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}
- (void)tearDownBuffers
{
    if (_framebuffer) {
        //delete framebuffer
        glDeleteFramebuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
    
    if (_colorRenderbuffer) {
        //delete color render buffer
        glDeleteRenderbuffers(1, &_colorRenderbuffer);
        _colorRenderbuffer = 0;
    }
}
- (void)drawFrame {
    //bind framebuffer & set viewport
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glViewport(0, 0, _framebufferWidth, _framebufferHeight);
    
    //bind shader program
    [self.effect prepareToDraw];
    
    //clear the screen
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(0.0, 0.0, 0.0, 1.0);
    
    //set up vertices
    GLfloat vertices[] = {
        -0.5f, -0.5f, -1.0f, 0.0f, 0.5f, -1.0f, 0.5f, -0.5f, -1.0f,
    };
    
    //set up colors
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f,
    };
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor,4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    //present render buffer
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    [self.glcontext presentRenderbuffer:GL_RENDERBUFFER];
}

#pragma mark - AVPlayer 
- (void)oc_addAVPlayer {
    
    self.containerView.frame = CGRectMake(100, 100, kWindowW - 200, kWindowH - 200);
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"QQ20170523-161607-HD" withExtension:@"mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];;
    playerLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playerLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 40.0;
    playerLayer.borderColor = [UIColor blueColor].CGColor;
    playerLayer.borderWidth = 2.0;
    
    [player play];
}

#pragma mark - 隐式动画
- (void)oc_addChangeColorLayer {
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.layerView.layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view addSubview:self.layerView];
    
    // 当对UIview操作时   用不到此layer
    /*
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
     */
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"换颜色" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 10, 100, 30);
    [btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.layerView addSubview:btn];
    
}

#pragma mark - 自定义图层动画
- (void)oc_addcustomAnimation {
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.layerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:self.layerView];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor" : transition};
    [self.layerView.layer addSublayer:self.colorLayer];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"换颜色" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 10, 100, 30);
    [btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.layerView addSubview:btn];
    
}

- (void)changeColor {
    
    
    
    //自定义图层动画
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    
    // 此处为直接对UIview操作    事实证明，UIview关闭了隐式动画
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    self.layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    
//    [CATransaction commit];
    
    
    
    
    /********************************************此处为对layer操作
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    [CATransaction setCompletionBlock:^{
        [CATransaction begin];
        [CATransaction setAnimationDuration:2.0];
        
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
        
        [CATransaction commit];
    }]; //动画完成后执行的代码块
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    [CATransaction commit];
     */
}

#pragma mark - 判断图层位置
- (void)oc_addlayerLocation {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame  = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    if ([self.colorLayer.presentationLayer hitTest:point]) {
//        
//        //当图层在移动过程中，直接修改colorlayer的hittest方法并不能返回正确的结果，，所以用presentationLayer图层来确定当前图层的位置
//        
//        CGFloat red = arc4random() / (CGFloat)INT_MAX;
//        CGFloat green = arc4random() / (CGFloat)INT_MAX;
//        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    }else {
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:4.0];
//        self.colorLayer.position = point;
//        [CATransaction commit];
//    }
    
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]]; //动画的脉冲效果
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    [CATransaction commit];
}



#pragma mark - 显式动画
- (void)oc_addxianshiAnimation {
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.layerView.layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view addSubview:self.layerView];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"换颜色" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 10, 100, 30);
    [btn addTarget:self action:@selector(changeColor1) forControlEvents:UIControlEventTouchUpInside];
    [self.layerView addSubview:btn];
}

- (void)changeColor1 {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = (__bridge id)color.CGColor;
//    animation.delegate = self;
//    [self.colorLayer addAnimation:animation forKey:nil];
    
    // CAKeyframeAnimation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn, fn, fn]; //动画的脉冲效果
    [self.colorLayer addAnimation:animation forKey:nil];
    
    
    // 这里要注意，动画区分的方式不能是指针的比较
    // 即，不可把动画设置为属性然后通过代理方法的参数来判断，因为代理方法的入参是动画实例的深拷贝，与先前的值并不相同
}
#pragma mark CAAnimationDelegate
//- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
//    [CATransaction commit];
//    
//}


#pragma mark - 沿着贝塞尔曲线对图层做动画
- (void)oc_addBezierPathAnimation {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"11-1"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0f;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto; //让图片时刻保持跟曲线相切
    
    [shipLayer addAnimation:animation forKey:nil];
}

#pragma mark - 用transform属性对图层做动画
- (void)oc_addTransformAnimation {
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"11-1"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation"; //transform.rotation虚拟属性
    animation.duration = 2.0;
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    animation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:animation forKey:nil];
}

#pragma mark - 组合动画
- (void)oc_addCAAnimationGroup {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:colorLayer];
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 4.0;
    groupAnimation.animations = @[animation1, animation2];
    [colorLayer addAnimation:groupAnimation forKey:nil];
}

#pragma mark - 使用CATransition来对UIImageView做动画
- (NSArray *)images {
    if (!_images) {
        _images = [[NSArray alloc] init];
    }
    return _images;
}

- (void)oc_addCATransitionUIImageView {
    self.imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11-1"]];
    self.imageView1.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:self.imageView1];
    self.images = @[[UIImage imageNamed:@"11-1"],
                    [UIImage imageNamed:@"timg-1"],
                    [UIImage imageNamed:@"000"],
                    [UIImage imageNamed:@"timg"]
                    ];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"换颜色" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 10, 100, 30);
    [btn addTarget:self action:@selector(switchImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)switchImage {
    [UIView transitionWithView:self.imageView1 duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        UIImage *currentImage = self.imageView1.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1) % [self.images count];
        self.imageView1.image = self.images[index];
    } completion:NULL];
    
    
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionFade;
//    [self.imageView1.layer addAnimation:transition forKey:nil];
//    UIImage *currentImage = self.imageView1.image;
//    NSUInteger index = [self.images indexOfObject:currentImage];
//    index = (index + 1) % [self.images count];
//    self.imageView1.image = self.images[index];
}

#pragma mark - renderInContext 创建自定义过渡效果
- (void)performTransition {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}

#pragma mark - 船只动画  开始和停止一个动画
- (void)oc_addStartStopAnimation {
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"11-1"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(20, 20, 30, 20);
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor greenColor];
    btn2.frame = CGRectMake(20, 80, 30, 20);
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
}

- (void)start {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    
}
- (void)stop {
    [self.shipLayer removeAnimationForKey:@"rotateAnimation"];
}
//- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
//    NSLog(@"the animation stopped (finished:%@)", flag ? @"yes" : @"NO");
//}

#pragma mark - CAMediaTiming协议
- (void)oc_addCAMediaTiming {
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
    self.shipLayer.position = CGPointMake(150, 300);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"11-1"].CGImage;
    [self.view.layer addSublayer:self.shipLayer];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"duration";
    label1.frame = CGRectMake(10, 50, 100, 20);
    [self.view addSubview:label1];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"repeatCount";
    label2.frame = CGRectMake(200, 50, 100, 20);
    [self.view addSubview:label2];
    self.durationField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 100, 20)];
    self.durationField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.durationField];
    self.repeatField = [[UITextField alloc] initWithFrame:CGRectMake(200, 80, 100, 20)];
    self.repeatField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.repeatField];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton.backgroundColor = [UIColor greenColor];
    self.startButton.frame = CGRectMake(20, 150, 30, 20);
    [self.view addSubview:self.startButton];
    [self.startButton addTarget:self action:@selector(start1) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setControlsEnabled:(BOOL)enabled {
    for (UIControl *control in @[self.durationField, self.repeatField, self.startButton]) {
        control.enabled = enabled;
        control.alpha = enabled?1.0f:.025f;
    }
}
- (void)hideKeyboard {
    [self.durationField resignFirstResponder];
    [self.repeatField resignFirstResponder];
}
- (void)start1 {
    [self hideKeyboard];
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeatCount = [self.repeatField.text floatValue];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transtorm.rotation";
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 3);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    [self setControlsEnabled:NO];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [self setControlsEnabled:YES];
}

#pragma mark - 手动动画
- (void)oc_addDoorLayer {
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, 128, 256);
    self.doorLayer.position = CGPointMake(150 - 64, 150);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"111"].CGImage;
    [self.containerView.layer addSublayer:self.doorLayer];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    self.doorLayer.speed = 0.0;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 100.0;
    [self.doorLayer addAnimation:animation forKey:nil];
}
- (void)pan:(UIPanGestureRecognizer *)pan {
    CGFloat x = [pan translationInView:self.view].x;
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(99.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    [pan setTranslation:CGPointZero inView:self.view];
}


#pragma mark - 绘制3D图层矩阵
- (void)oc_add3Djuzhen {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    self.scrollView.contentSize = CGSizeMake((sWIDTH - 1) * SPACING, (sHEIGHT - 1) * SPACING);
    [self.view addSubview:self.scrollView];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    self.scrollView.layer.sublayerTransform = transform;
    
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < sHEIGHT; y ++) {
            for (int x = 0; x < sWIDTH; x++) {
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x * SPACING, y *SPACING);
                layer.zPosition = -z * SPACING;
                layer.backgroundColor = [UIColor colorWithWhite:1 - z * (1.0 / DEPTH) alpha:1].CGColor;
                [self.scrollView.layer addSublayer:layer];
                
            }
        }
    }
    NSLog(@"displayed : %i", DEPTH * sHEIGHT *sWIDTH);
}



#pragma  mark - 视图加载完毕
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];
    //    [self oc_addSubviews];
    
    //    [self oc_addcontentsRect];
    
    //    [self oc_addcontentsCenter];
    
    //    [self oc_addCALayerDelegate];
    
    //    [self oc_addzPosition];
    
    //    [self oc_addContainsPoint];
    
    //    [self oc_solveShowView];
    
    //    [self oc_addShadowPath];
    
    //    [self oc_addMask];
    
    //    [self oc_addlashen];
    
    //    [self oc_addShouldRasterize];
    
    //    [self oc_addAffineTransform];
    
    //    [self oc_addCATransform3D];
    
    //    [self oc_addSublayerTransform];
    
    //    [self oc_addDoubleSided];
    
    //    [self oc_reverseRotation];
    
    //    [self oc_addzhengfangti];
    
    //    [self oc_addCAShapeLayer];
    
    //    [self oc_addCATextLayer];
    
    //    [self oc_addCATransformlayer];
    
    //    [self oc_addCAGradientLayer];         //对角颜色渐变
    
    //    [self oc_addCAReplicatorLayer];       //重复图层
    
    //    [self oc_addReflectionView];            // 反转效果
    
    //    [self oc_addCAEmitterLayer];            //粒子效果
    
    //    [self oc_addCAEAGLLayer];     //GLKit
    
    //    [self oc_addAVPlayer];              // 播放器
    
    //    [self oc_addChangeColorLayer];         //隐式动画改变颜色
    
//    [self oc_addcustomAnimation];           //自定义图层动画
    
//    [self oc_addlayerLocation];               //判断图层位置
    
//    [self oc_addxianshiAnimation];          // 显式动画
    
//    [self oc_addBezierPathAnimation];       //沿着贝塞尔曲线给图层做动画
    
//    [self oc_addTransformAnimation];         //用transform属性对图层做动画
    
//    [self oc_addCAAnimationGroup];          //组合动画
    
//    [self oc_addCATransitionUIImageView];           //imageview动画
    
//    [self performTransition];                           //自定义过渡动画
    
//    [self oc_addStartStopAnimation];                    //动画的开始和停止
    
//    [self oc_addCAMediaTiming];                     //CAMediaTiming协议
    
//    [self oc_addDoorLayer];                         //手动动画
    
    [self oc_add3Djuzhen];                      //绘制3D滚动式图
}

@end
