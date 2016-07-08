//
//  DetailPageRelevantInformationCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"

@interface DetailPageRelevantInformationCell : BaseCell
+(CGFloat)getAddTextAttributedLabel:(NSString *)type;
- (void)addTextAttributedLabel:(NSString *)type;

@end
