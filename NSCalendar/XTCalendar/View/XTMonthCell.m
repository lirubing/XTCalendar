//
//  XTMonthCell.m
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/11.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import "XTMonthCell.h"
#import "XTCalendarView.h"

@interface XTMonthCell ()

@end
@implementation XTMonthCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    XTMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XTMonthCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        XTCalendarView *calendarView = [[XTCalendarView alloc] init];
//        XTCalendarView *calendarView = [[XTCalendarView alloc]  initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 250)];
        calendarView.backgroundColor = [UIColor redColor];
        if (self.calendar.num > 35) {
            calendarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 250);
        }else{
            calendarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 200);
        }
        self.calendar = calendarView;
        [self.contentView addSubview:calendarView];
        
    }
    return self;
    
}

- (void)setDate:(NSDate *)date{
    
    _date = date;
    self.calendar.date = date;
}

- (void)setTodayDate:(NSDate *)todayDate{
    _todayDate = todayDate;
    self.calendar.todayDate = todayDate;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
