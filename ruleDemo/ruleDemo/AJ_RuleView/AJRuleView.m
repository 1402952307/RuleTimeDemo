//
//  RuleView.m
//  ruleDemo
//
//  Created by mac02 on 2020/9/23.
//  Copyright © 2020 HaiLai. All rights reserved.
//

#import "AJRuleView.h"
#import "UIView+Layout.h"
#import "NSString+NCDate.h"
#import "UIView+Frame.h"


@interface AJRuleView ()

@property (nonatomic,assign) int count;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *bgViewArray;

// 时间数组
@property (nonatomic, strong) NSMutableArray *hourLabArray;
@property (nonatomic, strong) NSMutableArray *hourLineArray;
@property (nonatomic, strong) NSMutableArray *minuteArray_10;
@property (nonatomic, strong) NSMutableArray *minuteArray_5;
@property (nonatomic, strong) NSMutableArray *minuteArray_1;

// 刻度数组
@property (nonatomic, strong) NSMutableArray *minuteArray_30;
@property (nonatomic, strong) NSMutableArray *minuteLineArray_30;
@property (nonatomic, strong) NSMutableArray *minuteLineArray_10;
@property (nonatomic, strong) NSMutableArray *minuteLineArray_5;
@property (nonatomic, strong) NSMutableArray *minuteLineArray_1;

// 线条上的视频数组
@property (nonatomic, strong) NSMutableArray *lineVideoViewArray;



@property (nonatomic, strong) UIView *lineLayer; // 线条

@property (nonatomic,assign) int hourCount;

@end

@implementation AJRuleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
  
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame model:(AJ_ScrollMode *)scrollModel {
//
//    if (self = [super init]) {
//
//        self.scrollModel = scrollModel;
//
//        [self loadTimeRuleView];
//
//    }
//    return self;
//}

- (void) loadTimeRuleView {

    [self myLayoutSubviews11];

}

#pragma mark - 瞎鸡吧整
-(void)layoutSubviews {
    [super layoutSubviews];

    [self updateFrame];
}

- (void) updateFrame {

    
    self.lineLayer.frame = CGRectMake(50, -50, 10, self.frame.size.height * 2);
    
    CGFloat hourHeight = self.frame.size.height / self.timeCount;
    NSString *dateStr = [NSString getTimeFromTimesTamp:[NSString stringWithFormat:@"%@000",self.scrollModel.endArray[0]]];
    NSArray *tmpArr = [dateStr componentsSeparatedByString:@":"];

    CGFloat offsetHeight = 0.0;
    if (tmpArr.count == 3) {
        CGFloat offset_Y = [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / 3600;
        offsetHeight = hourHeight * offset_Y;
    }
    
    int jishuCount = 0;
    NSInteger jishuCount1 = self.minuteArray_1.count;
    BOOL bl = self.minuteCount % 60 >= 30;
    for (int i = self.minuteCount; i >= 0; i--) {
    
        int currentTime = self.hourCount - (i / 60);
        // 小时
        if (i % 60 == 0) {
            
            int tag = i / 60;
            UILabel *hourLab = self.hourLabArray[tag];
           
            CGPointMake(20,currentTime * hourHeight + offsetHeight);
            hourLab.center = CGPointMake(20, (i / 60) * hourHeight + offsetHeight);
            
            UIView *lineView = self.hourLineArray[tag];
//            lineView.center = CGPointMake(60, (i / 60) * hourHeight + offsetHeight);
            lineView.frame = CGRectMake(60, (i / 60) * hourHeight + offsetHeight, 12, 1);
            jishuCount++;
        }
        
        // 半小时
        else if (i % 30 == 0 && i % 60 != 0) {

            int tag = i / 60;
            UILabel *hourLab = self.minuteArray_30[tag];
            UIView *lineView = self.minuteLineArray_30[tag];
//            hourLab.center = CGPointMake(20,((i / 60 - 1) * hourHeight) + (hourHeight * 0.5) + offsetHeight);
//            lineView.frame = CGRectMake(60, ((i / 60 - 1) * hourHeight) + (hourHeight * 0.5) + offsetHeight, 8, 1);

            if (bl) {
                hourLab.center = CGPointMake(20,(((i / 60.0) - 1) * hourHeight) + offsetHeight);
                lineView.frame = CGRectMake(60, (((i / 60.0) - 1) * hourHeight) + offsetHeight, 8, 1);
                
            } else {
                hourLab.center = CGPointMake(20,((i / 60.0) * hourHeight) + offsetHeight);
                lineView.frame = CGRectMake(60, ((i / 60.0) * hourHeight) + offsetHeight, 8, 1);
                
            }

            NSLog(@"timel = %@----------%lf",hourLab.text,((i / 60 - 1) * hourHeight) + (hourHeight * 0.5) + offsetHeight);
            if (hourHeight >= 100) {
                lineView.hidden = NO;
            } else {
                lineView.hidden = YES;
            }

            if (hourHeight >= 160) {
                hourLab.hidden = NO;
            } else {
                hourLab.hidden = YES;
            }
            jishuCount++;
        
        }
        
        // 十分钟
        else if (i % 10 == 0 && i % 30 != 0 && i % 60 != 0) {

            int tag = i / 15;
            int ca = ((i % 60) / 10);
            UILabel *timeLab = self.minuteArray_10[self.minuteArray_10.count - tag - 1];
            UIView *lineView = self.minuteLineArray_10[tag];
            
            CGPoint point = CGPointMake(20, (currentTime * hourHeight) - (ca / 6.0 * hourHeight) + offsetHeight);
            timeLab.center = point;
            lineView.frame = CGRectMake(60, (currentTime * hourHeight) - (ca / 6.0 * hourHeight) + offsetHeight, 8, 1);
//            NSLog(@"time = %@-------%f",timeLab.text,((self.hourCount - (i / 60)) * hourHeight) - (ca / 6.0 * hourHeight) - offsetHeight);

            if (hourHeight >= 100) {
                lineView.hidden = NO;
            } else {
                lineView.hidden = YES;
            }

            if (hourHeight >= 300) {
                timeLab.hidden = NO;
            } else {
                timeLab.hidden = YES;
            }
            jishuCount++;

        }
        
        // 五分钟
        else if (i % 5 == 0 && i % 10 != 0 && i % 30 != 0 && i % 60 != 0) {
            
            int tag = i / 10;
            int ca = ((i % 60) / 5);
            UILabel *timeLab = self.minuteArray_5[self.minuteArray_5.count - tag - 1];
            UIView *lineView = self.minuteLineArray_5[tag];
            CGPoint point = CGPointMake(20, (currentTime * hourHeight) - (ca / 12.0 * hourHeight) + offsetHeight);
            timeLab.center = point;
//            NSLog(@"%@====time-----%lf",timeLab.text,point.y);
            
            lineView.frame = CGRectMake(60, (currentTime * hourHeight) - (ca / 12.0 * hourHeight) + offsetHeight, 8, 1);
            
            if (hourHeight / 6 > 100) {
                timeLab.hidden = NO;
                lineView.hidden = NO;
            } else {
                timeLab.hidden = YES;
                lineView.hidden = YES;
            }
            jishuCount++;
            
        }
        
        else {
            
            int ca = i % 60;
            int tag = i / 60;
            UILabel *timeLab = self.minuteArray_1[self.minuteArray_1.count - (jishuCount1)];
            UIView *lineView = self.minuteLineArray_1[self.minuteArray_1.count - (jishuCount1)];
            CGPoint point = CGPointMake(20, (currentTime * hourHeight) - (ca / 60.0 * hourHeight) + offsetHeight);
            timeLab.center = point;
//            NSLog(@"%@====time-----%lf",timeLab.text,(currentTime * hourHeight) - (ca / 60.0 * hourHeight) + offsetHeight);
            lineView.frame = CGRectMake(60, (currentTime * hourHeight) - (ca / 60.0 * hourHeight) + offsetHeight, 5, 1);
            
            if (hourHeight / 12 > 100) {
                lineView.hidden = NO;
            } else {
                lineView.hidden = YES;
            }
            
            if (hourHeight / 30 > 100) {
                timeLab.hidden = NO;
            } else {
                timeLab.hidden = YES;
            }
            jishuCount1--;
            
            
        }


    }
    
    
    
    // 右边图片
    
    // 统计的总高度
    CGFloat allHeight = 0.0;
    NSMutableArray *imagePositionArray = [NSMutableArray array];
    // 绘制视频条
    for (int j = 0; j < self.scrollModel.endArray.count; j++) {
        // 视频间距
        CGFloat hourHeight = self.frame.size.height / self.timeCount;
        UIView *videoView = self.lineVideoViewArray[j];
        if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
            videoView.backgroundColor = [UIColor redColor];
        } else {
            videoView.backgroundColor = [UIColor greenColor];
        }
        [self addSubview:videoView];
        [self.lineVideoViewArray addObject:videoView];

        NSString *videoSpacing = self.scrollModel.offsetArray[j];
        CGFloat videoSpacingHeight = videoSpacing.floatValue * hourHeight / 3600;

        int time_0 = [self.scrollModel.timeLongArray[j] intValue];
        CGFloat videoHeight = time_0 * hourHeight / 3600;
        videoView.frame = CGRectMake(50, allHeight, 10, videoHeight);
        CGFloat tmpHeight = [imagePositionArray.lastObject floatValue];

        UIView *bgView = self.bgViewArray[j];
        if (allHeight - 80 > tmpHeight || j == 0) {
            
            
            
            bgView.frame = CGRectMake(80, allHeight - 5, 200, 70);
            bgView.hidden = NO;
            
            

            NSString *tmpHeight1 = [NSString stringWithFormat:@"%lf",allHeight];
            [imagePositionArray addObject:tmpHeight1];


        } else {
            
            bgView.hidden = YES;
            
        }

        allHeight += videoSpacingHeight;
        NSString *currentHeight = [NSString stringWithFormat:@"%lf",allHeight];
        [self.heightArray addObject:currentHeight];
    }
    
    
    
    
}


-(void)myLayoutSubviews11 {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self.heightArray removeAllObjects];
    [self.timeArray removeAllObjects];
    [self.typeArray removeAllObjects];
    [self.bgViewArray removeAllObjects];

    // 线条
    UIView *lineLayer = [[UIView alloc] init];
    lineLayer.backgroundColor = [UIColor lightGrayColor];
    lineLayer.frame = CGRectMake(50, -50, 10, self.frame.size.height * 2);
    self.lineLayer = lineLayer;
    [self addSubview:lineLayer];

    CGFloat hourHeight = self.frame.size.height / self.timeCount;
    NSString *dateStr = [NSString getTimeFromTimesTamp:[NSString stringWithFormat:@"%@000",self.scrollModel.endArray[0]]];
    NSArray *tmpArr = [dateStr componentsSeparatedByString:@":"];

    CGFloat offsetHeight = 0.0;
    if (tmpArr.count == 3) {
        CGFloat offset_Y = [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / 3600;
        offsetHeight = hourHeight * offset_Y;
    }

    NSLog(@"Start hourHeight = %lf",hourHeight);
    
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    _count = (int)self.timeCount;
    
    
    for (int i = self.minuteCount; i >= 0; i--) {
        
        // 小时
        int hourCount = self.minuteCount / 60;
        self.hourCount = hourCount;
        int currentTime = hourCount - (i / 60);
        if (i % 60 == 0) {
        
//            NSLog(@"+++++++++++++ %lf",currentTime * hourHeight + offsetHeight);
            CGPoint hourLabCenter = CGPointMake(20,currentTime * hourHeight + offsetHeight);
            NSString *time = [NSString stringWithFormat:@"%.2d:00",(i / 60)];
            UILabel *hourLab = [self timeText:hourLabCenter withTitle:time];
            hourLab.tag = i;
            [self.hourLabArray addObject:hourLab];
            
            CGPoint point = CGPointMake(60, currentTime * hourHeight + offsetHeight);
            UIView *lineView = [self withPoint:point withWidth:12];
            [self.hourLineArray addObject:lineView];
        }
        
        else if (i % 30 == 0 && i % 60 != 0) {

            CGPoint point = CGPointMake(60, (currentTime * hourHeight) - (hourHeight * 0.5) + offsetHeight);
            NSString *time = [NSString stringWithFormat:@"%.2d:30",(i / 60)];
            UILabel *banHourLab = [self timeText:point withTitle:time];
            banHourLab.tag = i;
            banHourLab.hidden = YES;
            [self.minuteArray_30 addObject:banHourLab];
            
            UIView *lineView = [self withPoint:point withWidth:8];
            lineView.hidden = YES;
            [self.minuteLineArray_30 addObject:lineView];

        }
        
        // 十分钟
        else if (i % 10 == 0 && i % 30 != 0 && i % 60 != 0) {
            
            int ca = ((i % 60) / 10);
            CGPoint point = CGPointMake(60, (currentTime * hourHeight) - (ca / 6.0 * hourHeight) + offsetHeight);
            NSString *time = [NSString stringWithFormat:@"%.2d:%d",i / 60, i % 60];
//            NSLog(@"%@====time-----%d",time,(i % 60) / 10);
            UILabel *lab = [self timeText:point withTitle:time];
            lab.tag = i;
            [self.minuteArray_10 addObject:lab];
 
            UIView *lineView = [self withPoint:point withWidth:8];
            [self.minuteLineArray_10 addObject:lineView];
            
        }
        
        // 五分钟
        else if (i % 5 == 0 && i % 10 != 0 && i % 30 != 0 && i % 60 != 0) {
            
            int ca = ((i % 60) / 5);
            CGPoint point = CGPointMake(60, (currentTime * hourHeight) - (ca / 12.0 * hourHeight) + offsetHeight);
            NSString *time = [NSString stringWithFormat:@"%.2d:%.2d",i / 60, ca * 5];
//            NSLog(@"%@====time-----%lf",time,(currentTime * hourHeight) - (ca / 12.0 * hourHeight) + offsetHeight);
            UILabel *timeLab = [self timeText:point withTitle:time];
            timeLab.tag = i;
            [self.minuteArray_5 addObject:timeLab];
 
            UIView *lineView = [self withPoint:point withWidth:8];
            [self.minuteLineArray_5 addObject:lineView];
            
        }
        
        // 一分钟
        else {
            

            int ca = i % 60;
            CGPoint point = CGPointMake(60, (currentTime * hourHeight) - ca + offsetHeight);
            NSString *time = [NSString stringWithFormat:@"%.2d:%.2d",i / 60, ca];
//            NSLog(@"%@====time-----%lf",time,(currentTime * hourHeight) - (ca / 60.0 * hourHeight) + offsetHeight);
            UILabel *timeLab = [self timeText:point withTitle:time];
            timeLab.tag = i;
            [self.minuteArray_1 addObject:timeLab];
            
            UIView *lineView = [self withPoint:point withWidth:5];
            [self.minuteLineArray_1 addObject:lineView];

        }
            
        

        
    }
    
    
    
    
    // 右边图片
    
    // 统计的总高度
    CGFloat allHeight = 0.0;
    NSMutableArray *imagePositionArray = [NSMutableArray array];
    // 绘制视频条
    for (int j = 0; j < self.scrollModel.endArray.count; j++) {
        // 视频间距
        CGFloat hourHeight = self.frame.size.height / self.timeCount;
        UIView *videoView = [[UIView alloc] init];
        if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
            videoView.backgroundColor = [UIColor redColor];
        } else {
            videoView.backgroundColor = [UIColor greenColor];
        }
        [self addSubview:videoView];
        [self.lineVideoViewArray addObject:videoView];

        NSString *videoSpacing = self.scrollModel.offsetArray[j];
        CGFloat videoSpacingHeight = videoSpacing.floatValue * hourHeight / 3600;

        int time_0 = [self.scrollModel.timeLongArray[j] intValue];
        CGFloat videoHeight = time_0 * hourHeight / 3600;
        videoView.frame = CGRectMake(50, allHeight, 10, videoHeight);
        CGFloat tmpHeight = [imagePositionArray.lastObject floatValue];

//        if (allHeight - 80 > tmpHeight || j == 0) {

            UIView *bgView = [[UIView alloc] init];
            bgView.frame = CGRectMake(80, allHeight - 5, 200, 70);
            [self addSubview:bgView];


            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(5, 5, 100, 60);
//            imageView.image = [UIImage imageNamed:@"VideoDefault"];
            imageView.userInteractionEnabled = YES;
            imageView.tag = j;
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAntion:)];
            recognizer.numberOfTouchesRequired = 1; //tap次数
            [imageView addGestureRecognizer:recognizer];
            imageView.backgroundColor = [UIColor orangeColor];
            [bgView addSubview:imageView];



            NSString *tmpHeight1 = [NSString stringWithFormat:@"%lf",allHeight];
            [imagePositionArray addObject:tmpHeight1];

            UILabel *timeLab = [UILabel new];
            
            timeLab.backgroundColor = [UIColor grayColor];
            timeLab.textColor = [UIColor whiteColor];
            timeLab.font = [UIFont systemFontOfSize:10.0];
//            timeLab.center = hourLabCenter;
            timeLab.textAlignment = NSTextAlignmentCenter;
            timeLab.layer.masksToBounds = YES;
            timeLab.layer.cornerRadius = 10.0;
            NSString *timeStr = [self makeHourMinuteSecondFromIndex:[self.scrollModel.timeLongArray[j] integerValue]];
            if (timeStr.length > 5) {
                timeLab.frame = CGRectMake(50, 45,55, 20);
            } else {
                timeLab.frame = CGRectMake(65, 45,40, 20);
            }
            timeLab.text = timeStr;
            [bgView addSubview:timeLab];



            UILabel *typeLab = [UILabel new];
            typeLab.textColor = [UIColor grayColor];
            typeLab.font = [UIFont systemFontOfSize:10.0];
            [bgView addSubview:typeLab];
            if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
                typeLab.text = NSLocalizedString(@"Alarm", @"");
            } else {
                typeLab.text = NSLocalizedString(@"Full time", @"");
            }
            typeLab.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 5, 100, 15);



//            if (self.isfullScreen) {
//                bgView.backgroundColor = [UIColor clearColor];
//                typeLab.hidden = YES;
//            } else {
//
//                if (self.offSet_Y > allHeight && self.offSet_Y < allHeight + 70) {
                    bgView.backgroundColor = [UIColor lightGrayColor];
//                    typeLab.hidden = NO;
//                } else {
//                    bgView.backgroundColor = [UIColor clearColor];
//                    typeLab.hidden = YES;
//                }
//
//
//            }

            [self.bgViewArray addObject:bgView];
//            [self.typeArray addObject:typeLab];

//        }

        allHeight += videoSpacingHeight;
        NSString *currentHeight = [NSString stringWithFormat:@"%lf",allHeight];
        [self.heightArray addObject:currentHeight];
    }
    
    
    
    
    
    
    
    
//    for (int i = 0; i < _count; i++) {

//        // 小时
//        NSString *time = [NSString stringWithFormat:@"%.2d:00",_count - i];
//        CGPoint hourLabCenter = CGPointMake(20,i * hourHeight + offsetHeight);
//        if (hourHeight < 100  && (_count - i) % 2 == 1) {
//            UILabel *titleLab = [self timeText:hourLabCenter withTitle:time];
//            titleLab.hidden = YES;
//            CGRect LineRect = CGRectMake(60, i * hourHeight  + offsetHeight, 8, 1);
//            [self scaleLine:LineRect];
//
//        } else {
//            UILabel *titleLab = [self timeText:hourLabCenter withTitle:time];
//            titleLab.hidden = NO;
//            CGRect LineRect = CGRectMake(60, i * hourHeight  + offsetHeight, 12, 1);
//            [self scaleLine:LineRect];
//        }
//
//        // 十分钟刻度
//        if (hourHeight > 100) {
//            for (int j = 1; j <= 5; j++) {
//
//                CGFloat tenHeight = offsetHeight + (i * hourHeight) + (j / 6.0) * hourHeight;
//                CGRect LineRect = CGRectMake(60, tenHeight, 6, 1);
//                [self scaleLine:LineRect];
//
//                if (hourHeight > 300) {
//                    CGPoint tenLabCenter = CGPointMake(20, tenHeight);
//                    NSString *time = [NSString stringWithFormat:@"%.2d:%d0",_count - i - 1, 6 - j];
//                    [self timeText:tenLabCenter withTitle:time];
//                }
//            }
//        }
//
//        // 五分钟
//        if (hourHeight / 6 > 100) {
//            for (int j = 1; j <= 11; j++) {
//                if (j % 2 == 1) {
//
//                    CGFloat min5 = offsetHeight + (i * hourHeight) + (j / 12.0) * hourHeight;
//                    CGPoint tenLabCenter = CGPointMake(20, min5);
//                    NSString *time = [NSString stringWithFormat:@"%.2d:%.2d",_count - i - 1, 60 - j * 5];
//                    [self timeText:tenLabCenter withTitle:time];
//
//                    CGRect LineRect = CGRectMake(60, min5, 6, 1);
//                    [self scaleLine:LineRect];
//
//                }
//            }
//        }
//
//        // 一分钟
//        if (hourHeight / 12 > 100) {
//
//            for (int j = 1; j <= 60; j++) {
//                if (j % 5 != 0) {
//
//                    CGFloat min5 = offsetHeight + (i * hourHeight) + (j / 60.0) * hourHeight;
//                    CGRect LineRect = CGRectMake(60, min5, 6, 1);
//                    [self scaleLine:LineRect];
//
//                    if (hourHeight / 30 > 100) {
//
//                        CGPoint tenLabCenter = CGPointMake(20, min5);
//                        NSString *time = [NSString stringWithFormat:@"%.2d:%.2d",_count - i - 1, 60 - j];
//                        [self timeText:tenLabCenter withTitle:time];
//
//                    }
//                }
//            }
//        }
//
//        // 半小时刻度
//        if (hourHeight > 160) {
//
//            CGRect LineRect = CGRectMake(60, hourHeight * i + hourHeight * 0.5 + offsetHeight, 8, 1);
//            [self scaleLine:LineRect];
//
//            CGPoint banHourLabCenter = CGPointMake(20, hourHeight * i + hourHeight * 0.5 + offsetHeight);
//            NSString *time = [NSString stringWithFormat:@"%.2d:30",_count - 1 - i];
//            [self timeText:banHourLabCenter withTitle:time];
//
//        }
//    }
//    CFAbsoluteTime LineTime = (CFAbsoluteTimeGetCurrent() - startTime);
//    NSLog(@"======time %f ms", LineTime *1000.0);
//
//    CGRect LineRect = CGRectMake(60, _count * self.frame.size.height / self.timeCount + offsetHeight, 12, 1);
//    [self scaleLine:LineRect];
//    CGPoint hourLabCenter = CGPointMake(20,_count * self.frame.size.height / self.timeCount + offsetHeight);
//    NSString *time = [NSString stringWithFormat:@"%.2d:00",_count - _count];
//    [self timeText:hourLabCenter withTitle:time];


    // 统计的总高度
//    CGFloat allHeight = 0.0;
//    NSMutableArray *imagePositionArray = [NSMutableArray array];
//    // 绘制视频条
//    for (int j = 0; j < self.scrollModel.endArray.count; j++) {
//        // 视频间距
//        CGFloat hourHeight = self.frame.size.height / self.timeCount;
//        UIView *videoView = [[UIView alloc] init];
//        if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
//            videoView.backgroundColor = MaiBackColor;
//        } else {
//            videoView.backgroundColor = PlayBackWarningLineColor;
//        }
//        [self addSubview:videoView];
//
//        NSString *videoSpacing = self.scrollModel.offsetArray[j];
//        CGFloat videoSpacingHeight = videoSpacing.floatValue * hourHeight / TimeRulerScaleTypeHour1;
//
//        int time_0 = [self.scrollModel.timeLongArray[j] intValue];
//        CGFloat videoHeight = time_0 * hourHeight / TimeRulerScaleTypeHour1;
//        videoView.frame = CGRectMake(50, allHeight, 10, videoHeight);
//        CGFloat tmpHeight = [imagePositionArray.lastObject floatValue];
//
//        if (allHeight - 80 > tmpHeight || j == 0) {
//
//            UIView *bgView = [[UIView alloc] init];
//            bgView.frame = CGRectMake(80, allHeight - 5, 200, 70);
//            [self addSubview:bgView];
////            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
////                make.top.offset(allHeight - 5);
////                make.leading.offset(80);
////                make.size.sizeOffset(CGSizeMake(width_screen - 80 - 100, 70));
////            }];
//
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.frame = CGRectMake(5, 5, 100, 60);
//            imageView.image = [UIImage imageNamed:@"VideoDefault"];
//            imageView.userInteractionEnabled = YES;
//            imageView.tag = j;
//            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAntion:)];
//            recognizer.numberOfTouchesRequired = 1; //tap次数
//            [imageView addGestureRecognizer:recognizer];
//            [bgView addSubview:imageView];
//
//
//
//            NSString *tmpHeight = [NSString stringWithFormat:@"%lf",allHeight];
//            [imagePositionArray addObject:tmpHeight];
//
//            UILabel *timeLab = [UILabel new];
//            timeLab.frame = CGRectMake(110, 30,50, 20);
//            timeLab.backgroundColor = [UIColor grayColor];
//            timeLab.textColor = [UIColor whiteColor];
//            timeLab.font = [UIFont systemFontOfSize:10.0];
////            timeLab.center = hourLabCenter;
//            timeLab.textAlignment = NSTextAlignmentCenter;
//            timeLab.layer.masksToBounds = YES;
//            timeLab.layer.cornerRadius = 10.0;
//            timeLab.text = [self makeHourMinuteSecondFromIndex:[self.scrollModel.timeLongArray[j] integerValue]];
//            [bgView addSubview:timeLab];
//
//
//
//            UILabel *typeLab = [UILabel new];
//            typeLab.textColor = [UIColor grayColor];
//            typeLab.font = [UIFont systemFontOfSize:10.0];
//            [bgView addSubview:typeLab];
//            if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
//                typeLab.text = NSLocalizedString(@"Alarm", @"");
//            } else {
//                typeLab.text = NSLocalizedString(@"Full time", @"");
//            }
//            typeLab.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 5, 100, 15);
//
//
//
//            if (self.isfullScreen) {
//                bgView.backgroundColor = [UIColor clearColor];
//                typeLab.hidden = YES;
//            } else {
//
////                if (self.offSet_Y > allHeight && self.offSet_Y < allHeight + 70) {
//                    bgView.backgroundColor = ViewBackgroundColor;
//                    typeLab.hidden = NO;
////                } else {
////                    bgView.backgroundColor = [UIColor clearColor];
////                    typeLab.hidden = YES;
////                }
//
//
//            }
//
//            [self.bgViewArray addObject:bgView];
//            [self.typeArray addObject:typeLab];
//
//        }
//
//        allHeight += videoSpacingHeight;
//        NSString *currentHeight = [NSString stringWithFormat:@"%lf",allHeight];
//        [self.heightArray addObject:currentHeight];
//    }
    
    
}



//-(void)myLayoutSubviews11 {
//
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
//
//    [self.heightArray removeAllObjects];
//    [self.timeArray removeAllObjects];
//    [self.typeArray removeAllObjects];
//    [self.bgViewArray removeAllObjects];
//
//    // 线条
//    UIView *LineLayer = [[UIView alloc] init];
//    LineLayer.backgroundColor = ViewBackgroundColor;
//    LineLayer.frame = CGRectMake(50, -50, 10, self.frame.size.height * 2);
//    [self addSubview:LineLayer];
//
//    CGFloat hourHeight = self.frame.size.height / self.timeCount;
//    NSString *dateStr = [NSString getTimeFromTimesTamp:[NSString stringWithFormat:@"%@000",self.scrollModel.endArray[0]]];
//    NSArray *tmpArr = [dateStr componentsSeparatedByString:@":"];
//
//    CGFloat offsetHeight = 0.0;
//    if (tmpArr.count == 3) {
//        CGFloat offset_Y = [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / TimeRulerScaleTypeHour1;
//        offsetHeight = hourHeight * offset_Y;
//    }
//
//    NSLog(@"Start hourHeight = %lf",hourHeight);
//
//    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
//    _count = (int)self.timeCount;
//    for (int i = 0; i < _count; i++) {
//
//        // 小时
//        NSString *time = [NSString stringWithFormat:@"%.2d:00",_count - i];
//        CGPoint hourLabCenter = CGPointMake(20,i * hourHeight + offsetHeight);
//        if (hourHeight < 100  && (_count - i) % 2 == 1) {
//            UILabel *titleLab = [self timeText:hourLabCenter withTitle:time];
//            titleLab.hidden = YES;
//            CGRect LineRect = CGRectMake(60, i * hourHeight  + offsetHeight, 8, 1);
//            [self scaleLine:LineRect];
//
//        } else {
//            UILabel *titleLab = [self timeText:hourLabCenter withTitle:time];
//            titleLab.hidden = NO;
//            CGRect LineRect = CGRectMake(60, i * hourHeight  + offsetHeight, 12, 1);
//            [self scaleLine:LineRect];
//        }
//
//        // 十分钟刻度
//        if (hourHeight > 100) {
//            for (int j = 1; j <= 5; j++) {
//
//                CGFloat tenHeight = offsetHeight + (i * hourHeight) + (j / 6.0) * hourHeight;
//                CGRect LineRect = CGRectMake(60, tenHeight, 6, 1);
//                [self scaleLine:LineRect];
//
//                if (hourHeight > 300) {
//                    CGPoint tenLabCenter = CGPointMake(20, tenHeight);
//                    NSString *time = [NSString stringWithFormat:@"%.2d:%d0",_count - i - 1, 6 - j];
//                    [self timeText:tenLabCenter withTitle:time];
//                }
//            }
//        }
//
//        // 五分钟
//        if (hourHeight / 6 > 100) {
//            for (int j = 1; j <= 11; j++) {
//                if (j % 2 == 1) {
//
//                    CGFloat min5 = offsetHeight + (i * hourHeight) + (j / 12.0) * hourHeight;
//                    CGPoint tenLabCenter = CGPointMake(20, min5);
//                    NSString *time = [NSString stringWithFormat:@"%.2d:%.2d",_count - i - 1, 60 - j * 5];
//                    [self timeText:tenLabCenter withTitle:time];
//
//                    CGRect LineRect = CGRectMake(60, min5, 6, 1);
//                    [self scaleLine:LineRect];
//
//                }
//            }
//        }
//
//        // 一分钟
//        if (hourHeight / 12 > 100) {
//
//            for (int j = 1; j <= 60; j++) {
//                if (j % 5 != 0) {
//
//                    CGFloat min5 = offsetHeight + (i * hourHeight) + (j / 60.0) * hourHeight;
//                    CGRect LineRect = CGRectMake(60, min5, 6, 1);
//                    [self scaleLine:LineRect];
//
//                    if (hourHeight / 30 > 100) {
//
//                        CGPoint tenLabCenter = CGPointMake(20, min5);
//                        NSString *time = [NSString stringWithFormat:@"%.2d:%.2d",_count - i - 1, 60 - j];
//                        [self timeText:tenLabCenter withTitle:time];
//
//                    }
//                }
//            }
//        }
//
//        // 半小时刻度
//        if (hourHeight > 160) {
//
//            CGRect LineRect = CGRectMake(60, hourHeight * i + hourHeight * 0.5 + offsetHeight, 8, 1);
//            [self scaleLine:LineRect];
//
//            CGPoint banHourLabCenter = CGPointMake(20, hourHeight * i + hourHeight * 0.5 + offsetHeight);
//            NSString *time = [NSString stringWithFormat:@"%.2d:30",_count - 1 - i];
//            [self timeText:banHourLabCenter withTitle:time];
//
//        }
//    }
//    CFAbsoluteTime LineTime = (CFAbsoluteTimeGetCurrent() - startTime);
//    NSLog(@"======time %f ms", LineTime *1000.0);
//
//    CGRect LineRect = CGRectMake(60, _count * self.frame.size.height / self.timeCount + offsetHeight, 12, 1);
//    [self scaleLine:LineRect];
//    CGPoint hourLabCenter = CGPointMake(20,_count * self.frame.size.height / self.timeCount + offsetHeight);
//    NSString *time = [NSString stringWithFormat:@"%.2d:00",_count - _count];
//    [self timeText:hourLabCenter withTitle:time];
//
//
////    // 统计的总高度
////    CGFloat allHeight = 0.0;
////    NSMutableArray *imagePositionArray = [NSMutableArray array];
////    // 绘制视频条
////    for (int j = 0; j < self.scrollModel.endArray.count; j++) {
////        // 视频间距
////        CGFloat hourHeight = self.frame.size.height / self.timeCount;
////        UIView *videoView = [[UIView alloc] init];
////        if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
////            videoView.backgroundColor = MaiBackColor;
////        } else {
////            videoView.backgroundColor = PlayBackWarningLineColor;
////        }
////        [self addSubview:videoView];
////
////        NSString *videoSpacing = self.scrollModel.offsetArray[j];
////        CGFloat videoSpacingHeight = videoSpacing.floatValue * hourHeight / TimeRulerScaleTypeHour1;
////
////        int time_0 = [self.scrollModel.timeLongArray[j] intValue];
////        CGFloat videoHeight = time_0 * hourHeight / TimeRulerScaleTypeHour1;
////        videoView.frame = CGRectMake(50, allHeight, 10, videoHeight);
////        CGFloat tmpHeight = [imagePositionArray.lastObject floatValue];
////
////        if (allHeight - 80 > tmpHeight || j == 0) {
////
////            UIView *bgView = [[UIView alloc] init];
////            bgView.frame = CGRectMake(80, allHeight - 5, 200, 70);
////            [self addSubview:bgView];
//////            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//////                make.top.offset(allHeight - 5);
//////                make.leading.offset(80);
//////                make.size.sizeOffset(CGSizeMake(width_screen - 80 - 100, 70));
//////            }];
////
////            UIImageView *imageView = [[UIImageView alloc] init];
////            imageView.frame = CGRectMake(5, 5, 100, 60);
////            imageView.image = [UIImage imageNamed:@"VideoDefault"];
////            imageView.userInteractionEnabled = YES;
////            imageView.tag = j;
////            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAntion:)];
////            recognizer.numberOfTouchesRequired = 1; //tap次数
////            [imageView addGestureRecognizer:recognizer];
////            [bgView addSubview:imageView];
////
////
////
////            NSString *tmpHeight = [NSString stringWithFormat:@"%lf",allHeight];
////            [imagePositionArray addObject:tmpHeight];
////
////            UILabel *timeLab = [UILabel new];
////            timeLab.frame = CGRectMake(110, 30,50, 20);
////            timeLab.backgroundColor = [UIColor grayColor];
////            timeLab.textColor = [UIColor whiteColor];
////            timeLab.font = [UIFont systemFontOfSize:10.0];
//////            timeLab.center = hourLabCenter;
////            timeLab.textAlignment = NSTextAlignmentCenter;
////            timeLab.layer.masksToBounds = YES;
////            timeLab.layer.cornerRadius = 10.0;
////            timeLab.text = [self makeHourMinuteSecondFromIndex:[self.scrollModel.timeLongArray[j] integerValue]];
////            [bgView addSubview:timeLab];
////
////
////
////            UILabel *typeLab = [UILabel new];
////            typeLab.textColor = [UIColor grayColor];
////            typeLab.font = [UIFont systemFontOfSize:10.0];
////            [bgView addSubview:typeLab];
////            if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
////                typeLab.text = NSLocalizedString(@"Alarm", @"");
////            } else {
////                typeLab.text = NSLocalizedString(@"Full time", @"");
////            }
////            typeLab.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 5, 100, 15);
////
////
////
////            if (self.isfullScreen) {
////                bgView.backgroundColor = [UIColor clearColor];
////                typeLab.hidden = YES;
////            } else {
////
//////                if (self.offSet_Y > allHeight && self.offSet_Y < allHeight + 70) {
////                    bgView.backgroundColor = ViewBackgroundColor;
////                    typeLab.hidden = NO;
//////                } else {
//////                    bgView.backgroundColor = [UIColor clearColor];
//////                    typeLab.hidden = YES;
//////                }
////
////
////            }
////
////            [self.bgViewArray addObject:bgView];
////            [self.typeArray addObject:typeLab];
////
////        }
////
////        allHeight += videoSpacingHeight;
////        NSString *currentHeight = [NSString stringWithFormat:@"%lf",allHeight];
////        [self.heightArray addObject:currentHeight];
////    }
//
//
//}


- (void) imageViewAntion:(UITapGestureRecognizer *)recognizer {
    
    NSInteger index = 0;
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)recognizer;
    if ([singleTap view].tag > 0)
        index = [singleTap view].tag;
    NSLog(@"点击图片 = %ld------------当前图片位置 = %@",index,self.heightArray[index]);
//    NSLog(@"当前点击开始时间 = %@",self.scrollModel.startArray[index]);
    if (self.imageViewAction) {
        self.imageViewAction(index, self.heightArray[index]);
    }
}

#pragma mark - 创建时间文字
- (UILabel *) timeText:(CGPoint)point withTitle:(NSString *)title {
    
    UILabel *hourLab = [UILabel new];
    hourLab.frame = CGRectMake(point.x, point.y, 50, 20);
    
//    CGPoint hourLabCenter = point;
    hourLab.center = point;
    if (self.isfullScreen) {
        hourLab.textColor = [UIColor whiteColor];
    } else {
        hourLab.textColor = [UIColor grayColor];
    }
    hourLab.font = [UIFont systemFontOfSize:12.0];
    
    hourLab.textAlignment = NSTextAlignmentCenter;
    hourLab.backgroundColor = [UIColor orangeColor];
    hourLab.text = title;
    [self addSubview:hourLab];
    [self.timeArray addObject:hourLab];
    return hourLab;
    
}

#pragma mark - 刻度条
- (UIView *) withPoint:(CGPoint)point withWidth:(CGFloat)width{
    
    UIView *LineView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, width, 1)];
//    LineView.center = point;
    LineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:LineView];
    return LineView;
}

- (NSString *)makeHourMinuteSecondFromIndex:(NSInteger)index {
    NSString *time = nil;
    NSInteger hour =  index/60/60;
    NSInteger minute =  index/60%60;
    NSInteger second =  index%60;
    if (hour == 0) {
        time = [NSString stringWithFormat:@"%02d:%02d",(int)minute,(int)second];
    }else {
        time = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)hour,(int)minute,(int)second];
    }
    return time;
}

- (void)setIsfullScreen:(BOOL)isfullScreen {
    _isfullScreen = isfullScreen;
    for (int i = 0; i < self.timeArray.count; i++) {
        UILabel *timeLab = self.timeArray[i];
        if (isfullScreen) {
            timeLab.textColor = [UIColor whiteColor];
        } else {
            timeLab.textColor = [UIColor grayColor];
        }
    }
    for (int i = 0; i < self.bgViewArray.count; i++) {
        UIView *bgView = self.bgViewArray[i];
        UIView *typeLab = self.typeArray[i];
        if (isfullScreen) {
            bgView.backgroundColor = [UIColor clearColor];
            typeLab.hidden = YES;
        } else {
            bgView.backgroundColor = [UIColor lightGrayColor];
            typeLab.hidden = NO;
        }
    }
}


- (void)setScrollModel:(AJ_ScrollMode *)scrollModel {
    _scrollModel = scrollModel;
    
    [self loadTimeRuleView];
}


#pragma mark - 懒加载

- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}

- (NSMutableArray *)timeArray {
    if (!_timeArray) {
        _timeArray = [NSMutableArray array];
    }
    return _timeArray;
}

- (NSMutableArray *)bgViewArray {
    if (!_bgViewArray) {
        _bgViewArray = [NSMutableArray array];
    }
    return _bgViewArray;
}

- (NSMutableArray *)typeArray {
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

- (NSMutableArray *)hourLabArray {
    if (!_hourLabArray) {
        _hourLabArray = [NSMutableArray array];
    }
    return _hourLabArray;;
}

- (NSMutableArray *)hourLineArray {
    if (!_hourLineArray) {
        _hourLineArray = [NSMutableArray array];
    }
    return _hourLineArray;;
}



- (NSMutableArray *)minuteArray_30 {
    if (!_minuteArray_30) {
        _minuteArray_30 = [NSMutableArray array];
    }
    return _minuteArray_30;;
}

- (NSMutableArray *)minuteLineArray_30 {
    if (!_minuteLineArray_30) {
        _minuteLineArray_30 = [NSMutableArray array];
    }
    return _minuteLineArray_30;;
}

- (NSMutableArray *)minuteArray_10 {
    if (!_minuteArray_10) {
        _minuteArray_10 = [NSMutableArray array];
    }
    return _minuteArray_10;;
}

- (NSMutableArray *)minuteLineArray_10 {
    if (!_minuteLineArray_10) {
        _minuteLineArray_10 = [NSMutableArray array];
    }
    return _minuteLineArray_10;;
}

- (NSMutableArray *)minuteArray_5 {
    if (!_minuteArray_5) {
        _minuteArray_5 = [NSMutableArray array];
    }
    return _minuteArray_5;;
}

- (NSMutableArray *)minuteLineArray_5 {
    if (!_minuteLineArray_5) {
        _minuteLineArray_5 = [NSMutableArray array];
    }
    return _minuteLineArray_5;;
}

- (NSMutableArray *)minuteArray_1 {
    if (!_minuteArray_1) {
        _minuteArray_1 = [NSMutableArray array];
    }
    return _minuteArray_1;;
}

- (NSMutableArray *)minuteLineArray_1 {
    if (!_minuteLineArray_1) {
        _minuteLineArray_1 = [NSMutableArray array];
    }
    return _minuteLineArray_1;
}

- (NSMutableArray *)lineVideoViewArray {
    if (!_lineVideoViewArray) {
        _lineVideoViewArray = [NSMutableArray array];
    }
    return _lineVideoViewArray;
}

@end
