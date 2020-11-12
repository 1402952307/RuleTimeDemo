//
//  AJTimer.h
//  ZosiSmart
//
//  Created by mac01 on 2020/4/7.
//  Copyright © 2020 tutksz_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJTimer : NSObject
/**
 倒计时
 @param timeValue 总时间
 @Block begin开始回调
 @Block end结束倒计时
 */
- (void)timerWithTimeVlaueSum:(int)timeValue beginState:(void (^)(int seconds))begin endState:(void (^)())end;

/**
取消倒计时
*/
- (void)cancelTimer;

@end

NS_ASSUME_NONNULL_END
