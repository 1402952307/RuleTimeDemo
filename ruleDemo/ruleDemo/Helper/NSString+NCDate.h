//
//  NSString+NCDate.h
//  NatureCard
//
//  Created by zhongzhi on 2017/8/18.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NCDate)

+(NSString *)timeIntervalFromDateStr:(NSString *)timeStr; //时间戳转换为时间-年月日
+(NSString *)timeIntervalFromTimeStr:(NSString *)timeStr; //时间转换为时间戳
+(NSString *)formateDate:(NSString *)string;//时间戳转换为时间
+(NSInteger)getNowInterVal;//获取当前的时间戳
+(NSString *)getNowTime;//获取当前的时间字符串
+(NSString *)formateDateToDay:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyYueri:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyShifen:(NSString *)string;//时间戳转换为时间

+(NSDate *)dateFromTimeStr:(NSString *)timeStr;//年月日转换为date;
+(NSString *)ret32bitString;//随机的32位字符串
+(NSDate *)currentDay;

+(NSString *)getTimeFromDateTimes:(NSString *)timeStr;//把”时间搓“转化为“时间”
+ (NSString *)getTimeFromTimesTamp:(NSString *)timeStr;// 转换成时分秒

+ (NSString *)notRounding:(id)price afterPoint:(NSInteger)position;

@end
