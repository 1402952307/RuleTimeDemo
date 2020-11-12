//
//  RuleScrollView.h
//  ruleDemo
//
//  Created by mac02 on 2020/9/23.
//  Copyright © 2020 HaiLai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJ_ScrollMode.h"

NS_ASSUME_NONNULL_BEGIN



@interface RuleScrollView : UIView

@property (nonatomic, strong) AJ_ScrollMode *scrollModel;

-(instancetype)initWithCounts:(int)count model:(AJ_ScrollMode *)scrollModel;

@property (nonatomic, copy) void(^backCurrentTimeBlock)(NSString *currentTime);

@end

NS_ASSUME_NONNULL_END
