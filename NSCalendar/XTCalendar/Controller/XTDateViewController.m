//
//  XTDateViewController.m
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import "XTDateViewController.h"
#import "XTMonthCell.h"
#import "AppDelegate.h"
#define XTColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

XTDate endDate;
XTDate startDate;

@interface XTDateViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
/** 今天 */
@property (nonatomic, strong) NSDate *today;
/** 日期组件 */
@property (nonatomic, strong) NSDateComponents *dateComponents;

@end

@implementation XTDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.today = [NSDate date];
    self.dateComponents = [[NSDateComponents alloc]init];
    
    [self initView];
    
}

- (void)initView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 20, self.view.bounds.size.width-100, self.view.bounds.size.height-20) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XTMonthCell *cell = [XTMonthCell cellWithTableView:tableView];
    cell.todayDate = self.today;
    self.dateComponents.month = +indexPath.row;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:self.dateComponents toDate:self.today options:0];
    cell.date = newDate;

    
    __weak typeof(self) weakSelf = self;
    cell.calendar.calendarBlock = ^(XTDate date) {
        //如果当前的选择的日期 
        if (date.year == startDate.year && date.month == startDate.month && date.day == startDate.day) {
            [weakSelf clear];
        }else if (startDate.day>0 && endDate.day>0) {
            [weakSelf clear];
            startDate = date;
        }else{
            if (startDate.day) {
                endDate = date;
                [weakSelf.tableView reloadData];
            }else{
                startDate = date;
                [weakSelf.tableView reloadData];
            }
        }
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(10, 0, 40, 40);
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:clearBtn];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(tableView.bounds.size.width-60, 0, 40, 40);
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:finishBtn];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clearBtn.frame)+10, 0, self.tableView.bounds.size.width-120, 40)];
    titleLable.text = @"请选择入住日期";
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:titleLable];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
}

- (void)clear{
    
    startDate.day = 0;
    startDate.month = 0;
    startDate.year = 0;
    endDate.day = 0;
    endDate.month = 0;
    endDate.year = 0;
    [self.tableView reloadData];
}

- (void)finish{
    
    NSString *startY = [NSString stringWithFormat:@"%ld",startDate.year];
    NSString *startM = [NSString stringWithFormat:@"-%ld",startDate.month];
    NSString *startD = [NSString stringWithFormat:@"-%ld",startDate.day];
    NSString *endY = [NSString stringWithFormat:@"%ld",endDate.year];
    NSString *endM = [NSString stringWithFormat:@"-%ld",endDate.month];
    NSString *endD = [NSString stringWithFormat:@"-%ld",endDate.day];
    NSString *start = [[startY stringByAppendingString:startM] stringByAppendingString:startD];
    NSString *end = [[endY stringByAppendingString:endM] stringByAppendingString:endD];
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //创建了两个日期对象
    NSDate *date1=[dateFormatter dateFromString:end];
    NSDate *date2=[dateFormatter dateFromString:start];
    
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date1 timeIntervalSinceDate:date2];
    
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
//    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
    if (self.finishBlock) {
        self.finishBlock(startDate,endDate,days);
        
    }
//    if (startDate.day != 0 && endDate.day != 0) {
//    }
    [self clear];
    [self hiden];
    
    
    
}

- (void)show{
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [delegate.window.rootViewController presentViewController:self animated:YES completion:^{
//            [UIView animateWithDuration:0.25 animations:^{
//                self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//            }];
            
        }];
    }else{
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [delegate.window.rootViewController presentViewController:self animated:YES completion:^{
//            [UIView animateWithDuration:0.25 animations:^{
//                self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//            }];
        }];
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
}

- (void)hiden{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)dealloc{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
