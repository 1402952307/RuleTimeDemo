//
//  AJTimer.m
//  ZosiSmart
//
//  Created by mac01 on 2020/4/7.
//  Copyright © 2020 tutksz_ios. All rights reserved.
//

#import "AJTimer.h"

@interface AJTimer()

@property(nonatomic, strong)dispatch_source_t _timer;

@end



@implementation AJTimer


@synthesize _timer;




/**
 开始倒计时
 */
- (void)timerWithTimeVlaueSum:(int)timeValue beginState:(void (^)(int seconds))begin endState:(void (^)())end{
    __block NSInteger time = timeValue; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
 
                end();
            });
            
        }else{
            time--;
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
 
                
                begin(seconds);
            });
            
        }
    });
    dispatch_resume(_timer);
    
}

/**
取消倒计时
*/
- (void)cancelTimer{
    if(_timer)
        dispatch_source_cancel(_timer);

}





@end
