//
//  XTDateViewController.h
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTCalendarView.h"
@interface XTDateViewController : UIViewController
/** 完成之后的回调日期(开始-结束) */
@property (nonatomic, copy) void (^finishBlock)(XTDate strat_date,XTDate end_date,int DateInterval);
- (void)show;

- (void)hiden;
@end
