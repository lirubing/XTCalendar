//
//  XTCalendarCell.m
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import "XTCalendarCell.h"

@interface XTCalendarCell ()
/** 显示日期的label */
@property (nonatomic, strong) UILabel *lable;
/** 状态的View */
@property (nonatomic, strong) UIView *statusView;

@end

@implementation XTCalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.bounds.size.width-4, self.bounds.size.height-4)];
        statusView.backgroundColor = [UIColor redColor];
        statusView.alpha = 0.0f;
        self.statusView = statusView;
        [self.contentView addSubview:statusView];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.lable = lable;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.adjustsFontSizeToFitWidth = YES;
        lable.font = [UIFont systemFontOfSize:14];
        lable.textColor = [UIColor blackColor];
        [self.contentView addSubview:lable];

    }
    return self;
}

- (void)setToday:(NSString *)today{
    _today = today;
    self.lable.text = today;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.lable.textColor = textColor;
}

- (void)setChoosed:(BOOL)choosed{
    _choosed = choosed;
    if (choosed) {
        self.statusView.alpha = 1.0;
    }else{
        self.statusView.alpha = 0.0;
    }
}

@end
