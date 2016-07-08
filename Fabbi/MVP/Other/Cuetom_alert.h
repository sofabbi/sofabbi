//
//  Cuetom_alert.h
//  Fabbi
//
//  Created by zou145688 on 16/6/16.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cuetom_alert;
@protocol custom_alertViewDelegate <NSObject>

- (void)popAlertView:(Cuetom_alert *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
@interface Cuetom_alert : UIView
@property (nonatomic, strong) NSString *targetUid;
@property (nonatomic, weak) id <custom_alertViewDelegate> delegate;

- (id)initWithTitle:(NSString *)pTitle message:(NSString *)pMessage delegate:(id)pDelegate andButtons:(NSArray *)pButtons;
- (void)show;
@end
