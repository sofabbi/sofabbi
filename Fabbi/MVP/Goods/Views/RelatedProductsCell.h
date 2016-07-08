//
//  RelatedProductsCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"

@protocol RelatedProductsCellDelegate <NSObject>
- (void)addFloatingView:(NSDictionary *)dic;
@end
@interface RelatedProductsCell : BaseCell<UIWebViewDelegate>
@property (nonatomic,strong)NSDictionary *contentDictionary;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,weak) id<RelatedProductsCellDelegate>delegate;
+(CGFloat)getCellHeight:(NSDictionary *)model;
@end
