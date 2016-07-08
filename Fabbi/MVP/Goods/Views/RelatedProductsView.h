//
//  RelatedProductsView.h
//  Fabbi
//
//  Created by zou145688 on 16/6/20.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol relatedProductsViewDelegate <NSObject>
- (void)addFloatingView:(NSDictionary *)dic;
@end
@interface RelatedProductsView : UIView
@property (nonatomic,strong) UILabel *relatedtitle;
@property (nonatomic,strong) UIImageView *relatedImageView;
@property (nonatomic,strong) UIImageView *focusImageView;
@property (nonatomic,strong) UILabel *focusNumberL;
@property (nonatomic,strong) NSDictionary *itemContenDic;
@property (nonatomic,weak)id<relatedProductsViewDelegate>delegate;
@end
