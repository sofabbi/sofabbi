//
//  GoodImageView.m
//  MVP
//
//  Created by 刘志刚 on 16/5/17.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "GoodImageView.h"
#import "UIImageView+WebCache.h"
#import "MyUtils.h"
@implementation GoodImageView
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imgArr{
    if (self = [super initWithFrame:frame]) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds ];
        self.scrollView.contentSize = CGSizeMake(imgArr.count*self.bounds.size.width,self.bounds.size.height);
        //允许分页
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = YES;
        //添加图片
        for (NSInteger i = 0; i < imgArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            _pageNumber = (int)imgArr.count;
            imageView.frame = CGRectMake(frame.size.width*i, 0, frame.size.width,frame.size.height);
            
            NSString *imageName = [NSString stringWithFormat:@"%@",imgArr[i]];
            [imageView  sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            imageView.image = [UIImage imageNamed:imageName];
            [self.scrollView addSubview:imageView];
        }
        [self addSubview:self.scrollView];
        
        
        self.backBtn = [MyUtils createButtonFrame:CGRectMake(20*kScreenWidthP, 40*kScreenWidthP, 40*kScreenWidthP, 40*kScreenWidthP) title:nil titleColor:nil backgroundColor:[UIColor clearColor] target:self action:@selector(back:)];
        [self.backBtn setImage:[[UIImage imageNamed:@"Back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self addSubview:self.backBtn];
        
        // 分页视图
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50*kScreenWidthP, 300*kScreenWidthP, 100*kScreenWidthP, 40*kScreenWidthP)];
        _pageControl.numberOfPages = imgArr.count;
        // 设置正常显示的颜色
        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
        // 设置当前颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        [self addSubview:_pageControl];
        
    }
    return self;
}
// 退出
- (void)back:(UIButton *)btn{
    [self.delegate backFirstPageVctrl];
    
}
-(void)removeTimer{
    [_timer invalidate];
}

-(void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(netxPage) userInfo:nil repeats:YES];
    // 加入当前的运行循环中
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)netxPage{
    int page = (int)self.pageControl.currentPage;
    if (page == _pageNumber-1) {
        page = 0;
    }else{
        page++;
    }
    //滚动scrollview
    CGFloat x = page*self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}
#pragma mark - UIScrollViewDelegate
//滑动时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    self.pageControl.currentPage = page;
}
//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
//结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)dealloc{
    [self removeTimer];
}



@end
