//
//  XTHeaderView.h
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTHeaderViewDetegate <NSObject>

- (void)clearWithChooseDate;
- (void)finishWithChooseDate;

@end

@interface XTHeaderView : UIView
+ (instancetype)headerView;
/** XTHeaderView代理 */
@property (nonatomic, weak) id<XTHeaderViewDetegate> delegate;

@end
