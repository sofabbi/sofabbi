
//  MyUtils.m
//  EATFIT
//  Created by 刘志刚 on 16/3/8.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import <CommonCrypto/CommonDigest.h>
#import "MyUtils.h"
#import "WXApi.h"


@implementation MyUtils
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius clipsToBounds:(BOOL)clipsToBounds userInteractionEnabled:(BOOL)userInteractionEnabled{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    if (imageName) {
         [imageView setImage:[UIImage imageNamed:imageName]];
    }
   
    imageView.layer.cornerRadius = cornerRadius;
    // 可以被裁剪
    imageView.clipsToBounds = clipsToBounds;
    // 响应用户的交互
    imageView.userInteractionEnabled = userInteractionEnabled;
    return imageView;
}

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName{
  
         return [self createImageViewFrame:frame imageName:imageName cornerRadius:0.f clipsToBounds:YES userInteractionEnabled:YES];
}

+ (UITextField *)createTextFieldFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment font:(CGFloat)font placeholder:(NSString *)placeholder clearButtonMode:(UITextFieldViewMode)clearButtonMode leftViewMode:(UITextFieldViewMode)leftViewMode  clearsOnBeginEditing:(BOOL)clearsOnBeginEditing secureTextEntry:(BOOL)secureTextEntry leftViewTitle:(NSString *)leftViewTitle textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor labelTextColor:(UIColor *)labelTextColor delegate:(id)delegate{
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    // 里面label的颜色
    UILabel *label = [self createLabelFrame:CGRectMake(0, 0, 60*kScreenWidthP, 21*kScreenWidthP) backgroundColor:backgroundColor title:leftViewTitle font:15];
     label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    label.textColor = labelTextColor;
    textField.leftView = label;
    
    textField.textAlignment = textAlignment;
    // 左边view能否显示
    textField.leftViewMode=leftViewMode;
    // text文字大小
    textField.font = [UIFont systemFontOfSize:font];
    // textfield类型
    textField.borderStyle = borderStyle;
    // textfield上面的灰色文字
    textField.placeholder = placeholder;
    [textField setValue:RGBA(79, 79, 79, 1) forKeyPath:@"_placeholderLabel.textColor"];
    // 加粗用boldSystemFontOfSize
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    // 编辑时方框右边出现叉叉
    textField.clearButtonMode = clearButtonMode;
    // 再次编辑是否清空
    textField.clearsOnBeginEditing = clearsOnBeginEditing;
    // 密码的形式
    textField.secureTextEntry = secureTextEntry;
    
    textField.textColor = textColor;
    textField.backgroundColor = backgroundColor;
    textField.delegate = delegate;
    return textField;
}

+ (UITextField *)createTextFieldFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle font:(CGFloat)font  textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor {
      UITextField *textField = [[UITextField alloc]initWithFrame:frame];
      textField.font = [UIFont systemFontOfSize:font];
      textField.borderStyle = borderStyle;
      textField.textColor = textColor;
      textField.backgroundColor = backgroundColor;
     return textField;
    
}

+ (UIView *)createViewFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    return view;
}

+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor numberOfLines:(NSInteger)numberOfLines  layerCornerRadius:(CGFloat)layerCornerRadius{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    label.layer.cornerRadius = layerCornerRadius;
    label.backgroundColor = backgroundColor;
    return label;
}

+ (UILabel *)createLabelFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor title:(NSString *)title font:(CGFloat)font {
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = backgroundColor;
    label.text = title;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:font];
    return label;
    
}
+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title selectTitle:(NSString *)selectTitle  titleColor:(UIColor *)titleColor bgImageName:(NSString *)bgImageName selectImageName:(NSString *)selectImageName backgroundColor:(UIColor *)backgroundColor layerCornerRadius:(CGFloat)layerCornerRadius target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (selectTitle) {
        [btn setTitle:selectTitle forState:UIControlStateSelected];
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (selectImageName) {
        [btn setImage:[[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    }
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    if (layerCornerRadius) {
        btn.layer.cornerRadius = layerCornerRadius;
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateSelected];
    btn.backgroundColor = backgroundColor;
    btn.titleLabel.backgroundColor = [UIColor whiteColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor tintColor:(UIColor *)tintColor  backgroundColor:(UIColor *)backgroundColor font:(CGFloat)font borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    btn.tintColor = tintColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.layer.borderWidth = borderWidth;
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.borderColor = (__bridge CGColorRef _Nullable)(borderColor);
    btn.backgroundColor = backgroundColor;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIScrollView *)createScrollViewFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor contentSize:(CGSize)contentSize{
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:frame];
    scroView.backgroundColor = backgroundColor;
    scroView.contentSize = contentSize;
    return scroView;
}

/**
 Md5加密
 */
+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ]lowercaseString];
}

// 获取createTime
+ (NSString *)returnCreateTime{
    // 首先时间固定在2015年9月9日
    //    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    //    [format setDateFormat:@"yyyy-MM-dd"];
    //    NSString * s1=@"2015-09-09";
    //    NSDate *date=[format dateFromString:s1];
    
    NSDate *date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSString * createTime = [NSString stringWithFormat:@"%.0f",interval];
    return createTime;
}

/**
 获取今天的date
 */
+ (NSString *)returnDate{
    //日期格式类
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    //自定义格式字符串
    [format setDateFormat:@"yyyy-MM-dd"];
    // 将时间对象转换为字符串
    NSString *sdate=[format stringFromDate:[NSDate date]];
    return sdate;
}

// 16进制转化为RGB代码
+(UIColor *) getColor:(NSString *)hexColor alpha:(CGFloat)alpha{
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:alpha];
}

+ (void)sendAuthRequest{
    
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq
    [WXApi sendReq:req];
}

+ (NSString *)returnTomoDate:(NSInteger)number{
    //日期格式类
    NSDateFormatter * format=[[NSDateFormatter alloc]init];
    //自定义格式字符串
    [format setDateFormat:@"MM月dd日"];
    // 距离现在往后第number天
    NSString *tomDate=[format stringFromDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*(-number)]];
    return tomDate;
}


@end
