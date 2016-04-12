//
//  XTCalendarView.m
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/11.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import "XTCalendarView.h"
#import "XTWeekView.h"
#import "XTCalendarCell.h"
@interface XTCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation XTCalendarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setDate:(NSDate *)date{
    
    _date = date;
    [self.collectionView reloadData];
}

//当前月份1号是从周几开始的
- (NSUInteger)weekForThisMonthFirstDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周从第星期几开始(1是周日)
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_date];
    //这个月的1号是从星期几开始的.
    [components setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:components];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    
    return firstWeekday - 1;
}
//当前月份有多少天
- (NSUInteger)daysForThisMonth{
    
     NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.date];

    return daysInLastMonth.length + [self weekForThisMonthFirstDay];
}
//当前日期的年份
- (NSUInteger)year{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];

    return components.year;
}
//当前日期的月份
- (NSUInteger)month{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    return components.month;
}
//当前月份是几号
- (NSUInteger)today{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];

    return components.day;
}


- (void)initView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width/7, (self.bounds.size.height - 50)/6);
    flowLayout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 50);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[XTCalendarCell class] forCellWithReuseIdentifier:@"cell"];
//    [self.collectionView registerClass:[weekView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[XTWeekView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"week"];

    [self addSubview:self.collectionView];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSLog(@"%ld",[self daysForThisMonth]);
    self.num = [self daysForThisMonth];
    return [self daysForThisMonth];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XTCalendarCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    myCell.pasted = NO;
    BOOL canSelected = YES; //是否可以别选择
    myCell.choosed = NO;
    
    //日期的号数
    NSUInteger firstWeekday = [self weekForThisMonthFirstDay];
    NSUInteger day = indexPath.row - firstWeekday + 1;
    
    if (firstWeekday > indexPath.row) {
        myCell.today = @"";
        canSelected = NO;
        myCell.pasted = YES;
    }else{
        //如果是当天就显示 "今天"
        if ([self.date isEqual:self.todayDate] && [self today] == day) {
            myCell.today = @"今天";
        }else{
            myCell.today = [NSString stringWithFormat:@"%ld",day];
        }
        
        //如果本月的日期的号数比今天小,让其字体颜色为灰色,并不可点击
        if ( day < [self today] && [self.date isEqual:self.todayDate]) {
            myCell.textColor = [UIColor lightGrayColor];
            myCell.pasted = YES;
            canSelected = NO;
        }else{
            myCell.textColor = [UIColor blackColor];
        }
    }
    
    
    
    extern XTDate startDate;
    extern XTDate endDate;
    //cell日期的年份
    NSUInteger year = [self year];
    //cell日期的月份
    NSUInteger month = [self month];
    //每个cell日期 年份 * 10000 + 月份 * 100 + 号数
    NSInteger cellDate = year * 10000 + month * 100 + day;
    //选择开始日期 年份 * 10000 + 月份 * 100 + 号数
    NSInteger start = startDate.year * 10000 + startDate.month * 100 + startDate.day;
    //选择结束日期 年份 * 10000 + 月份 * 100 + 号数
    NSInteger end = endDate.year * 10000 + endDate.month * 100 + endDate.day;
    //当只是选择了开始
    if (startDate.day > 0 && endDate.day == 0) {
        //如果cell日期比选择开始的日期小,让其为灰色,不可点击
        if (cellDate < start) {
            myCell.pasted = YES;
            myCell.textColor = [UIColor grayColor];
        //当cell日期正好是选择开始的日期,让其可以点击
        }else if (cellDate == start){
            myCell.today = @"开始";
            myCell.choosed = YES;
        }else{ //其他
            myCell.textColor = [UIColor blackColor];
        }
    }
    
    //选择结束日期
    if (startDate.day && endDate.day) {
        //开始和结束之间的日期
        if (start <= cellDate && cellDate <= end && canSelected) {
            myCell.choosed = YES;
            if (start == cellDate) {
                myCell.today = @"开始";
            }else if (end == cellDate){
                myCell.today = @"结束";
            }
        }else{
            myCell.choosed = NO;
        }
    }
    
    
    return myCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XTCalendarCell *cell = (XTCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //如果是过滤掉的日期
    if (cell.pasted == YES) {
        return;
    }
    cell.choosed = YES;
    
    
    NSUInteger firstWeekday = [self weekForThisMonthFirstDay];
    
    NSUInteger day = indexPath.row - firstWeekday + 1;
    __weak typeof(self) weakSelf = self;
    if (self.calendarBlock) {
        XTDate date;
        date.day = day;
        date.month = [weakSelf month];
        date.year = [weakSelf year];
        self.calendarBlock(date);
    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    XTWeekView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"week" forIndexPath:indexPath];
    
    headerView.month = [NSString stringWithFormat:@"%ld-%ld",[self year],[self month]];
    return headerView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
