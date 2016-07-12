//
//  CoverView.m
//  MVP
//
//  Created by 刘志刚 on 16/5/11.
//  Copyright © 2016年 刘志刚. All rights reserved.


#import "CoverView.h"
#import "MyUtils.h"
#import "UIImageView+WebCache.h"
#import "CoverViewCollectionCell.h"
#import "UserStore.h"
// exit

@interface CoverView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    UIView *myview;
}
@end
@implementation CoverView
static NSString * const CellReuseIdentifier = @"photoCell";
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame ]){
        self.backgroundColor = RGBA(0, 0, 0, 0.85);
        //显示的内容
        myview =[MyUtils createViewFrame:CGRectMake((kScreenWidth - 340*kScreenWidthP)/2, 104*kScreenWidthP, 340*kScreenWidthP, 420*kScreenWidthP) backgroundColor:RGBA(255, 255, 255, 1)];
        myview.layer.cornerRadius = 5*kScreenWidthP;
        myview.clipsToBounds = YES;
        [self addSubview:myview];
        //collection
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0.f;
        layout.minimumLineSpacing = 0.f;
        layout.itemSize = CGSizeMake(CGRectGetWidth(myview.frame), CGRectGetWidth(myview.frame));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(myview.frame), CGRectGetWidth(myview.frame)) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        [self.collectionView registerClass:[CoverViewCollectionCell class] forCellWithReuseIdentifier:CellReuseIdentifier];
        [myview addSubview:_collectionView];
        
        self.linkView = [[LinkView alloc] initWithFrame:CGRectMake(0, CGRectGetWidth(myview.frame), CGRectGetWidth(myview.frame), 80*kScreenWidthP) isShowCommit:NO];
        _linkView.delegate = self;
        [myview addSubview:self.linkView];
        
        //UIPageControl
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0,6, 160*kScreenWidthP, 20*kScreenWidthP)];
        _pageControl.center = CGPointMake(myview.frame.size.width/2, 330*kScreenWidthP);
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPage=0;
        [myview addSubview:_pageControl];
        //简介
        _detailView = [[UITextView alloc]init];
        _detailView.backgroundColor = [UIColor clearColor];
        _detailView.frame = CGRectMake(0, 0, CGRectGetWidth(myview.frame), CGRectGetWidth(myview.frame));
        _detailView.hidden = YES;
        [myview addSubview:_detailView];
        
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.frame = CGRectMake(0, 0, CGRectGetWidth(myview.frame), CGRectGetWidth(myview.frame));
        [_detailView addSubview:effe];
        
        _detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(30*kScreenWidthP, 80*kScreenWidthP, CGRectGetWidth(myview.frame)-60*kScreenWidthP, CGRectGetWidth(myview.frame)-80*kScreenWidthP)];
        _detailTextView.backgroundColor = [UIColor clearColor];
        _detailTextView.text = @"没有详细信息....";
        _detailTextView.showsVerticalScrollIndicator = NO;
        _detailTextView.showsHorizontalScrollIndicator = NO;
        _detailTextView.textAlignment = NSTextAlignmentJustified;
        _detailTextView.font = [UIFont systemFontOfSize:16];
        [_detailView addSubview:_detailTextView];
        //切换
        self.selectedView=[[UIView alloc]init];
        self.selectedView.frame=CGRectMake(CGRectGetWidth(myview.frame)-70*kScreenWidthP, 0, 70*kScreenWidthP,50*kScreenWidthP);
        [myview addSubview:self.selectedView];
        _selectedView.userInteractionEnabled = YES;
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _selectBtn.frame=CGRectMake(3*kScreenWidthP, 14*kScreenWidthP,53*kScreenWidthP,21*kScreenWidthP);
        [_selectBtn setBackgroundColor:RGBA(34, 34, 34, 0.8)];
        [_selectBtn setTitle:@"详情" forState:UIControlStateNormal];
        [_selectBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:13*kScreenWidthP];
        [_selectBtn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.layer.masksToBounds = YES;
        _selectBtn.layer.cornerRadius = 3*kScreenWidthP;
        [_selectedView addSubview:_selectBtn];
        [self bringSubviewToFront:_selectedView];
        
        
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        exitBtn.frame = CGRectMake(0, 0, 30*kScreenWidthP, 30*kScreenWidthP);
        CGFloat exitBtnCY = CGRectGetMaxY(myview.frame)+36*kScreenWidthP;
        exitBtn.center = CGPointMake(kScreenWidth/2, exitBtnCY);
        [exitBtn setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
        [exitBtn addTarget:self action:@selector(exitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:exitBtn];
        UITapGestureRecognizer *exitTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitAction:)];
        [self addGestureRecognizer:exitTap];
    }
    return self;
}
- (void)setContenDic:(NSDictionary *)contenDic{
    _detailTextView.text = [contenDic objectForKey:@"itemNotes"];
    _contenDic = contenDic;
    _linkView.dic = contenDic;
    _imageArr = [contenDic objectForKey:@"itemFileList"];
    if (_imageArr.count > 0) {
        if (_imageArr.count == 1) {
            _pageControl.hidden = YES;
        }else{
            _pageControl.hidden = NO;
            _pageControl.numberOfPages=_imageArr.count;
        }
        [_collectionView reloadData];
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.imageArr.count;
    return count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CoverViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [_imageArr objectAtIndex:indexPath.item];
    cell.dic = dic;
    return cell;
}
-(void)btn_click:(UIButton*)sender

{
    BOOL selected = !sender.selected;
    sender.selected = selected;
    if (selected) {
        _detailView.hidden = NO;
    }else{
        _detailView.hidden = YES;
    }
    [self bringSubviewToFront:_selectedView];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = _collectionView.frame.size.width;
    int page = floor(_collectionView.contentOffset.x  / pageWidth) ;
    _pageControl.currentPage=page;
    
}
- (void)tologin{
    [self.delegate tologin];
}
- (void)want:(BOOL)isLike sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure{
    NSDictionary *dic;
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSNumber *itemId = [_contenDic objectForKey:@"id"];
    if (isLike) {
        dic = @{
                @"userHobbyType":[NSNumber numberWithInt:1],
                @"hobbyType":[NSNumber numberWithInt:1],
                @"pointId":itemId,
                @"userId":uid
                };
    }else{
        dic = @{
                @"userHobbyType":[NSNumber numberWithInt:2],
                @"hobbyType":[NSNumber numberWithInt:1],
                @"pointId":itemId,
                @"userId":uid
                };
    }
    [UserStore POSTWithParams:dic URL:@"api/modify_user_hobby.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
- (void)exitBtn:(UIButton *)btn{
    [self removeFromSuperview];
}
#pragma 设置手势范围
- (void)exitAction:(UITapGestureRecognizer *)tap{
    CGPoint pp=[tap locationInView:self];
    if (pp.y < 104*kScreenWidthP||pp.y > 524*kScreenWidthP) {
        [self removeFromSuperview];
    }
}
@end










