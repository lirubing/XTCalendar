//
//  XTHeaderView.m
//  NSCalendar
//
//  Created by ZhengXiangteng on 16/4/12.
//  Copyright © 2016年 前辈丶. All rights reserved.
//

#import "XTHeaderView.h"

@interface XTHeaderView ()

/** 清楚按钮 */
@property (nonatomic, strong) UIButton *clearBtn;
/** 完成按钮 */
@property (nonatomic, strong) UIButton *finishBtn;
/** 顶部Label */
@property (nonatomic, strong) UILabel *titleLable;
@end

@implementation XTHeaderView

+ (instancetype)headerView{

    return [[self alloc]init];
}



- (UIButton *)clearBtn{
    if (!_clearBtn) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
        clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];
        _clearBtn = clearBtn;
        
    }
    return _clearBtn;
}
- (UIButton *)finishBtn{
    if (!_finishBtn) {
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:finishBtn];
        _finishBtn = finishBtn;
    }
    return _finishBtn;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = @"请选择入住日期";
        titleLable.textColor = [UIColor blackColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLable];
        _titleLable = titleLable;
    }
    return _titleLable;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.clearBtn.frame = CGRectMake(10, 0, 40, 40);
    self.finishBtn.frame = CGRectMake(self.frame.size.width - 50, 0, 40, 40);
    self.titleLable.frame = CGRectMake(CGRectGetMaxX(self.clearBtn.frame)+10, 0, self.frame.size.width-120, 40);    
}

- (void)clear{

    if (_delegate && [_delegate respondsToSelector:@selector(clearWithChooseDate)]) {
        [_delegate clearWithChooseDate];
    }
}

- (void)finish{
    if (_delegate && [_delegate respondsToSelector:@selector(finishWithChooseDate)]) {
        [_delegate finishWithChooseDate];
    }
}

@end
