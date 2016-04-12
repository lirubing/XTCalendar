//
//  XTCalendarView.h
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/11.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    NSUInteger day;
    NSUInteger month;
    NSUInteger year;
} XTDate;

@interface XTCalendarView : UIView
/** 日期 */
@property (nonatomic, strong) NSDate *date;
/** 今天 */
@property (nonatomic, strong) NSDate *todayDate;
/** 日期 */
@property (nonatomic, copy) void(^calendarBlock)(XTDate date);
@end
