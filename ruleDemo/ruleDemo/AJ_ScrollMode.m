//
//  AJ_ScrollMode.m
//  TimeLineView
//
//  Created by mac02 on 2020/4/24.
//  Copyright © 2020 zengjia. All rights reserved.
//

#import "AJ_ScrollMode.h"

@implementation AJ_ScrollMode

- (NSMutableArray *)startArray {
    if (!_startArray) {
        _startArray = [NSMutableArray array];
    }
    return _startArray;
}

- (NSMutableArray *)endArray {
    if (!_endArray) {
        _endArray = [NSMutableArray array];
    }
    return _endArray;
}

- (NSMutableArray *)typeArray {
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

- (NSMutableArray *)timeLongArray {
    if (!_timeLongArray) {
        _timeLongArray = [NSMutableArray array];
    }
    return _timeLongArray;
}

- (NSMutableArray *)offsetArray {
    if (!_offsetArray) {
        _offsetArray = [NSMutableArray array];
    }
    return _offsetArray;
}

- (NSMutableArray *)compressArray {
    if (!_compressArray) {
        _compressArray = [NSMutableArray array];
    }
    return _compressArray;
}


- (NSMutableArray *)offsetSumArray {
    if (!_offsetSumArray) {
        _offsetSumArray = [NSMutableArray array];
    }
    return _offsetSumArray;
}

- (NSMutableArray *)timeSumArray {
    if (!_timeSumArray) {
        _timeSumArray = [NSMutableArray array];
    }
    return _timeSumArray;
}

- (NSMutableArray *)videoScrollArray {
    if (!_videoScrollArray) {
        _videoScrollArray = [NSMutableArray array];
    }
    return _videoScrollArray;
}

- (NSMutableArray *)intervalScrollArray {
    if (!_intervalScrollArray) {
        _intervalScrollArray = [NSMutableArray array];
    }
    return _intervalScrollArray;
}

- (NSMutableArray *)timeLeftArray {
    if (!_timeLeftArray) {
        _timeLeftArray = [NSMutableArray array];
    }
    return _timeLeftArray;
}



@end
