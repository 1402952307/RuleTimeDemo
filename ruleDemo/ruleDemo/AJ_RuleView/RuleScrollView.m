//
//  RuleScrollView.m
//  ruleDemo
//
//  Created by mac02 on 2020/9/23.
//  Copyright © 2020 HaiLai. All rights reserved.
//

#import "RuleScrollView.h"
#import "RuleView.h"
#import "NSString+NCDate.h"
#import "NSDate+Extension.h"
#import "UIView+Frame.h"
#import "AJRuleView.h"
#import "AJCameraZoomSlider.h"


@interface RuleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) RuleView *ruleView;
@property (nonatomic, strong) AJRuleView *ruleView;
@property (nonatomic, strong) AJCameraZoomSlider *slider;
@property (nonatomic, strong) UIPinchGestureRecognizer *gesture;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic,assign) CGFloat timeCount;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic,assign) CGFloat previousHeight;
@property (nonatomic,assign) CGFloat ruleHeight;

@property (nonatomic,assign) CGFloat startScale; // 记录缩放值

@end

@implementation RuleScrollView

#define width_screen [UIScreen mainScreen].bounds.size.width
#define height_screen [UIScreen mainScreen].bounds.size.height

-(instancetype)initWithCounts:(int)count model:(AJ_ScrollMode *)scrollModel {

    if (self = [super init]) {
        self.timeCount = count;
        self.scrollModel = scrollModel;
        [self initilization];
    }
    return self;
}

#pragma mark - event
-(void)pinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    
//    UIView *view = self.ruleView;
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"pinch scale %f",pinchGestureRecognizer.scale);
//        CGFloat rulew = self.ruleView.frame.size.height;
//
//        CGFloat height = rulew * (CGFloat)pinchGestureRecognizer.scale;
//        NSLog(@"rule height %f---------scale = %lf",height,pinchGestureRecognizer.scale);
//        CGFloat timeCount = [self.timeArray[0] integerValue] * 3600 + [self.timeArray[1] floatValue] * 60;
//        CGFloat scaleSize = height / timeCount;
//
//        if (height / self.timeCount >= 60 && height <= timeCount) {
//
//            NSLog(@"scaleSize------%lf",scaleSize);
//            self.slider.currentPercent = scaleSize;
//
//            self.ruleView.frame = CGRectMake(0, 50, self.frame.size.width, height);
//            self.scrollView.contentSize = CGSizeMake(0, height + self.frame.size.height);
//            // 缩放保持居中
//            CGFloat offsetY = self.scrollView.contentOffset.y * pinchGestureRecognizer.scale;
//            self.scrollView.contentOffset = CGPointMake(0, offsetY);
//
//        }
//
//    }
    
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.startScale = pinchGestureRecognizer.scale;
        
    } else if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = pinchGestureRecognizer.scale / self.startScale;
        CGFloat rulew = self.ruleView.frame.size.height;
        CGFloat height = rulew * currentScale;
        CGFloat timeCount = [self.timeArray[0] integerValue] * 3600 + [self.timeArray[1] floatValue] * 60;
        CGFloat scaleSize = height / timeCount;

        if (height / self.timeCount >= 60 && height <= timeCount) {

            self.slider.value = scaleSize;
            self.ruleView.frame = CGRectMake(0, 50, self.frame.size.width, height);
            self.scrollView.contentSize = CGSizeMake(0, height + self.frame.size.height);
            // 缩放保持居中
            CGFloat offsetY = self.scrollView.contentOffset.y * currentScale;
            self.scrollView.contentOffset = CGPointMake(0, offsetY);

        }
        self.startScale = pinchGestureRecognizer.scale;
    }
    
}

#pragma mark - method
-(void)initilization{
    
    self.previousHeight = 0.0;
    self.backgroundColor = [UIColor lightGrayColor];
    self.timeArray = [NSArray array];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = CGRectMake(0, 0, width_screen - 60, height_screen - 350);
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    
    
    NSString *dateStr = [NSString getTimeFromTimesTamp:[NSString stringWithFormat:@"%@000",self.scrollModel.endArray[0]]];
    NSArray *tmpArr = [dateStr componentsSeparatedByString:@":"];
    self.timeArray = tmpArr;
    CGFloat timeCount = [tmpArr[0] integerValue] + [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / 3600;
    self.timeCount = timeCount;

    // 最后时间的比例
    CGFloat offset_Y = [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / 3600;


    CGFloat scrollHeight = height_screen - 350;
    CGFloat hourHeight = self.scrollView.frame.size.height * 2 / [tmpArr[0] intValue];
    CGFloat offsetHeight_0 = hourHeight * offset_Y;
    CGFloat ruleHeight = 60.0 * timeCount;
    self.ruleHeight = ruleHeight;
    CGFloat offsetHeight = ruleHeight + scrollHeight;
    
    
//    int minuteCount = [tmpArr[0] intValue] * 60  + [tmpArr[1] intValue];
    
    
//    RuleView *ruleView = [[RuleView alloc]initWithCount:[tmpArr[0] intValue] model:self.scrollModel];
    
//    RuleView *ruleView = [[RuleView alloc]init];
//    self.ruleView = ruleView;
//    self.ruleView.minuteCount = minuteCount;
//    self.ruleView.timeCount = timeCount;
//    ruleView.frame = CGRectMake(0, 50, width_screen - 60, ruleHeight);
//    ruleView.scrollModel = self.scrollModel;
//
//    self.scrollView.contentSize = CGSizeMake(0, offsetHeight);
//    [self.scrollView addSubview:ruleView];
//    ruleView.imageViewAction = ^(NSInteger index, NSString *currentHeight) {
//        self.scrollView.contentOffset = CGPointMake(0, currentHeight.floatValue);
//    };

//    int minuteCount = [tmpArr[0] intValue] * 60  + [tmpArr[1] intValue];
//
//    RuleView *ruleView = [[RuleView alloc]init];
//    self.ruleView = ruleView;
//    self.ruleView.minuteCount = minuteCount;
//    self.ruleView.timeCount = timeCount;
//    ruleView.frame = CGRectMake(0, 50, width_screen - 60, ruleHeight);
//    ruleView.scrollModel = self.scrollModel;
//    ruleView.backgroundColor = [UIColor clearColor];
//    self.scrollView.contentSize = CGSizeMake(0, offsetHeight);
//    [self.scrollView addSubview:ruleView];


//    ruleView.imageViewAction = ^(NSInteger index, NSString *currentHeight) {
////        self.scrollView.contentOffset = CGPointMake(0, currentHeight.floatValue);
//
//        int time_0 = [NSString getPastTimestamps:[weakSelf.scrollModel.endArray.lastObject intValue]];
//        int currentTime = [weakSelf.scrollModel.endArray[index] intValue] - [weakSelf.scrollModel.timeLongArray[index] intValue] - time_0;
//        if (weakSelf.scrollViewStopBlock) {
//            if (currentTime <= 0) {
//                currentTime = 1;
//            }
//            weakSelf.scrollViewStopBlock(currentTime);
//        }
//    };
    
    
    int minuteCount = [tmpArr[0] intValue] * 60  + [tmpArr[1] intValue];
    
    AJRuleView *ruleView = [[AJRuleView alloc]init];
    self.ruleView = ruleView;
    self.ruleView.minuteCount = minuteCount;
    self.ruleView.timeCount = timeCount;
    ruleView.frame = CGRectMake(0, 50, width_screen - 60, ruleHeight);
    ruleView.scrollModel = self.scrollModel;
    ruleView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(0, offsetHeight);
    [self.scrollView addSubview:ruleView];


//    ruleView.imageViewAction = ^(NSInteger index, NSString *currentHeight) {
////        self.scrollView.contentOffset = CGPointMake(0, currentHeight.floatValue);
//
//        int time_0 = [NSString getPastTimestamps:[weakSelf.scrollModel.endArray.lastObject intValue]];
//        int currentTime = [weakSelf.scrollModel.endArray[index] intValue] - [weakSelf.scrollModel.timeLongArray[index] intValue] - time_0;
//        if (weakSelf.scrollViewStopBlock) {
//            if (currentTime <= 0) {
//                currentTime = 1;
//            }
//            weakSelf.scrollViewStopBlock(currentTime);
//        }
//    };
    
    
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.scrollView addGestureRecognizer:gesture];
    self.gesture = gesture;
    self.scrollView.delegate = self;

    // 线条
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor orangeColor];
    lineView.frame = CGRectMake(20, 50, 260, 2);
    [self addSubview:lineView];

    // 当前时间
    UIButton *timeBtn = [[UIButton alloc] init];
    timeBtn.frame = CGRectMake(80, CGRectGetMinY(lineView.frame) - 15, 70, 30);
    timeBtn.backgroundColor = [UIColor orangeColor];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    timeBtn.layer.cornerRadius = 15.0;
    timeBtn.layer.masksToBounds = YES;
    self.timeBtn = timeBtn;
    [self addSubview:timeBtn];
    
    // 滑块
    AJCameraZoomSlider *slider = [[AJCameraZoomSlider alloc] init];
    slider.minimumValue = 0;
    slider.maximumValue = 1.0;
    slider.value = 0;
    slider.thumbTintColor = [UIColor clearColor];
    slider.minimumTrackTintColor = [UIColor orangeColor];
    slider.maximumTrackTintColor = [UIColor orangeColor];
    self.slider = slider;
    [self addSubview:slider];
    /// 逆时针旋转90度
    slider.transform = CGAffineTransformMakeRotation(M_PI_2);
    [slider addTarget:self action:@selector(sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(sliderValueDidEnd:) forControlEvents:UIControlEventTouchUpInside];
    slider.frame = CGRectMake(width_screen - 50, 50, 40, 240);

    
}


- (void) sliderValueDidChanged:(AJCameraZoomSlider *)slider {
//    NSLog(@"滑动当前值：%lf",slider.value);
    if (slider.value <= 0) {
        [self sliderScale:0.01];
    } else {
        [self sliderScale:slider.value];
    }
    

}

- (void) sliderValueDidEnd:(AJCameraZoomSlider *)slider {
//    if (slider.value == 0) {
//        slider.value = 0.01;
//    }
//    [self sliderScale:slider.value];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_y = scrollView.contentOffset.y;
//    NSLog(@"contentOffset y = %lf",offset_y);
    
//    self.lineView.frame = CGRectMake(20, scrollView.contentOffset.y + 50, 260, 2);
//    self.timeBtn.frame = CGRectMake(80, scrollView.contentOffset.y + 35, 70, 30);
    
    // 获取最大的时间
    NSString *endTimeStr = self.scrollModel.endArray[0];
    int endTime = [self getPastTimestamps:endTimeStr.intValue];
    int todayMax = endTimeStr.intValue - endTime;

    // 当前偏移时间 = 当前偏移值 * 最大时间秒数 / 最大偏移值
    CGFloat currentTime = offset_y * todayMax / self.ruleView.frame.size.height;
    NSString *hourStr = [NSString stringWithFormat:@"%.2lf",(todayMax - currentTime) / 3600];
    NSLog(@"currentTime = %lf------hourStr = %.2lf",currentTime,hourStr.floatValue);
    int a = todayMax - currentTime;
    int hour = a / 3600;
    int min = a % 3600 / 60;
    int sec =  a % 60;
    NSLog(@"当前时间 = %.2d:%.2d:%.2d---",hour,min,sec);
    NSString *time = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,min,sec];
    
    if (scrollView.contentOffset.y >= self.ruleView.height) {
        [self.timeBtn setTitle:@"00:00:00" forState:UIControlStateNormal];
    } else {
        [self.timeBtn setTitle:time forState:UIControlStateNormal];
    }
    
}

#pragma mark - 获取当请时间0点0分时间戳
- (int)getPastTimestamps:(int)currentTime{
    
    NSString *tmpSelectDate = [NSString stringWithFormat:@"%@-%@-%@",[NSDate GetYearStringWithSeconds:currentTime],[NSDate GetMonthStringWithSeconds:currentTime],[NSDate GetDayStringWithSeconds:currentTime]];
    
    //当前时间戳 - 当天0点时间戳 = 时间戳的差（当天过了几秒了）
    NSString *currentDay = [[NSString timeIntervalFromTimeStr:[NSString stringWithFormat:@"%@ 00:00:0",tmpSelectDate]] substringWithRange:NSMakeRange(0, 10)];
    // 获取当前时间第几秒
//    int scrollTime = currentTime - currentDay.intValue;
    return currentDay.intValue;
}



- (void) sliderScale:(CGFloat)scale {
    

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 这里放异步执行任务代码

        CGFloat timeCount = [self.timeArray[0] integerValue] * 3600 + [self.timeArray[1] floatValue] * 60;
        CGFloat height = timeCount * scale;
        CGFloat aa = 0.0;
//        if (self.previousHeight <= 0.0 ) {
////            height = self.rule
//            self.previousHeight = height;
////            return ;
//        }

        aa = height / self.previousHeight;
        self.previousHeight = height;
        
        if (height / self.timeCount >= 60 && height <= timeCount) {

            NSLog(@"滑动当前值：%lf",scale);

            
            dispatch_sync(dispatch_get_main_queue(), ^{

                
                self.ruleView.frame = CGRectMake(0, 50, self.frame.size.width, height);
                self.scrollView.contentSize = CGSizeMake(0, height + self.frame.size.height);

                // 缩放保持居中(有瑕疵)
                CGFloat offsetY = self.scrollView.contentOffset.y * aa;


                if (offsetY > 0 && offsetY < height) {
                    NSLog(@"height %f---------offsetY = %lf",height,offsetY);
                    self.scrollView.contentOffset = CGPointMake(0, offsetY);
                }

            });

        }
    });
        
}

@end



