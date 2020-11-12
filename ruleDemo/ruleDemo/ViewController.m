//
//  ViewController.m
//  ruleDemo
//
//  Created by HaiLai on 17/6/23.
//  Copyright © 2017年 HaiLai. All rights reserved.
//

#import "ViewController.h"
#import "AJ_ScrollMode.h"
#import "NSString+NCDate.h"
#import "NSDate+Extension.h"
#import "RuleScrollView.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ruleSV;

@property (strong, nonatomic) RuleScrollView *ruleScrollView;
@property (nonatomic, strong) AJ_ScrollMode *scrollModel; // 数据模型
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic,assign) CGFloat timeCount;

@end

@implementation ViewController

#define width_screen [UIScreen mainScreen].bounds.size.width
#define height_screen [UIScreen mainScreen].bounds.size.height

#pragma mark - 获取当请时间0点0分时间戳
- (int)getPastTimestamps:(int)currentTime{
    
    NSString *tmpSelectDate = [NSString stringWithFormat:@"%@-%@-%@",[NSDate GetYearStringWithSeconds:currentTime],[NSDate GetMonthStringWithSeconds:currentTime],[NSDate GetDayStringWithSeconds:currentTime]];
    
    //当前时间戳 - 当天0点时间戳 = 时间戳的差（当天过了几秒了）
    NSString *currentDay = [[NSString timeIntervalFromTimeStr:[NSString stringWithFormat:@"%@ 00:00:0",tmpSelectDate]] substringWithRange:NSMakeRange(0, 10)];
    // 获取当前时间第几秒
//    int scrollTime = currentTime - currentDay.intValue;
    return currentDay.intValue;
}

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];

    NSString *dateStr = [NSString getTimeFromTimesTamp:[NSString stringWithFormat:@"%@000",self.scrollModel.endArray[0]]];
    NSArray *tmpArr = [dateStr componentsSeparatedByString:@":"];
    CGFloat timeCount = [tmpArr[0] integerValue] + [tmpArr[1] floatValue]/60.0 + [tmpArr[2] floatValue] / 3600;
    self.timeCount = timeCount;
    
    RuleScrollView *ruleView =  [[RuleScrollView alloc] initWithCounts:[tmpArr[0] intValue] model:self.scrollModel];
    ruleView.frame = CGRectMake(0, 350, width_screen, height_screen - 350);
    self.ruleScrollView = ruleView;
    [self.view addSubview:ruleView];
    self.view.backgroundColor = [UIColor redColor];
}

- (void) loadData {
    NSArray *datasArray = [self readLocalFileWithName:@"Test2"];
    for (NSDictionary *dic in datasArray) {

        NSInteger type = [dic[@"type"] integerValue]; 
        // 开始时间
        NSInteger startTime = [dic[@"time"] integerValue] / 1000;
        // 录屏时长
        NSInteger timeLong = [dic[@"duration"] integerValue];
        // 结束时间 - 显示结束时间

        NSInteger endTime = startTime + timeLong;
        NSString *timeStr = [NSString stringWithFormat:@"%zd",endTime];
        
        [self.scrollModel.typeArray addObject:[NSString stringWithFormat:@"%zd",type]];
        [self.scrollModel.timeLongArray addObject:[NSString stringWithFormat:@"%zd",timeLong]];
        [self.scrollModel.startArray addObject:[NSString stringWithFormat:@"%zd",startTime]];
        [self.scrollModel.endArray addObject:timeStr];
        
    }
    
//    int firstTime1 = [self getPastTimestamps:[self.scrollModel.endArray[0] intValue]];
//    [self.scrollModel.endArray addObject:[NSString stringWithFormat:@"%d",firstTime1]];
    
    NSInteger timeSum = 0;
    for (int i = 0; i < self.scrollModel.endArray.count; i++) {
        NSInteger tmpOffset = 0;
        if (i < self.scrollModel.endArray.count - 1) {
            tmpOffset = [self.scrollModel.endArray[i] integerValue] - [self.scrollModel.endArray[i + 1] integerValue];
            timeSum += tmpOffset;
            
        } else {
            tmpOffset = [self.scrollModel.endArray.lastObject integerValue] - [self.scrollModel.startArray.lastObject integerValue];
            timeSum += tmpOffset;
        }
        [self.scrollModel.offsetArray addObject:[NSString stringWithFormat:@"%zd",tmpOffset]];
        [self.scrollModel.timeSumArray addObject:[NSString stringWithFormat:@"%zd",timeSum]];
        
    }
    
    NSLog(@"%@",datasArray);
}

// 读取本地JSON时间文件
- (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (AJ_ScrollMode *)scrollModel {
    if (!_scrollModel) {
        _scrollModel = [[AJ_ScrollMode alloc] init];
    }
    return _scrollModel;
}







@end

