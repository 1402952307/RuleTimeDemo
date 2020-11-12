//
//  NSString+string.m
//  Loocam
//
//  Created by mac mini01 on 2019/8/1.
//  Copyright © 2019 tutksz_ios. All rights reserved.
//

#import "NSString+string.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation NSString (string)

#pragma mark - 获取字符串的宽度
+ (float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit.width;
}

#pragma mark - 获取字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置returnsizeToFit.height;
    return sizeToFit.height;
}

#pragma mark - 判断是否需要升级
+(BOOL)compareVersion:(NSString *)NewVersion current:(NSString *)current{
    //    NewVersion = "1.1.A";current = "1.1.3";
    NSArray *arry1 = [NewVersion componentsSeparatedByString:@"."];
    NSArray *arry2 = [current componentsSeparatedByString:@"."];
    
    BOOL isMax = NO;
    
    for (int i = 0; i < arry1.count; i++) {
        NSInteger itemNum1 = [[NSString alloc] AlphanumericWithConversion:arry1[i]];
        NSInteger itemNum2 = 0;
        if (i < arry2.count)
            itemNum2 = [[NSString alloc] AlphanumericWithConversion:arry2[i]];
        if (itemNum1 > itemNum2){
            isMax = YES;
            break;
        }
    }
    return isMax;
}

-(NSInteger)AlphanumericWithConversion:(NSString *)itemString{
    if ([itemString isEqualToString:@"A"])
        return 10;
    else if ([itemString isEqualToString:@"B"])
        return 11;
    else if ([itemString isEqualToString:@"C"])
        return 12;
    else if ([itemString isEqualToString:@"D"])
        return 13;
    else if ([itemString isEqualToString:@"E"])
        return 14;
    else if ([itemString isEqualToString:@"F"])
        return 15;
    else
        return [itemString integerValue];
}

+ (NSString *)getCurrentTimezone
{
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSString *strZoneAbbreviation = [localZone abbreviation];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:0 error:nil];
    strZoneAbbreviation = [regularExpression stringByReplacingMatchesInString:strZoneAbbreviation options:0 range:NSMakeRange(0, strZoneAbbreviation.length) withTemplate:@""];
    return strZoneAbbreviation;
}

//获取当前手机wifi名称
+ (NSString *)currentWifiSSID{
    //arc模式获取wifi名
    NSString *ssid = nil;
    NSArray *ifs = (id)CFBridgingRelease(CNCopySupportedInterfaces());
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (id)CFBridgingRelease(CNCopyCurrentNetworkInfo(( CFStringRef)ifnam));
        if (info[@"SSID"]) {
            ssid = [NSString stringWithString:info[@"SSID"]];
        }
    }
    return ssid;
}

+ (NSString *)ssid

{
    
        NSString *ssid = @"Not Found";
    
        CFArrayRef myArray = CNCopySupportedInterfaces();
    
        if (myArray != nil) {
        
                CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        
                if (myDict != nil) {
            
                        NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
                        ssid = [dict valueForKey:@"SSID"];
            
                    }
        
            }
    
        return ssid;
    
}

@end
