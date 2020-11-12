//
//  AJCameraZoomSlider.m
//  ruleDemo
//
//  Created by mac02 on 2020/9/30.
//  Copyright © 2020 HaiLai. All rights reserved.
//

#import "AJCameraZoomSlider.h"

@interface AJCameraZoomSlider()

@property (nonatomic, strong) UIView *thumbView;
@property (nonatomic, assign) CGFloat thumbX;

@end

@implementation AJCameraZoomSlider

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self _setup];
        
 
        // 创建自控制器
//        [self _setupSubViews];
        
        // 布局子控件
//        [self _makeSubViewsConstraints];
    }
    return self;
}

#pragma mark - 事件处理Or辅助方法

#pragma mark - Private Method
- (void)_setup{
    self.minimumValue = 0;
    self.maximumValue = 1;
}

#pragma mark - 创建自控制器
- (void)_setupSubViews
{
//    self.minimumTrackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:.4];
//    self.maximumTrackTintColor = self.minimumTrackTintColor;
    
    
//    UIImage *norImage = [UIImage imageNamed:@"Snip20200930_2"];
//    UIImage *highImage = [UIImage imageNamed:@"Snip20200930_3"];
//
//    /// 图片合成
//    UIGraphicsBeginImageContextWithOptions(highImage.size , NO, highImage.scale);
//    [highImage drawInRect:CGRectMake(0, 0, highImage.size.width, highImage.size.height)];
//    CGFloat w = norImage.size.width;
//    CGFloat h = norImage.size.height;
//    CGFloat x = (highImage.size.width - w) * .5f;
//    CGFloat y = (highImage.size.height - h) * .5f;
//    [highImage drawInRect:CGRectMake(x, y, 20, 35) blendMode:UIViewContentModeScaleAspectFill alpha:1.0];
//    highImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    UIImageView *thumbView = [[UIImageView alloc] init];
//    thumbView.image = [thumbView.image imageWithTintColor:[UIColor redColor]];
//
//    [self setThumbImage:thumbView.image forState:UIControlStateNormal];
//    [self setThumbImage:highImage forState:UIControlStateHighlighted];
    
//    UIView *thumbView = [[UIView alloc] init];
//    thumbView.backgroundColor = [UIColor redColor];
//    thumbView.frame = CGRectMake(self.thumbX, 8, 25, 25);
//    self.thumbView = thumbView;
//    [self addSubview:thumbView];
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}



#pragma mark - Override
/// 设置minimumValueImage的rect
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds{
    CGFloat X = 0;
    CGFloat H = 21;
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat W = H;
    return CGRectMake(X, Y, W, H);
    
}
/// 设置maximumValueImage的rect
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds{
    CGFloat H = 21;
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat W = H;
    CGFloat X = bounds.size.width - W;
    return CGRectMake(X, Y, W, H);
}

/// 设置track（滑条）尺寸
- (CGRect)trackRectForBounds:(CGRect)bounds{
    CGRect minimumValueImageRect = [self minimumValueImageRectForBounds:bounds];
    CGRect maximumValueImageRect = [self maximumValueImageRectForBounds:bounds];
    CGFloat margin = 2;
    CGFloat H = 6;
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat X = CGRectGetMaxX(minimumValueImageRect) + margin;
    CGFloat W = CGRectGetMinX(maximumValueImageRect) - X - margin;
    return CGRectMake(X, Y, W, H);
}

/// 设置thumb（滑块）尺寸
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    
    CGFloat W = 40;
    CGFloat margin = W *.5f - 21 *.5f + 2;
    /// 滑块的滑动区域宽度
    CGFloat maxWidth = CGRectGetWidth(rect) + 2 * margin;
    /// 每次偏移量
    CGFloat offset = (maxWidth - W)/(self.maximumValue - self.minimumValue);
    
    CGFloat H = 25;
    CGFloat Y = (bounds.size.height - H ) *.5f;
    CGFloat X = CGRectGetMinX(rect) - margin + offset *(value-self.minimumValue);
    CGRect r =  CGRectMake(X, Y, W, H);
//    self.thumbX = X > 0?X:0;
//    self.thumbView.frame = CGRectMake(X, 8, 25, 25);
    
//    NSLog(@"滑动当前X值：%lf",X);
    return r;
}


#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.didSetLayer) {
        return;
    }
    BOOL didSetLayer = NO;
    for (UIView *v in self.subviews) {
        if (v.frame.size.width <= 6 &&  v.frame.size.width > 0) {
//            v.layer.borderWidth = 4.0f;
//            v.layer.borderColor = [UIColor lightGrayColor].CGColor;
            v.layer.cornerRadius = 4.0;
            v.layer.masksToBounds = YES;
            v.backgroundColor = [UIColor lightGrayColor];
            didSetLayer = YES;
        }
        
        if (v.frame.size.height > 10) {
            UIImageView *image = (UIImageView *)v;
            image.backgroundColor = [UIColor greenColor];
            image.layer.masksToBounds = YES;
            image.layer.cornerRadius = 6.0;
//            image.image = [UIImage imageNamed:@"adddevice_btn_wave_nor"];
            
//            [image setThumbImage:[UIImage imageNamed:@"adddevice_btn_wave_nor"] forState:UIControlStateNormal];
//            v.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Snip20200930_2"]];
        }
        
    }
    self.didSetLayer = didSetLayer;
}

@end
