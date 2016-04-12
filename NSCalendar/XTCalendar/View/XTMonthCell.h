//
//  XTMonthCell.h
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/11.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTCalendarView.h"
@interface XTMonthCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 日期 */
@property (nonatomic, strong) NSDate *date;
/** 今天 */
@property (nonatomic, strong) NSDate *todayDate;

@property (nonatomic, strong) XTCalendarView *calendar;

@end
