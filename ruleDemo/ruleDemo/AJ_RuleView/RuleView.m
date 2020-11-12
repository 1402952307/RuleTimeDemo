//
//  RuleView.m
//  ruleDemo
//
//  Created by mac02 on 2020/9/23.
//  Copyright © 2020 HaiLai. All rights reserved.
//

#import "RuleView.h"
#import "UIView+Layout.h"
#import "NSString+NCDate.h"
#import "UIView+Frame.h"

@interface RuleView ()

@property (nonatomic,assign) int count;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *heightArray;


@property (nonatomic, strong) NSMutableArray *hourLabArray;
@property (nonatomic, strong) UIView *lineLayer; // 线条

@property (nonatomic,assign) int hourCount;

@end

@implementation RuleView

//-(instancetype)initWithCount:(int)count model:(AJ_ScrollMode *)scrollModel {
//    
//    if (self = [super init]) {
//        self.count = count;
//        self.scrollModel = scrollModel;
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}

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
    
    
    for (int i = 0; i <= self.minuteCount; i++) {
    
        // 小时
        if (i % 60 == 0) {
//            CGPoint hourLabCenter = CGPointMake(20,(i / 60) * hourHeight + offsetHeight);
//            NSString *time = @"12:00";
//            UILabel *hourLab = [self timeText:hourLabCenter withTitle:time];
//            hourLab.tag = i;
//            [self.hourLabArray addObject:hourLab];
            
//            int tag = i / 60;
//            UILabel *hourLab = self.hourLabArray[tag];
//            int currentTime = self.hourCount - (i / 60);
////            CGPointMake(20,currentTime * hourHeight + offsetHeight);
////            hourLab.frame = CGRectMake(20, (i / 60) * hourHeight + offsetHeight, 50, 20);
//
//            hourLab.frame = CGRectMake(20, currentTime * hourHeight + offsetHeight, 50, 20);
//
//            NSLog(@"========= %lf",currentTime * hourHeight + offsetHeight);
            
            int tag = i / 60;
            UILabel *hourLab = self.hourLabArray[tag];
            int currentTime = self.hourCount - (i / 60);
            CGPointMake(20,currentTime * hourHeight + offsetHeight);
            hourLab.frame = CGRectMake(20, currentTime * hourHeight + offsetHeight, 50, 20);
            NSLog(@"+++++++++++++ %lf",(i / 60) * hourHeight + offsetHeight);
            
        }
        
        

    }
    
}


-(void)myLayoutSubviews11 {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
//    [self.heightArray removeAllObjects];
//    [self.timeArray removeAllObjects];
//    [self.typeArray removeAllObjects];
//    [self.bgViewArray removeAllObjects];

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
            
            CGPoint hourLabCenter = CGPointMake(20,currentTime * hourHeight + offsetHeight);
            NSString *time = [NSString stringWithFormat:@"%.2d:00",(i / 60)];
            UILabel *hourLab = [self timeText:hourLabCenter withTitle:time];
            hourLab.tag = i;
            [self.hourLabArray addObject:hourLab];
            
            NSLog(@"+++++++++++++ %lf",currentTime * hourHeight + offsetHeight);
//            CGRect lineRect = CGRectMake(60, currentTime * hourHeight + offsetHeight, 8, 1);
//            [self scaleLine:lineRect];
        }

        
//        if (i % 30 == 0 && i % 60 != 0) {
//
//            CGPoint banHourLabCenter = CGPointMake(20,(currentTime * hourHeight) - (hourHeight * 0.5) + offsetHeight);
//            NSString *time = [NSString stringWithFormat:@"%.2d:30",(i / 60)];
//            UILabel *banHourLab = [self timeText:banHourLabCenter withTitle:time];
//            banHourLab.tag = i;
////            [self.hourLabArray addObject:banHourLab];
//
//        }
        
    }
    
}




#pragma mark - 瞎鸡吧写
//-(void)layoutSubviews {
//    [super layoutSubviews];
//
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
//
//    [self.imageArray removeAllObjects];
//    [self.heightArray removeAllObjects];
//
//    // 线条
//    UIView *lineLayer = [[UIView alloc] init];
//    lineLayer.backgroundColor = [UIColor lightGrayColor];
//    lineLayer.frame = CGRectMake(50, -50, 10, self.frame.size.height * 2);
//    [self addSubview:lineLayer];
//
//    CGFloat hourHeight = self.frame.size.height / self.timeCount;
//    NSString *dateStr = [NSString getTimeFromTimesTamp:[NSString stringWithFormat:@"%@000",self.scrollModel.endArray[0]]];
//    NSArray *tmpArr = [dateStr componentsSeparatedByString:@":"];
//
//    CGFloat offsetHeight = 0.0;
//    if (tmpArr.count == 3) {
//        CGFloat offset_Y = [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / 3600;
//        offsetHeight = hourHeight * offset_Y;
//    }
//
//    NSLog(@"Start hourHeight = %lf",hourHeight);
//    for (int i = 0; i < _count; i++) {
//
//        // 小时
//        NSString *time = [NSString stringWithFormat:@"%.2d:00",_count - i];
//        CGPoint hourLabCenter = CGPointMake(20,i * hourHeight + offsetHeight);
//        if (hourHeight < 100  && i % 2 == 1) {
//            UILabel *titleLab = [self timeText:hourLabCenter withTitle:time];
//            titleLab.hidden = YES;
//            CGRect lineRect = CGRectMake(60, i * hourHeight  + offsetHeight, 8, 1);
//            [self scaleLine:lineRect];
//        } else {
//            UILabel *titleLab = [self timeText:hourLabCenter withTitle:time];
//            titleLab.hidden = NO;
//            CGRect lineRect = CGRectMake(60, i * hourHeight  + offsetHeight, 12, 1);
//            [self scaleLine:lineRect];
//        }
//
//        // 十分钟刻度
//        if (hourHeight > 100) {
//            for (int j = 1; j <= 5; j++) {
//
//                CGFloat tenHeight = offsetHeight + (i * hourHeight) + (j / 6.0) * hourHeight;
//                CGRect lineRect = CGRectMake(60, tenHeight, 6, 1);
//                [self scaleLine:lineRect];
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
//                    CGRect lineRect = CGRectMake(60, min5, 6, 1);
//                    [self scaleLine:lineRect];
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
//                    CGRect lineRect = CGRectMake(60, min5, 6, 1);
//                    [self scaleLine:lineRect];
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
//            CGRect lineRect = CGRectMake(60, hourHeight * i + hourHeight * 0.5 + offsetHeight, 8, 1);
//            [self scaleLine:lineRect];
//
//            CGPoint banHourLabCenter = CGPointMake(20, hourHeight * i + hourHeight * 0.5 + offsetHeight);
//            NSString *time = [NSString stringWithFormat:@"%.2d:30",_count - 1 - i];
//            [self timeText:banHourLabCenter withTitle:time];
//
//        }
//    }
//
//
//    CGRect lineRect = CGRectMake(60, _count * self.frame.size.height / self.timeCount + offsetHeight, 12, 1);
//    [self scaleLine:lineRect];
//    CGPoint hourLabCenter = CGPointMake(20,_count * self.frame.size.height / self.timeCount + offsetHeight);
//    NSString *time = [NSString stringWithFormat:@"%.2d:00",_count - _count];
//    [self timeText:hourLabCenter withTitle:time];
//
//
//    // 统计的总高度
//    CGFloat allHeight = 0.0;
//    NSMutableArray *imagePositionArray = [NSMutableArray array];
//    // 绘制视频条
//    for (int j = 0; j < self.scrollModel.endArray.count; j++) {
//        // 视频间距
//        CGFloat hourHeight = self.frame.size.height / self.timeCount;
//        UIView *videoView = [[UIView alloc] init];
//        if ([self.scrollModel.typeArray[j] isEqualToString:@"1"]) {
//            videoView.backgroundColor = [UIColor greenColor];
//        } else {
//            videoView.backgroundColor = [UIColor redColor];
//        }
//        [self addSubview:videoView];
//
//        NSString *videoSpacing = self.scrollModel.offsetArray[j];
//        CGFloat videoSpacingHeight = videoSpacing.floatValue * hourHeight / 3600;
//
//        int time_0 = [self.scrollModel.timeLongArray[j] intValue];
//        CGFloat videoHeight = time_0 * hourHeight / 3600;
//        videoView.frame = CGRectMake(50, allHeight, 10, videoHeight);
//        CGFloat tmpHeight = [imagePositionArray.lastObject floatValue];
//
//        if (allHeight - 80 > tmpHeight || j == 0) {
//
//            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(80, allHeight - 5, 220, 70)];
//            bgView.backgroundColor = [UIColor lightGrayColor];
//            [self addSubview:bgView];
//
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.backgroundColor = [UIColor orangeColor];
//            imageView.frame = CGRectMake(5, 5, 100, 60);
//            [imageView setUserInteractionEnabled:YES];
//            imageView.tag = j;
//
//            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAntion:)];
//            recognizer.numberOfTouchesRequired = 1; //tap次数
//            [imageView addGestureRecognizer:recognizer];
//            [bgView addSubview:imageView];
//
//            NSString *tmpHeight = [NSString stringWithFormat:@"%lf",allHeight];
//            [imagePositionArray addObject:tmpHeight];
//
//
//            UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
//            CGPoint hourLabCenter = CGPointMake(80, 50);
//            timeLab.textColor = [UIColor whiteColor];
//            timeLab.backgroundColor = [UIColor redColor];
//            timeLab.font = [UIFont systemFontOfSize:10.0];
//            timeLab.center = hourLabCenter;
//            timeLab.textAlignment = NSTextAlignmentCenter;
//            timeLab.layer.masksToBounds = YES;
//            timeLab.layer.cornerRadius = 10.0;
//            timeLab.text = [self makeHourMinuteSecondFromIndex:[self.scrollModel.timeLongArray[j] integerValue]];
//            [bgView addSubview:timeLab];
//
//            UILabel *typeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 5, 100, 15)];
//            typeLab.textColor = [UIColor whiteColor];
//            typeLab.font = [UIFont systemFontOfSize:10.0];
//            typeLab.text = @"触发移动报警录像";
//            [bgView addSubview:typeLab];
//
//        }
//
//        allHeight += videoSpacingHeight;
//        NSString *currentHeight = [NSString stringWithFormat:@"%lf",allHeight];
//        [self.heightArray addObject:currentHeight];
//    }
//}

- (void) imageViewAntion:(UITapGestureRecognizer *)recognizer {
    
    NSInteger index = 0;
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)recognizer;
    if ([singleTap view].tag > 0)
        index = [singleTap view].tag;

    NSLog(@"点击图片 = %ld------------当前图片位置 = %@",index,self.heightArray[index]);

    NSLog(@"当前点击开始时间 = %@",self.scrollModel.startArray[index]);
    
    if (self.imageViewAction) {
        self.imageViewAction(index, self.heightArray[index]);
    }
}

#pragma mark - 创建时间文字
- (UILabel *) timeText:(CGPoint)point withTitle:(NSString *)title {
    
    UILabel *hourLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    CGPoint hourLabCenter = point;
    hourLab.textColor = [UIColor whiteColor];
    hourLab.font = [UIFont systemFontOfSize:12.0];
    hourLab.center = hourLabCenter;
    hourLab.textAlignment = NSTextAlignmentCenter;
    hourLab.backgroundColor = [UIColor orangeColor];
    hourLab.text = title;
    [self addSubview:hourLab];
    return hourLab;
}

- (void)setScrollModel:(AJ_ScrollMode *)scrollModel {
    _scrollModel = scrollModel;
    [self loadTimeRuleView];
}

#pragma mark - 刻度条
- (UIView *) scaleLine:(CGRect)frame {
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    return lineView;
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

- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}

@end
