//  DetailPageViewController.m
//  MVP
//  Created by 刘志刚 on 16/5/9.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import "DetailPageViewController.h"
#import "DetailPageCell.h"
#import "DetailPageModel.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "SingleGoodsCell.h"
#import "SingleGoodsModel.h"
#import "DetailPageCell.h"
#import "CoverView.h"
#import "FlowView.h"
#import "DetailPageLikeCell.h"
#import "DetailPageRelevantInformationCell.h"
#import "PETexttInputPanelView.h"
#import "ShareView.h"
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
#import "AppDelegate.h"
#import  <TencentOpenAPI/QQApiInterface.h>
#import "UserStore.h"
#import <MJExtension/MJExtension.h>
#import "ImageViewCell.h"
#import "DetailPageRelevantCell.h"
#import <DTCoreText/DTCoreText.h>
#import "UserInfoModel.h"
#import <MJRefresh/MJRefresh.h>
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "LoginViewController.h"
#import "MSSBrowseDefine.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define kInitialBarHeight 47.f
#define EMOJI_PANNEL_HEIGHT 180.f
static CGFloat const imageBGHeight = 258; // 背景图片的高度
@interface DetailPageViewController ()<UITableViewDataSource,UITableViewDelegate,DetailPageDelegate,SingGoodDelegate,WDMessagePannelViewDelegate,flowViewDelegate,ImageViewCellDelegate>
@property (nonatomic, strong) UITableView *detailPageTbView;
@property (nonatomic, strong) NSMutableArray *detailPageArray;
@property (nonatomic, strong) FlowView *flow;
@property (nonatomic, strong) UIButton *mineBackBtn;
@property (nonatomic, strong) UIButton *mineShareBtn;
@property (nonatomic, strong) PETexttInputPanelView *messagePanelView;

@property (nonatomic, assign) CGFloat lastContentOffSet;
@property (nonatomic, assign) ScrollDirection scrollDirection;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIImageView *imageBG;
@property (nonatomic, strong) UILabel *messageL;
@end

@implementation DetailPageViewController
@synthesize keyboardIsShown;

- (void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"商品"];
    
    self.navigationController.navigationBar.hidden = YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _commentArr = [NSMutableArray array];
    _contentArr = [NSMutableArray array];
    [self requestDta];
    [self createTableView];
}
#pragma 顶部图片
- (UIImageView *)imageBG {
    if (_imageBG == nil) {
        _imageBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholderImage"]];
        _imageBG.frame = CGRectMake(0, -imageBGHeight, kScreenWidth, imageBGHeight);
        _imageBG.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageBG;
}

#pragma mark - 给图片设置尺寸
- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage * scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaleImage;
}
#pragma 获取数据
- (void)requestDta{
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_itemId forKey:@"itemId"];
    if (uid) {
        [dic setObject:uid forKey:@"userId"];
    }
    [UserStore POSTWithParams:dic URL:@"api/queryItemDetial.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        _dic = (NSDictionary *)responseObject;
        NSNumber *itemId = [_dic objectForKey:@"id"];
        if ([NSNumber isBlankNumber:itemId]) {
            NSString *resultMessage = [_dic objectForKey:@"resultMessage"];
            self.messageL.text = resultMessage;
            _detailPageTbView.hidden = YES;
            [self.view addSubview:self.messageL];
        }else{
            _detailPageTbView.hidden = NO;
            [self.messageL removeFromSuperview];
            
            NSArray *itemFileList = [_dic objectForKey:@"itemFileList"];
            if (itemFileList.count > 0) {
                NSDictionary *itemFileListDic = [itemFileList objectAtIndex:0];
                NSString *imageUrl = [itemFileListDic objectForKey:@"fileUrl"];
                if ([NSString isBlankString:imageUrl]) {
                    _imageBG.image = [UIImage imageNamed:@"placeholderImage"];
                }else{
                    [_imageBG sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        _imageBG.image = [self originImage:image scaleToSize:CGSizeMake(kScreenWidth, imageBGHeight)];
                    }];

                }
            }
            [_flow contentDictionary:_dic];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self requestComment];
                [self createTableView];
                [_detailPageTbView reloadData];
            });
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (UILabel *)messageL{
    if (_messageL == nil) {
        _messageL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*kScreenWidthP)];
        _messageL.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 - 50*kScreenWidthP);
        _messageL.textAlignment = NSTextAlignmentCenter;
    }
    return _messageL;
}
#pragma 评论
- (void)requestComment{
    if (_commentArr.count) {
        [_commentArr removeAllObjects];
    }
    _currentPage = 1;
    NSDictionary *dic = @{
                          @"currentPage":[NSNumber numberWithInt:1],
                          @"pointId":_itemId,
                          @"commentType":[NSNumber numberWithInt:1]
                          };
    [UserStore POSTWithParams:dic URL:@"api/queryComment.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [responseObject objectForKey:@"resultList"];
        if (![NSArray isBlankArray:arr]) {
            [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:obj];
                [_commentArr addObject:commentModel];
            }];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_detailPageTbView reloadData];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)requestCommentMore{
    _currentPage +=1;
    NSDictionary *dic = @{
                          @"currentPage":[NSNumber numberWithInteger:_currentPage],
                          @"pointId":_itemId,
                          @"commentType":[NSNumber numberWithInt:1]
                          };
    [UserStore POSTWithParams:dic URL:@"api/queryComment.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [responseObject objectForKey:@"resultList"];
        
        if (![NSArray isBlankArray:arr]) {
            [arr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:obj];
                [_commentArr addObject:commentModel];
            }];
        }else{
            _detailPageTbView.mj_footer.hidden = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_detailPageTbView reloadData];
            [_detailPageTbView.mj_footer endRefreshing];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma 创建tableview
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailPageTbView = [[UITableView alloc]initWithFrame:
                             CGRectMake(0, 0, kScreenWidth, kScreenHeight-50*kScreenWidthP)
                                                        style:UITableViewStylePlain];
    self.detailPageTbView.delegate = self;
    self.detailPageTbView.dataSource = self;
    _detailPageTbView.showsVerticalScrollIndicator = NO;
    _detailPageTbView.showsHorizontalScrollIndicator = NO;
    //    _detailPageTbView.scrollsToTop = NO;
    _detailPageTbView.contentInset = UIEdgeInsetsMake(imageBGHeight, 0, 0, 0);
    [self.view addSubview:self.detailPageTbView];
    [self.detailPageTbView addSubview:self.imageBG];
    [self creatBackAndShare];
    self.detailPageTbView.tableFooterView = [[UIView alloc]init];
    
    self.flow = [[FlowView alloc]initWithFrame:CGRectMake(0, KViewHeight-50*kScreenWidthP, kScreenWidth, 50*kScreenWidthP) from:@"DetailPageViewController"];
    [self.flow contentDictionary:_dic];
    _flow.delegate = self;
    [self.view addSubview:self.flow];
    
    _messagePanelView = [[PETexttInputPanelView alloc] initWithFrame:CGRectMake(0.f, CGRectGetHeight(self.view.frame), kScreenWidth, kInitialBarHeight)];
    _messagePanelView.clipsToBounds = YES;
    _messagePanelView.delegate = self;
    [self.view addSubview:_messagePanelView];
    [self creatFooter];
    
}
#pragma 底部刷新
- (void)creatFooter{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestCommentMore)];
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    _detailPageTbView.mj_footer = footer;
}
#pragma 分享 返回
- (void)creatBackAndShare{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50*kScreenWidthP, 50*kScreenWidthP)];
    _backView.userInteractionEnabled = YES;
    _backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backView];
    
    UITapGestureRecognizer *tabBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backFirstPageVctrl)];
    [_backView addGestureRecognizer:tabBack];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(16*kScreenWidthP, 23*kScreenWidthP, 32*kScreenWidthP, 32*kScreenWidthP)];
    imageView.image = [UIImage imageNamed:@"fabbi_back"];
    [_backView addSubview:imageView];
    
    _shareView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-50*kScreenWidthP, 0, 50*kScreenWidthP, 50*kScreenWidthP)];
    _shareView.userInteractionEnabled = YES;
    _shareView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_shareView];
    
    UITapGestureRecognizer *share = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction)];
    [_shareView addGestureRecognizer:share];
    
    _mineShareBtn = [MyUtils createButtonFrame:CGRectMake(2*kScreenWidthP, 23*kScreenWidthP, 32*kScreenWidthP, 32*kScreenWidthP) title:nil titleColor:nil backgroundColor:[UIColor clearColor] target:self action:@selector(shareAction)];
    [_mineShareBtn setImage:[[UIImage imageNamed:@"fabbi_share"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _mineShareBtn.userInteractionEnabled = NO;
    [_shareView addSubview:_mineShareBtn];
}
- (void)backFirstPageVctrl{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==4) {
        UIView *commentView = [[UIView alloc]init];
        commentView.layer.borderWidth = 0.4*kScreenWidthP;
        commentView.layer.borderColor = RGBA(186, 186, 186, 0.6).CGColor;
        commentView.backgroundColor = RGBA(255, 255, 255, 1);
        UIImageView *commentImage = [[UIImageView alloc]initWithFrame:CGRectMake(28*kScreenWidthP, 18*kScreenWidthP, 18*kScreenWidthP, 17*kScreenWidthP)];
        commentImage.image = [UIImage imageNamed:@"white-minetalk"];
        commentImage.center = CGPointMake(37*kScreenWidthP, 25*kScreenWidthP);
        [commentView addSubview:commentImage];
        
        UILabel *commentL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(commentImage.frame)+8*kScreenWidthP, 17.5*kScreenWidthP, 60*kScreenWidthP, 16*kScreenWidthP)];
        commentL.center = CGPointMake(CGRectGetMaxX(commentImage.frame)+38*kScreenWidthP, 25*kScreenWidthP);
        commentL.textColor = [UIColor blackColor];
        commentL.center = CGPointMake(CGRectGetMaxX(commentImage.frame)+38*kScreenWidthP, 25*kScreenWidthP);
        commentL.font = [UIFont systemFontOfSize:14*kScreenWidthP];
        [commentView addSubview:commentL];
        commentL.text = [NSString stringWithFormat:@"%lu",(unsigned long)_commentArr.count];
        return commentView;
    }else{
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGBA(223, 223, 223, 1);
        return view;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dic) {
        if (section == 4) {
            return _commentArr.count;
        }else{
            return 1;
        }
    }else{
        return 0;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_commentArr.count > 0) {
        return 5;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 4) {
        return 50*kScreenWidthP;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            
            
            CGFloat height = [DetailPageCell getAddTextAttributedLabel:_dic];
            return height;
            
        }
            break;
        case 1:
            return 40*kScreenWidthP;
            break;
        case 2:
            return [ImageViewCell getAddTextAttributedLabel:_dic];
            break;
        case 3:
        {
            CGFloat height = [DetailPageRelevantCell getAddTextAttributedLabel:_dic];
            return height;
        }
            
            break;
        case 4:
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DetailPageCell *detailCell = [[DetailPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        detailCell.url = self.url;
        detailCell.delegate = self;
        [detailCell addTextAttributedLabel:_dic];
        return detailCell;
    }else if(indexPath.section == 1){
        DetailPageLikeCell *detailPageLikeCell = [[DetailPageLikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        detailPageLikeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [detailPageLikeCell setLikeContent:_dic];
        return detailPageLikeCell;
    }else if(indexPath.section == 2){
        ImageViewCell *imageCell = [[ImageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        imageCell.delegate = self;
        [imageCell addTextAttributedLabel:_dic];
        return imageCell;
    }else if(indexPath.section == 3){
        DetailPageRelevantCell *relevantCell = [[DetailPageRelevantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        relevantCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [relevantCell addTextAttributedLabel:_dic];
        return relevantCell;
    }else{
        static NSString *commentCellid = @"commentCellid";
        CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellid];
        if (commentCell == nil) {
            commentCell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellid];
        }
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        CommentModel *model = [_commentArr objectAtIndex:indexPath.row];
        [commentCell addTextAttributedLabel:model];
        return commentCell;
    }
}
//设置tableview分割线
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
#pragma mark-DetailPageDelegate
- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark-SingGoodDelegate
- (void)addFloatingView{
    CoverView *coverView = [[CoverView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:coverView];
}


#pragma mark - Scroll Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _lastContentOffSet = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_messagePanelView.commentTextView resignFirstResponder];
    //    section随tableview滚动
    //    CGFloat heightForHeader = 50.0;//section header的高度
    //    if (scrollView.contentOffset.y<=heightForHeader&&scrollView.contentOffset.y>=0) {
    //        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    //    } else if (scrollView.contentOffset.y>=heightForHeader) {
    //        scrollView.contentInset = UIEdgeInsetsMake(-heightForHeader, 0, 0, 0);
    //    }
    
    //    下拉时顶部图片变大,橡皮筋效果
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageBGHeight + offsetY;
    if (offsetH < 0) {
        CGRect frame = self.imageBG.frame;
        frame.size.height = imageBGHeight - offsetH;
        frame.origin.y = -imageBGHeight + offsetH;
//        frame.origin.x = offsetY/2;
//        frame.size.width = kScreenWidth - offsetY;
        self.imageBG.frame = frame;
    }
    
    if (self.lastContentOffSet > scrollView.contentOffset.y){
        _scrollDirection = ScrollDirectionDown;
        _flow.hidden = NO;
        
    }else if (self.lastContentOffSet < scrollView.contentOffset.y){
        _scrollDirection = ScrollDirectionUp;
        CGFloat scrollH = _detailPageTbView.contentSize.height;
        CGFloat scrollViewY = scrollView.contentOffset.y;
        CGFloat scrollY =  scrollView.contentOffset.y+kScreenHeight;
        //       防止底部控件在tableview回弹闪动
        if (scrollY > scrollH - 55*kScreenWidthP) {
            _flow.hidden = NO;
            _detailPageTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight- 50*kScreenWidthP);
        }else{
            if (scrollViewY < 50*kScreenWidthP) {
                _detailPageTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight- 50*kScreenWidthP);
                self.flow.hidden = NO;
            }else{
                _detailPageTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight);
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
        _detailPageTbView.frame= CGRectMake(0, 0, kScreenWidth, kScreenHeight- 50*kScreenWidthP);
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

#pragma 分享
- (void)shareAction{
    NSNumber *contentId = [_dic objectForKey:@"id"];
    if ([NSNumber isBlankNumber:contentId]) {
        NSString *resultMessage = [_dic objectForKey:@"resultMessage"];
        [self HUBshow:resultMessage];
    }else{
        [MobClick event:@"detailShare"];
        BOOL canBeShared = YES;
        ShareView *shareView = [[ShareView alloc] initWithCanBeShared:canBeShared buttonTitles:@[@"取消"] stylizeButtonIndex:(canBeShared ? 0 : -1) andDelegate:self];
        [shareView showInView:self.navigationController.view];
    }
    
}

- (void)didSelectedItem:(UIButton *)sender{
    switch (sender.tag) {
        case WDSHARE_WEIXIN:
        {
            [self sendToWeiXin:0];
            [MobClick event:@"WeiXin"];
        }
            break;
        case WDSHARE_FRIEND_CIRCLE:
        {
            [self sendToWeiXin:1];
            [MobClick event:@"WXfriends"];
        }
            break;
        case WDSHARE_SINA:
        {
            [self sendToSina];
            [MobClick event:@"Sina"];
        }
            break;
        case WDSHARE_QQ_ZONE:
        {
            [self sendeQQZone];
            [MobClick event:@"QQ"];
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
                         @"ShareMessageFrom":@"DetailPageViewController"
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
    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"AppIcon" ofType:@"png"]];
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
    webObject.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AppIcon" ofType:@"png"]];
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
#pragma 想要
- (void)want:(BOOL)isLike sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure{
    [MobClick event:@"detailWant"];
    NSDictionary *dic;
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    if (isLike) {
        dic = @{
                @"userHobbyType":[NSNumber numberWithInt:1],
                @"hobbyType":[NSNumber numberWithInt:1],
                @"pointId":_itemId,
                @"userId":uid
                };
    }else{
        dic = @{
                @"userHobbyType":[NSNumber numberWithInt:2],
                @"hobbyType":[NSNumber numberWithInt:1],
                @"pointId":_itemId,
                @"userId":uid
                };
    }
    [UserStore POSTWithParams:dic URL:@"api/modify_user_hobby.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
- (void)noContent{
    NSString *resultMessage = [_dic objectForKey:@"resultMessage"];
    [self HUBshow:resultMessage];
}
- (void)HUBshow:(NSString *)lableText{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = lableText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
- (void)tologin{
    LoginViewController *loginVctrl = [[LoginViewController alloc]init];
    self.definesPresentationContext = YES; //self is presenting view controller
    loginVctrl.view.backgroundColor = RGBA(0, 0, 0, 0);
    loginVctrl.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:loginVctrl animated:NO completion:nil];
}
- (void)toLink{
    NSLog(@"直接连接");
}
#pragma 评论
- (void)comment{
    [MobClick event:@"detailSendComment"];
    NSUInteger sectionCount = [self.detailPageTbView numberOfSections];
    if (sectionCount) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionCount-1];
        [self.detailPageTbView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    [_messagePanelView.commentTextView becomeFirstResponder];
}
- (void)sendContent:(NSString *)pText{
    UserInfoModel *model = [UserInfoModel readPerson];
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:uid forKey:@"userId"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"commentType"];
    [dic setObject:_itemId forKey:@"pointId"];
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
#pragma 图片拨离浏览方式,只能看一张
- (void)selectImageView:(UIImageView *)imageView{
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.image = imageView.image;
#endif
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    imageInfo.referenceContentMode = imageView.contentMode;
    imageInfo.referenceCornerRadius = imageView.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}
#pragma 图片浏览
- (void)selectImageView:(UIImageView *)imageView itemFileLists:(NSArray *)itemFileLists{
    [MobClick event:@"detailBrowsePictures"];
    // 加载网络图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < [itemFileLists count];i++)
    {
        //这里的tag要和imageviewcell里的设置一样
        UIImageView *imageView = [self.view viewWithTag:i + 201];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        NSDictionary *imageDic = [itemFileLists objectAtIndex:i];
        NSString *imageUrl = [imageDic objectForKey:@"fileUrl"];
        browseItem.bigImageUrl = imageUrl;// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
    }
    
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:imageView.tag - 201];
    //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"商品"];
}











@end
