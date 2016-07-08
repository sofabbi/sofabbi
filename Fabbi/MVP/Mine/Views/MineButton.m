//
//  MineButton.m
//  Fabbi
//
//  Created by 刘志刚 on 16/6/2.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineButton.h"

@implementation MineButton

//设置按钮上的标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    

    return CGRectMake(55*kScreenWidthP, 13.5*kScreenWidthP, 40*kScreenWidthP, 16*kScreenWidthP);
}

//设置按钮上的图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
   return CGRectMake(30*kScreenWidthP, 14.5*kScreenWidthP, 18.3*kScreenWidthP, 16*kScreenWidthP);
}

@end
