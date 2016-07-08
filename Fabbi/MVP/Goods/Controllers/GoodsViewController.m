//  GoodsViewController.m
//  MVP
//  Created by 刘志刚 on 16/5/17.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import "GoodsViewController.h"
#import "CommentCell.h"
#import "MyUtils.h"
#import "RelatedProductsCell.h"
#import "CoverView.h"
#import "ShareView.h"
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
#import "AppDelegate.h"
#import  <TencentOpenAPI/QQApiInterface.h>
#import "FlowView.h"
#import "PETexttInputPanelView.h"
#import "UserStore.h"
#import <MJExtension/MJExtension.h>
#import "SpecialVoDetailModel.h"
#import "CommentModel.h"
#import "LoginViewController.h"
#import "UserInfoModel.h"
#import "Cuetom_alert.h"
#import <MJRefresh/MJRefresh.h>
#define kInitialBarHeight 47.f
#define EMOJI_PANNEL_HEIGHT 180.f
static CGFloat const imageBGHeight = 258; // 背景图片的高度
@interface GoodsViewController ()<UITableViewDelegate,UITableViewDataSource,RelatedProductsCellDelegate,ShareViewDelegate,WDMessagePannelViewDelegate,flowViewDelegate,custom_alertViewDelegate,TYAttributedLabelDelegate,CoverViewDelegate>
@property (nonatomic,strong) UITableView *goodTbView;
@property (nonatomic, strong) UIButton *mineBackBtn;
@property (nonatomic, strong) UIButton *mineShareBtn;
@property (nonatomic,strong) FlowView *flow;
@property (nonatomic, strong)PETexttInputPanelView *messagePanelView;
@property (nonatomic, assign) CGFloat lastContentOffSet;
@property (nonatomic, assign) ScrollDirection scrollDirection;
@property (nonatomic, strong) SpecialVoDetailModel *model;
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic, strong) UIImageView *imageBG;
@end

@implementation GoodsViewController
@synthesize keyboardIsShown;
- (void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"专题"];
    self.navigationController.navigationBar.hidden = YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _commentArr = [NSMutableArray array];
    _contentArr = [NSMutableArray array];
    _commentsArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self requestDta];
}


- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
#pragma 请求数据
- (void)requestDta{
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_speicalId forKey:@"speicalId"];
    if (uid) {
        [dic setObject:uid forKey:@"userId"];
    }
    [UserStore POSTWithParams:dic URL:@"api/querySpeicalDetial.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        _dic = (NSDictionary *)responseObject;
        NSArray *arr = [_dic objectForKey:@"specialCnotensList"];
        NSLog(@"count====%lu",(unsigned long)arr.count);
        [_flow Dic:_dic];
        _model = [SpecialVoDetailModel mj_objectWithKeyValues:responseObject];
        if (_model.specialCnotensList.count > 0) {
            [self headerViewContent:_model.specialLogoUrl title:_model.specialName specialNotes:_model.specialNotes];
            [_imageBG sd_setImageWithURL:[NSURL URLWithString:_model.specialLogoUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            for (NSDictionary *dic in _model.specialCnotensList) {
                [_contentArr addObject:dic];
            }
        }
        NSDictionary *condic = [_contentArr firstObject];
       NSString *html =  [condic objectForKey:@"specialImg"];
        [_detailedDescription loadHTMLString:html baseURL:nil];
        if (_contentArr.count>0) {
            [self requestComment];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_goodTbView reloadData];
            });
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma 请求评论
- (void)requestComment{
    if (_commentArr.count) {
        [_commentArr removeAllObjects];
    }
    _currentPage = 1;
    _goodTbView.mj_footer.hidden = NO;
    NSDictionary *dic = @{
                          @"currentPage":[NSNumber numberWithInt:_currentPage],
                          @"pointId":_speicalId,
                          @"commentType":[NSNumber numberWithInt:2]
                          };
    [UserStore POSTWithParams:dic URL:@"api/queryComment.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [responseObject objectForKey:@"resultList"];
        if (![NSArray isBlankArray:arr]) {
            [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = (NSDictionary *)obj;
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:dic];
                [_commentArr addObject:commentModel];
            }];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_goodTbView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma 更多评论
- (void)requestCommentMore{
   _currentPage+=1;
    NSDictionary *dic = @{
                          @"currentPage":[NSNumber numberWithInt:_currentPage],
                          @"pointId":_speicalId,
                          @"commentType":[NSNumber numberWithInt:2]
                          };
    [UserStore POSTWithParams:dic URL:@"api/queryComment.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [responseObject objectForKey:@"resultList"];
        if (![NSArray isBlankArray:arr]) {
            [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = (NSDictionary *)obj;
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:dic];
                [_commentArr addObject:commentModel];
            }];
        }else{
           _goodTbView.mj_footer.hidden = YES;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_goodTbView reloadData];
            [_goodTbView.mj_footer endRefreshing];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma 创建tableview,flow,messagePanelView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.goodTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50*kScreenWidthP) style:UITableViewStylePlain];
    self.goodTbView.delegate = self;
    self.goodTbView.dataSource = self;
    _goodTbView.scrollsToTop = NO;
   [self.view addSubview:self.goodTbView];
    _goodTbView.contentInset = UIEdgeInsetsMake(imageBGHeight, 0, 0, 0);
    [self.goodTbView addSubview:self.imageBG];
    _goodTbView.tableHeaderView = [self createTableHeaderView];
    _goodTbView.tableFooterView = [[UIView alloc]init];
    [self creatBackAndShare];
    self.flow = [[FlowView alloc]initWithFrame:CGRectMake(0, KViewHeight-50*kScreenWidthP, kScreenWidth, 50*kScreenWidthP) from:@"GoodsViewController"];

    _flow.delegate = self;
    [self.view addSubview:self.flow];
    _messagePanelView = [[PETexttInputPanelView alloc] initWithFrame:CGRectMake(0.f, CGRectGetHeight(self.view.frame), kScreenWidth, kInitialBarHeight)];
    _messagePanelView.clipsToBounds = YES;
    _messagePanelView.delegate = self;
    [self.view addSubview:_messagePanelView];
    [self creatFooter];
}
- (UIImageView *)imageBG {
    if (_imageBG == nil) {
        _imageBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholderImage"]];
        _imageBG.frame = CGRectMake(0, -imageBGHeight, kScreenWidth, imageBGHeight);
        _imageBG.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageBG;
}
#pragma 底部刷新
- (void)creatFooter{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestCommentMore)];
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    _goodTbView.mj_footer = footer;
}
#pragma 返回及分享控件
- (void)creatBackAndShare{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50*kScreenWidthP, 50*kScreenWidthP)];
    backView.userInteractionEnabled = YES;
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    UITapGestureRecognizer *tabBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backFirstPageVctrl)];
    [backView addGestureRecognizer:tabBack];
    _mineBackBtn = [MyUtils createButtonFrame:CGRectMake(16*kScreenWidthP, 23*kScreenWidthP, 32*kScreenWidthP, 32*kScreenWidthP) title:nil titleColor:nil backgroundColor:[UIColor clearColor] target:self action:@selector(backFirstPageVctrl)];
    [_mineBackBtn setImage:[[UIImage imageNamed:@"fabbi_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _mineBackBtn.userInteractionEnabled = NO;
    [backView addSubview:_mineBackBtn];
    
    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-50*kScreenWidthP, 0, 50*kScreenWidthP, 50*kScreenWidthP)];
    shareView.userInteractionEnabled = YES;
    shareView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shareView];
    UITapGestureRecognizer *share = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction)];
    [shareView addGestureRecognizer:share];
    _mineShareBtn = [MyUtils createButtonFrame:CGRectMake(2*kScreenWidthP, 23*kScreenWidthP, 32*kScreenWidthP, 32*kScreenWidthP) title:nil titleColor:nil backgroundColor:[UIColor clearColor] target:self action:@selector(shareAction)];
    [_mineShareBtn setImage:[[UIImage imageNamed:@"fabbi_share"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _mineShareBtn.userInteractionEnabled = NO;
    [shareView addSubview:_mineShareBtn];
}
- (UIView *)createTableHeaderView{
    CGFloat bgViewH = 258*kScreenWidthP;
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 53*kScreenWidthP)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 258*kScreenWidthP)];
//    [bgView addSubview:_coverImageView];
    bgViewH += 20*kScreenWidthP;
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(20*kScreenWidthP, 20*kScreenWidthP, kScreenWidth-40*kScreenWidthP, 28*kScreenWidthP)];
    _titleL.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    _titleL.textColor = RGBA(34, 34, 34, 1);
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleL];
    _IntroductionL = [[TYAttributedLabel alloc]init];
    _IntroductionL.linesSpacing = 1.4*kScreenWidthP;
    _IntroductionL.textAlignment = NSTextAlignmentJustified;
    _IntroductionL.characterSpacing = 0.5*kScreenWidthP;
    _IntroductionL.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_IntroductionL];
    return _bgView;
}
- (void)headerViewContent:(NSString *)coverImageUrl title:(NSString *)title specialNotes:(NSString *)specialNotes{
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:coverImageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    _IntroductionL.text = specialNotes;
    _titleL.text = title;
    [_IntroductionL setFrameWithOrign:CGPointMake(20*kScreenWidthP, CGRectGetMaxY(_titleL.frame)+20*kScreenWidthP) Width:kScreenWidth-40*kScreenWidthP];
    CGSize size = [_IntroductionL getSizeWithWidth:kScreenWidth-40*kScreenWidthP];
    CGFloat bgH = size.height + 73*kScreenWidthP;
    _bgView.frame = CGRectMake(0, 0, kScreenWidth, bgH);
    _goodTbView.tableHeaderView = nil;
    _goodTbView.tableHeaderView = _bgView;
}

#pragma mark-UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     if (section==1){
        UIView *commentView = [[UIView alloc]init];
         commentView.layer.borderWidth = 0.4*kScreenWidthP;
         commentView.layer.borderColor = RGBA(186, 186, 186, 0.6).CGColor;
         commentView.backgroundColor = RGBA(255, 255, 255, 1);
        UIImageView *commentImage = [[UIImageView alloc]initWithFrame:CGRectMake(28*kScreenWidthP, 18*kScreenWidthP, 18*kScreenWidthP, 17*kScreenWidthP)];
        commentImage.image = [UIImage imageNamed:@"white-minetalk"];
         commentImage.center = CGPointMake(37*kScreenWidthP, 26*kScreenWidthP);
        [commentView addSubview:commentImage];
         
        UILabel *commentL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(commentImage.frame)+8*kScreenWidthP, 17.5*kScreenWidthP, 60*kScreenWidthP, 14*kScreenWidthP)];
         commentL.center = CGPointMake(CGRectGetMaxX(commentImage.frame)+38*kScreenWidthP, 25*kScreenWidthP);
        commentL.textColor = [UIColor blackColor];
         commentL.font = [UIFont fontWithName:@"SFUIDisplay-Light" size:14*kScreenWidthP];
        commentL.font = [UIFont systemFontOfSize:14*kScreenWidthP];
        [commentView addSubview:commentL];
        commentL.text = [NSString stringWithFormat:@"%lu",(unsigned long)_commentArr.count];
        return commentView;
    }else{
        UIView *view = [[UIView alloc]init];
        return view;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
                return _contentArr.count;
            break;
        case 1:
         return _commentArr.count;
            break;
        default:
            return 0;
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

// section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if(section==1){
        return 50*kScreenWidthP;
    }else{
       return 50*kScreenWidthP;
    }
    
}
// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
            
        case 0:
        {
            NSDictionary *dic = [_contentArr objectAtIndex:indexPath.row];
            CGFloat height = [RelatedProductsCell getCellHeight:dic];
            return height;
        }

         break;
        case 1:
        {
            CommentModel *model = [_commentArr objectAtIndex:indexPath.row];
            return  [CommentCell getAddTextAttributedLabel:model];
        }
            
            break;
        default:
            return 0;
            break;
    }
}
- (void)webViews{
    _detailedDescription = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _detailedDescription.delegate = self;
    [self.view addSubview:_detailedDescription];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    if (indexPath.section == 0) {
        static NSString *RelatedProductsCellid = @"RelatedProductsCell";
        RelatedProductsCell *tabCell = [tableView dequeueReusableCellWithIdentifier:RelatedProductsCellid];
        if (tabCell == nil) {
            tabCell = [[RelatedProductsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        NSDictionary *dic = [_contentArr objectAtIndex:indexPath.row];
        tabCell.delegate = self;
        tabCell.contentDictionary = dic;
//        [tabCell contentDic:dic];
        tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return tabCell;
    } else {
            static NSString *tabCellID = @"tabCellID";
            CommentCell *tabCell = [tableView dequeueReusableCellWithIdentifier:tabCellID];
            if (tabCell == nil) {
                tabCell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            }
            tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
            CommentModel *model = [_commentArr objectAtIndex:indexPath.row];
            [tabCell addTextAttributedLabel:model];
        return tabCell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}















#pragma mark-SingGoodDelegate
- (void)addFloatingView:(NSDictionary*)dic{
    [MobClick event:@"projectLookItem"];
     [_messagePanelView.commentTextView resignFirstResponder];
    CoverView *coverView = [[CoverView alloc]initWithFrame:self.view.bounds];
    coverView.delegate = self;
    coverView.contenDic = dic;
    [self.view addSubview:coverView];
}
#pragma mark-GoodIamgeDelegate
- (void)backFirstPageVctrl{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"专题"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
}
#pragma 分享
- (void)shareAction{
    [MobClick event:@"projectShare"];
    BOOL canBeShared = YES;
    ShareView *shareView = [[ShareView alloc] initWithCanBeShared:canBeShared buttonTitles:@[@"取消"] stylizeButtonIndex:(canBeShared ? 0 : -1) andDelegate:self];
    [shareView showInView:self.navigationController.view];
}
- (void)didSelectedItem:(UIButton *)sender{
    switch (sender.tag) {
        case WDSHARE_WEIXIN:
        {
            [self sendToWeiXin:0];
        }
            break;
        case WDSHARE_FRIEND_CIRCLE:
        {
            [self sendToWeiXin:1];
        }
            break;
        case WDSHARE_SINA:
        {
            [self sendToSina];
        }
            break;
        case WDSHARE_QQ_ZONE:
        {
            [self sendeQQZone];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 分享到微信
- (void)sendToWeiXin:(NSInteger)pScene{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = @"fabbi";
    req.scene = (int)pScene;
    
    [WXApi sendReq:req];
}

#pragma mark - 转发到微博
- (void)sendToSina{
    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    WBAuthorizeRequest *weiboRequest = [WBAuthorizeRequest request];
    weiboRequest.redirectURI = KWeiBoOAuthUrl;
    weiboRequest.scope = @"all";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:weiboRequest access_token:myAppDelegate.WBtoken];
    request.userInfo = @{
                         @"ShareMessageFrom":@"GoodsViewController"
                         };
    [WeiboSDK sendRequest:request];

}

//消息中图片内容和多媒体内容不能共存
- (WBMessageObject *)messageToShare{
    //    文字内容
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"test微博weiboSDK发送文字到微博", nil);
    //    图片内容
    WBImageObject *image = [WBImageObject object];
    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"123" ofType:@"png"]];
    //   message.imageObject = image;
    //    多媒体内容
    WBWebpageObject *webObject = [WBWebpageObject object];
    //    对象唯一ID，用于唯一标识一个多媒体内容
    webObject.objectID = @"wodeid";
    //     多媒体内容标题
    webObject.title = NSLocalizedString(@"分享网页标题", nil);
    //     多媒体内容描述
    webObject.description = [NSString stringWithFormat:NSLocalizedString(@"分享内容简介-%.0f", nil),[[NSDate date]timeIntervalSince1970]];
    //     多媒体内容缩略图
    webObject.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"123" ofType:@"png"]];
    //    网页的url地址
    webObject.webpageUrl = @"http://weibo.com/u/5603345060";
    message.mediaObject = webObject;
    return message;
}

#pragma mark - 分享到QQ空间
- (void)sendeQQZone{
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:@"QQ互联测试"];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    //将内容分享到qq
     [QQApiInterface sendReq:req];
}
#pragma mark - Scroll Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _lastContentOffSet = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    section随tableview滚动
    CGFloat heightForHeader = 50.0;//section header的高度
    if (scrollView.contentOffset.y<=heightForHeader&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=heightForHeader) {
        scrollView.contentInset = UIEdgeInsetsMake(-heightForHeader, 0, 0, 0);
    }
//    顶部图片橡皮筋效果
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageBGHeight + offsetY;
    if (offsetH < 0) {
        CGRect frame = self.imageBG.frame;
        frame.size.height = imageBGHeight - offsetH;
        frame.origin.y = -imageBGHeight + offsetH;
        self.imageBG.frame = frame;
    }
    
    if (self.lastContentOffSet > scrollView.contentOffset.y){
        _scrollDirection = ScrollDirectionDown;
        _goodTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight-50*kScreenWidthP);
        self.flow.hidden = NO;
        
    }else if (self.lastContentOffSet < scrollView.contentOffset.y){
        
        _scrollDirection = ScrollDirectionUp;
        CGFloat scrollViewY = scrollView.contentOffset.y;
        CGFloat scrollH = _goodTbView.contentSize.height;
        CGFloat scrollY =  scrollViewY+kScreenHeight;
        if (scrollY > scrollH - 55*kScreenWidthP) {
            _flow.hidden = NO;
            _goodTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight- 50*kScreenWidthP);
        }else{
            if (scrollViewY < 50*kScreenWidthP) {
                _goodTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight- 50*kScreenWidthP);
                self.flow.hidden = NO;
            }else{
                _goodTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                self.flow.hidden = YES;
            }
            
        }
    }else{
        _scrollDirection = ScrollDirectionNone;
    }
    
    self.lastContentOffSet = scrollView.contentOffset.y;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_scrollDirection == ScrollDirectionUp) {
        _flow.hidden = NO;
        _goodTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight- 50*kScreenWidthP);
    }
    
}
#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma flowdelegate
#pragma 登陆
- (void)tologin{
    LoginViewController *loginVctrl = [[LoginViewController alloc]init];
    self.definesPresentationContext = YES; //self is presenting view controller
    loginVctrl.view.backgroundColor = RGBA(0, 0, 0, 0);
    loginVctrl.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:loginVctrl animated:NO completion:nil];
    
}

#pragma 收藏


- (void)want:(BOOL)isLike sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure{
    [MobClick event:@"projectCollection"];
    NSDictionary *dic;
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    if (isLike) {
        dic = @{
                @"userHobbyType":[NSNumber numberWithInt:1],
                @"hobbyType":[NSNumber numberWithInt:2],
                @"pointId":_speicalId,
                @"userId":uid
                };
    }else{
        dic = @{
                    @"userHobbyType":[NSNumber numberWithInt:2],
                    @"hobbyType":[NSNumber numberWithInt:2],
                    @"pointId":_speicalId,
                    @"userId":uid
                };
    }
    [UserStore POSTWithParams:dic URL:@"api/modify_user_hobby.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
   
}
- (void)toLink{
    NSLog(@"直接连接");
}
- (void)comment{
    [MobClick event:@"projectComment"];
    [_messagePanelView.commentTextView becomeFirstResponder];
    NSInteger row;
    NSInteger section;
    if (_contentArr.count >0) {
        if (_commentArr.count > 0) {
            row = _commentArr.count -1;
            section = 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [self.goodTbView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }else{
            [self.goodTbView scrollToRowAtIndexPath:
             [NSIndexPath indexPathForRow:[self.contentArr count]-1 inSection:0]
                                      atScrollPosition: UITableViewScrollPositionBottom
                                              animated:NO];
        }
    }
    
   
}

#pragma messageview delegate
- (void)sendContent:(NSString *)pText{
   UserInfoModel *model = [UserInfoModel readPerson];
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:uid forKey:@"userId"];
    [dic setObject:[NSNumber numberWithInt:2] forKey:@"commentType"];
    [dic setObject:_speicalId forKey:@"pointId"];
    if (model.userTel) {
        [dic setObject:model.userTel forKey:@"userTel"];
    }
    if (model.userName) {
        [dic setObject:model.userName forKey:@"userName"];
    }
    [dic setObject:pText forKey:@"commentContens"];
    [UserStore POSTWithParams:dic URL:@"api/insertComment.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *resultCode =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"resultCode"]];
        if ([resultCode isEqualToString:@"200"]) {
            [self requestComment];
        }else{
            
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
  
}
#pragma mark - Keyboard Helpers
#pragma 面板消失
- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    CGRect viewFrame = _messagePanelView.frame;
    
    viewFrame.origin.y = kScreenHeight;
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    double animationDuration = 0.0;
    [animationDurationObject getValue:&animationDuration];
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [_messagePanelView setFrame:viewFrame];
        
    }];
    _currentKeyboardSize = CGSizeZero;
    keyboardIsShown = NO;
    
}
#pragma 面板出现
- (void)keyboardWillShow:(NSNotification *)n{
    if (keyboardIsShown) {
        return;
    }
    NSDictionary* info = [n userInfo];
    // get the size of the keyboard
    CGSize keyboardSize = [[info objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size;
    _currentKeyboardSize = keyboardSize;
    // resize the noteView
    CGRect viewFrame = _messagePanelView.frame;
    CGFloat gap;
    if (_messagePanelView.textContentHeight > kMinorHeight) {
        gap = _messagePanelView.textContentHeight - kMinorHeight+kInitialBarHeight;
    }else{
        gap = kInitialBarHeight;
    }
    
    viewFrame.origin.y = kScreenHeight -  gap - keyboardSize.height;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    
    UIViewAnimationOptions options = animationCurve << 16;
    [UIView animateWithDuration:animationDuration delay:0.0f options:options
                     animations:^{
                         [_messagePanelView setFrame:viewFrame];
                     }completion:nil
     ];
    keyboardIsShown = YES;
}
#pragma 面板的frame将要改变
- (void)keyboardWillChangeFrame:(NSNotification *)n{
    
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _currentKeyboardSize = keyboardSize;
    CGRect viewFrame = _messagePanelView.frame;
    CGFloat gap;
    if (_messagePanelView.textContentHeight > kMinorHeight) {
        gap = _messagePanelView.textContentHeight - kMinorHeight+kInitialBarHeight;
    }else{
        gap = kInitialBarHeight;
    }
    
    viewFrame.origin.y = kScreenHeight -  gap - keyboardSize.height;
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    double animationDuration = 0.0;
    [animationDurationObject getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        [_messagePanelView setFrame:viewFrame];
        
    }];
    
}
#pragma mark -- 改变输入面板高度

#pragma mark - input panel frame

- (void)updateFrameWithContentHeight:(CGFloat)pHeight{
    CGFloat gap = pHeight - kMinorHeight;
    CGFloat axisY = 0;
    if (keyboardIsShown) {
        axisY = CGRectGetHeight(self.view.frame) - kInitialBarHeight - gap - _currentKeyboardSize.height;
    }else{
        axisY = CGRectGetHeight(self.view.frame) - kInitialBarHeight - gap - EMOJI_PANNEL_HEIGHT;
    }
    [UIView animateWithDuration:.2f animations:^{
        _messagePanelView.frame = CGRectMake(0.f, axisY, CGRectGetWidth(self.view.bounds), 387.f);
    } completion:^(BOOL finished) {
        //
    }];
}
#pragma 重新设置输入框的frame
- (void)resetPanelFrame{
    CGRect viewFrame = _messagePanelView.frame;
    CGFloat gap = _messagePanelView.textContentHeight - kMinorHeight;
    viewFrame.origin.y = CGRectGetHeight(self.view.frame) - kInitialBarHeight - gap;
    [UIView animateWithDuration:.2f animations:^{
        _messagePanelView.frame = viewFrame;
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_messagePanelView.commentTextView resignFirstResponder];
}

@end
