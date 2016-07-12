//
//  GoodsViewController.h
//  MVP
//
//  Created by 刘志刚 on 16/5/17.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <TYAttributedLabel.h>
@interface GoodsViewController : BaseViewController
@property (nonatomic) CGSize currentKeyboardSize;
@property (nonatomic)BOOL keyboardIsShown;
@property (nonatomic, strong) NSString *speicalId;

@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) TYAttributedLabel *IntroductionL;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIWebView *detailedDescription;
@property (nonatomic, assign) CGFloat webH;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@end
