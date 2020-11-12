//
//  RuleView.h
//  ruleDemo
//
//  Created by mac02 on 2020/9/23.
//  Copyright © 2020 HaiLai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJ_ScrollMode.h"
NS_ASSUME_NONNULL_BEGIN

@interface RuleView : UIView

//-(instancetype)initWithCount:(int)count model:(AJ_ScrollMode *)scrollModel;
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) AJ_ScrollMode *scrollModel; // 数据模型
@property (nonatomic, assign) CGFloat timeCount;
@property (nonatomic, assign) int minuteCount;
@property (nonatomic, copy) void (^backCurrentTimeBlock)(NSString *currentTime);
@property (nonatomic, copy) void (^imageViewAction)(NSInteger index,NSString *currentHeight);

@end

NS_ASSUME_NONNULL_END
