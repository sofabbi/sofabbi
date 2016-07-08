//
//  ButtonLarge.h
//  Fabbi
//
//  Created by zou145688 on 16/6/12.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LargeButtonType) {
    kMainButtonType = 2100,
    kSubButtonType
};
@interface ButtonLarge : UIButton
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)pTitle withButtonType:(LargeButtonType)pType;
@end
