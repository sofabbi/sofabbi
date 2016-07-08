//
//  MyUtils.h
//  EATFIT
//
//  Created by 刘志刚 on 16/3/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface MyUtils : NSObject
/**
 快速构建label，button，imageview，textfield，ScrollView的工厂方法
 */
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName  cornerRadius:(CGFloat)cornerRadius clipsToBounds:(BOOL)clipsToBounds userInteractionEnabled:(BOOL)userInteractionEnabled;
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (UITextField *)createTextFieldFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment font:(CGFloat)font placeholder:(NSString *)placeholder clearButtonMode:(UITextFieldViewMode)clearButtonMode leftViewMode:(UITextFieldViewMode)leftViewMode  clearsOnBeginEditing:(BOOL)clearsOnBeginEditing secureTextEntry:(BOOL)secureTextEntry leftViewTitle:(NSString *)leftViewTitle textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor labelTextColor:(UIColor *)labelTextColor delegate:(id)delegate;
+ (UITextField *)createTextFieldFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle font:(CGFloat)font  textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;

+ (UIView *)createViewFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor numberOfLines:(NSInteger)numberOfLines layerCornerRadius:(CGFloat)layerCornerRadius;
+ (UILabel *)createLabelFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor title:(NSString *)title font:(CGFloat)font;

+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title  selectTitle:(NSString *)selectTitle titleColor:(UIColor *)titleColor bgImageName:(NSString *)bgImageName selectImageName:(NSString *)selectImageName backgroundColor:(UIColor *)backgroundColor layerCornerRadius:(CGFloat)layerCornerRadius target:(id)target action:(SEL)action;

+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action;

+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor tintColor:(UIColor *)tintColor  backgroundColor:(UIColor *)backgroundColor font:(CGFloat)font borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor target:(id)target action:(SEL)action;

+ (UIScrollView *)createScrollViewFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor  contentSize:(CGSize)contentSize;
/**
 Md5加密
 */
+ (NSString *)md5:(NSString *)str;

/**
 获取createTime
 */
+ (NSString *)returnCreateTime;
/**
 获取date
 */
+ (NSString *)returnDate;
/**
 16进制转化为RGB代码
 */
+(UIColor *) getColor:(NSString *)hexColor alpha:(CGFloat)alpha;
// 此为微信第三方登陆
+ (void)sendAuthRequest;

/**
 返回日期
 */
+ (NSString *)returnTomoDate:(NSInteger)number;

@end
