//
//  DetailPageLikeCell.h
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseCell.h"

@protocol DetailPageLikeDelegate <NSObject>

- (void)showDetailViewOfUser:(NSString *)pUid;
- (void)sendLike:(BOOL)isLike withFeedId:(NSString *)feedId andFakeLikeId:(NSString *)fakeLikeId andIsFriend:(BOOL)isFriend atIndexPath:(NSIndexPath *)pIndexPath;
- (void)sendUnLikeWithFeedId:(NSString *)feedId andLikeId:(NSString *)likeId atIndexPath:(NSIndexPath *)pIndexPath;
@end
@interface DetailPageLikeCell : BaseCell
@property (nonatomic, strong) NSArray *likeUsers;
@property (nonatomic, strong) UIImageView *imageView0;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIImageView *imageView4;
@property (nonatomic, strong) UIImageView *imageView5;
@property (nonatomic, strong) UIImageView *imageView6;

@property (nonatomic, weak) id <DetailPageLikeDelegate> delegate;
- (void)setLikeContent:(NSDictionary *)content;
@end
