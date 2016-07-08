//
//  MineView.m
//  Fabbi
//
//  Created by 刘志刚 on 16/6/2.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineView.h"

@implementation MineView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[UIView alloc]initWithFrame:frame];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *labelA = [[UILabel alloc]initWithFrame:CGRectMake(0, 1*kScreenWidthP, kScreenWidth, 0.5*kScreenWidthP)];
        UILabel *labelB = [[UILabel alloc]initWithFrame:CGRectMake(0, 67*kScreenWidthP, kScreenWidth, 0.5*kScreenWidthP)];
        labelA.backgroundColor = RGBA(186, 186, 186, 1);
        labelB.backgroundColor = RGBA(186, 186, 186, 1);
        [view addSubview:labelA];
        [view addSubview:labelB];
    }
    return self;
}

@end
