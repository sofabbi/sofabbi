//
//  ImageViewCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/21.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"

@protocol ImageViewCellDelegate <NSObject>

- (void)getCellH:(CGFloat)cellH;
- (void)selectImageView:(UIImageView *)imageView itemFileLists:(NSArray *)itemFileLists;
- (void)selectImageView:(UIImageView *)imageView;
@end
@interface ImageViewCell : BaseCell<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, weak) id<ImageViewCellDelegate>delegate;
- (void)addTextAttributedLabel:(NSDictionary *)dic;
+(CGFloat)getAddTextAttributedLabel:(NSDictionary *)dic;
@end
