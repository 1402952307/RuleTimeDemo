//
//  AJ_ScrollMode.h
//  TimeLineView
//
//  Created by mac02 on 2020/4/24.
//  Copyright © 2020 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJ_ScrollMode : NSObject

// 类型数组  0,0,0,1,1,1,1,
@property (nonatomic, strong) NSMutableArray *typeArray;

// 录屏时长数组 451,530,435,133,616,225,
@property (nonatomic, strong) NSMutableArray *timeLongArray;

// 两段的偏移 555,530,525,137,620,226,
@property (nonatomic, strong) NSMutableArray *offsetArray;

// 开始时长数组  1587026274,1587025719,1587025189,1587024664,1587024527
@property (nonatomic, strong) NSMutableArray *startArray;
// 结束时长数组  1587026274,1587025719,1587025189,1587024664,1587024527
@property (nonatomic, strong) NSMutableArray *endArray;

// 压缩比数组  6.1666666667,5.8888888889,5.8333333333,1.0000000000,6.8888888889
@property (nonatomic, strong) NSMutableArray *compressArray;

// 所有压缩后偏移累加 0,140,230,320,453,543,768,988,
@property (nonatomic, strong) NSMutableArray *offsetSumArray;

@property (nonatomic, strong) NSMutableArray *timeSumArray;


// 每个播放的视频在刻度尺上可滚动距离
@property (nonatomic, strong) NSMutableArray *videoScrollArray;
// 每个间段在刻度尺上距离
@property (nonatomic, strong) NSMutableArray *intervalScrollArray;


@property (nonatomic, strong) NSMutableArray *timeLeftArray;

@end

NS_ASSUME_NONNULL_END
