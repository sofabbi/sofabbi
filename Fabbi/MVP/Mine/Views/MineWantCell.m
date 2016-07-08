//
//  MineWantCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/7.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MineWantCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MineWantCell ()
@property (nonatomic, weak) UIImageView *coverLeft;
@property (nonatomic, weak) UIImageView *coverRight;



@property (nonatomic, weak) NSArray *currentFavArray;

@property (nonatomic, weak) UILabel *lableL;
@property (nonatomic, weak) UILabel *lableR;

@property (nonatomic, weak) UIButton *btn_left;
@property (nonatomic, weak) UIButton *btn_right;


@end
@implementation MineWantCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat ratio = kScreenWidthP;
    
        
        CGFloat rightX = kScreenWidth - 182*kScreenWidthP;
        
        UIImageView *imView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10*kScreenWidthP, 10.5*kScreenWidthP, 172.f * ratio, 172.f * ratio)];
        imView1.contentMode = UIViewContentModeScaleAspectFill;
        imView1.clipsToBounds = YES;
        [self.contentView addSubview:imView1];
        _coverLeft = imView1;
        
        UIImageView *imView2 = [[UIImageView alloc] initWithFrame:CGRectMake(rightX, 10.5, 172.f * ratio, 172.f * ratio)];
        imView2.contentMode = UIViewContentModeScaleAspectFill;
        imView2.clipsToBounds = YES;
        [self.contentView addSubview:imView2];
        _coverRight = imView2;
        
        
       
        
   
        
        
        UILabel *titleLabelL = [[UILabel alloc] initWithFrame:CGRectMake(10.f*kScreenWidthP, CGRectGetMaxX(imView1.frame)+5*kScreenWidthP, 171.f * ratio, 42.f * ratio)];
        titleLabelL.font = [UIFont systemFontOfSize:14];
        titleLabelL.text = @"";
        titleLabelL.numberOfLines = 0;
        titleLabelL.textColor = [UIColor blackColor];
        titleLabelL.textAlignment = NSTextAlignmentLeft;
        titleLabelL.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabelL];
        _lableL = titleLabelL;
        
        UILabel *titleLabelR = [[UILabel alloc] initWithFrame:CGRectMake(rightX, CGRectGetMaxX(imView1.frame)+5*kScreenWidthP, 171.f * ratio, 42.f * ratio)];
        titleLabelR.font = [UIFont systemFontOfSize:14];
        titleLabelR.text = @"";
        titleLabelR.numberOfLines = 0;
        titleLabelR.textColor = [UIColor blackColor];
        titleLabelR.textAlignment = NSTextAlignmentLeft;
        titleLabelR.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabelR];
        _lableR = titleLabelR;
        
        UIButton *buttonL = [[UIButton alloc] initWithFrame:_coverLeft.frame];
        buttonL.tag = 111;
        [buttonL addTarget:self action:@selector(tapOnCover:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:buttonL];
        _btn_left.hidden = YES;
        _btn_left = buttonL;
        
        UIButton *buttonR = [[UIButton alloc] initWithFrame:_coverRight.frame];
        buttonR.tag = 222;
        [buttonR addTarget:self action:@selector(tapOnCover:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:buttonR];
        _btn_right.hidden = YES;
        _btn_right = buttonR;
        
        
        
    }
    return self;

}


- (void)setContent:(NSArray *)itemsGroup atIndexPath:(NSIndexPath *)indexPath{
    _contentArr = itemsGroup;
    _indexPath = indexPath;
    UIImage *maskCover = [UIImage imageNamed:@"placeholderImage"];
    _currentFavArray = itemsGroup;
        if (itemsGroup.count > indexPath.row*2) {
            _btn_left.hidden = NO;
            MineCollectionModel *model = itemsGroup[indexPath.row*2];
            [_coverLeft sd_setImageWithURL:[NSURL URLWithString:model.itemFileUrl] placeholderImage:maskCover options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    _coverLeft.image=image;
                }
            }];
            _lableL.text = model.itemName;
        }
    
    if (itemsGroup.count > indexPath.row*2 + 1) {
        _btn_right.hidden = NO;
       MineCollectionModel *model = itemsGroup[indexPath.row*2+1];
        [_coverRight sd_setImageWithURL:[NSURL URLWithString:model.itemFileUrl] placeholderImage:maskCover options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image ) {
                _coverRight.image=image;
            }
        }];
         _lableR.text = model.itemName;
    }
   
}


- (void)tapOnCover:(UIButton *)sender{
    
        MineCollectionModel *groupItem;
        if (sender.tag == 111) {
            groupItem = _currentFavArray[_indexPath.row*2];
        }else{
            if (_currentFavArray.count > 1) {
                groupItem = _currentFavArray[_indexPath.row *2+1];
            }
        }
        if (self.delegate && groupItem) {
            [self.delegate favorAblumTapped:groupItem];
        }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
