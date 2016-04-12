//
//  XTCalendarCell.h
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTCalendarCell : UICollectionViewCell

/** 这月几号 */
@property (nonatomic, strong) NSString *today;
/** 文件颜色 */
@property (nonatomic, strong) UIColor *textColor;
/** 是否是之前的日期 */
@property (nonatomic, assign,getter=isPasted) BOOL pasted;
/** 是否是可以选中的 */
@property (nonatomic, assign,getter=isChoosed) BOOL choosed;

@end
