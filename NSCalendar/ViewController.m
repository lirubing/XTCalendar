//
//  ViewController.m
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import "ViewController.h"
#import "XTDateViewController.h"
@interface ViewController ()
/** <#注释#> */
@property (nonatomic, strong) XTDateViewController *vc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
//    XTDateViewController *vc = [[XTDateViewController alloc]init];
//    self.vc = vc;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor lightGrayColor];
    }];
    XTDateViewController *vc = [[XTDateViewController alloc]init];

    vc.finishBlock = ^(XTDate startDate,XTDate endDate,int day){
        NSLog(@"开始时间:%ld-%ld-%ld",startDate.year,startDate.month,startDate.day);
        NSLog(@"结束时间:%ld-%ld-%ld",endDate.year,endDate.month,endDate.day);
        NSLog(@"总共:%i天",day);
        self.view.backgroundColor = [UIColor whiteColor];
    };
    [vc show];

}
- (IBAction)BUTTON:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
