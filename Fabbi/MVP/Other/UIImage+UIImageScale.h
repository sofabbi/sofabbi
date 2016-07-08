//
//  UIImage+UIImageScale.h
//  Fabbi
//
//  Created by zou145688 on 16/6/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)
#pragma 截取部分图像
-(UIImage*)getSubImage:(CGRect)rect;
#pragma 等比例缩放
-(UIImage*)scaleToSize:(CGSize)size;
#pragma 压缩图片
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
