//
//  NSString+string.h
//  Loocam
//
//  Created by mac mini01 on 2019/8/1.
//  Copyright © 2019 tutksz_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (string)

// 获取字符串的宽度
+ (float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

// 获取字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

// 判断是否需要升级
+(BOOL)compareVersion:(NSString *)NewVersion current:(NSString *)current;

+ (NSString *)getCurrentTimezone;
// 获取当前手机WiFi名称
+ (NSString *)currentWifiSSID;
+ (NSString *)ssid;
@end

NS_ASSUME_NONNULL_END
