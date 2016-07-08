//
//  ViewController.h
//  MVP
//
//  Created by 刘志刚 on 16/5/18.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
/***
 第一部分动画
 */

@property (nonatomic,strong)UIScrollView *scrollView;











/**
 *  第一阶段
 */
@property (nonatomic, strong) UIView *midView;//
@property (nonatomic, strong) UIView *bottomView;//

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) FXBlurView *blurView;// 毛玻璃

@property (nonatomic, strong) UIView *bgView;// 底view

@property (nonatomic, strong) UIImageView *rightHeaderImageView;// 右边头像ImageView
@property (nonatomic, strong) UIImageView *rightHeaderImageView2;// 右边头像ImageView2

@property (nonatomic, strong) UIImageView *leftHeaderImageView;// 左边头像ImageView

@property (nonatomic, strong) DXPopover *popover;// 弹框

@property (nonatomic, strong) UIView *chatView1;//对话框1
@property (nonatomic, strong) UIView *chatView2;//对话框2
@property (nonatomic, strong) UIView *chatView3;//对话框3

@property (nonatomic, strong) UIImageView *contentImage1;//对话框图片内容1
@property (nonatomic, strong) UIImageView *contentImage2;//对话框图片内容2

@property (nonatomic, strong) UILabel *contentText1;//对话框文字内容1
@property (nonatomic, strong) UILabel *contentText2;//对话框文字内容2
@property (nonatomic, strong) UILabel *contentText3;//对话框文字内容3

@property (nonatomic, strong) UIButton *buyBtn;

/**
 *  第二阶段
 */
@property (nonatomic, strong) UIView *bgView2;// 第二次底view

@property (nonatomic, strong) UIImageView *imageLeft;//左
@property (nonatomic, strong) UIImageView *imageTop;//上
@property (nonatomic, strong) UIImageView *imageRight;//右
@property (nonatomic, strong) UIImageView *imageBottom;//下

@property (nonatomic, strong) UIImageView *hat;//
@property (nonatomic, strong) UIImageView *glasses;//

@property (nonatomic, strong) UIView *midView2;//

/**
 *  第三阶段
 */
@property (nonatomic, strong) UIImageView *bgView3;// 第三次底view

@property (nonatomic, strong) UIImageView *logo;// see的logo

@property (nonatomic, strong) UILabel *note;// 时尚在此刻

@property (nonatomic, strong) UIButton *openSee;// 开启See 2016

@end

