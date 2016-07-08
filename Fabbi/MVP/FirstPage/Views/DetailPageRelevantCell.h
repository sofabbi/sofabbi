//
//  DetailPageRelevantCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/21.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"
@interface DetailPageRelevantCell : BaseCell
- (void)addTextAttributedLabel:(NSDictionary *)dic;
+ (CGFloat)getAddTextAttributedLabel:(NSDictionary *)dic;
@end
