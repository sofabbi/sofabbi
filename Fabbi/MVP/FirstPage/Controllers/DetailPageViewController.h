//
//  DetailPageViewController.h
//  MVP
//
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailPageViewController : BaseViewController
@property (nonatomic, strong)NSString *itemId;
// 用来传递,作为参数的
@property (nonatomic,assign)NSInteger sportId;
@property (nonatomic,strong)NSString *url;
@property (nonatomic, strong)NSString *itemVoid;
//接收传过来的日期
@property (nonatomic,copy)NSString *date;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic) CGSize currentKeyboardSize;
@property (nonatomic)BOOL keyboardIsShown;
@property (nonatomic,assign)NSInteger currentPage;
@end
