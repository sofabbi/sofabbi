
//  MineViewController.m
//  MVP
//  Created by 刘志刚 on 16/4/19.
//  Copyright © 2016年 刘志刚. All rights reserved.

#import "MineViewController.h"
#import "SetUpViewController.h"
#import "MyUtils.h"
#import "RegLoginScrollow.h"
#import "Regist&LoginVC.h"
#import "BindPhoneViewController.h"
#import "ForgetWordViewController.h"
#import "WXApi.h"
#import "FirstPageViewController.h"
#import "DetailPageViewController.h"
#import "GoodsViewController.h"
#import "MineButton.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "MineWantCell.h"
#import "MineCollectionCell.h"
#import "MineCommentCell.h"
#import "MineCommentModel.h"
#import "UserStore.h"
#import "UserInfoModel.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MineCollectionModel.h"
#import <AFNetworking/AFNetworking.h>
#import "DetailPageViewController.h"
#import "GoodsViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "NSDate+Time.h"
typedef NS_ENUM(NSUInteger, MineButtonSelected) {
    MineButtonSelectedWant,
    MineButtonSelectedCollection,
    MineButtonSelectedComment
};
@interface MineViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,ExitRegLoginDelegate,ForgetPasswordDelegate,WeChatLoginDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,mineWantCellDelegate,mineCollectionCellDelegate,mineCommentCellDelegate>
@property (nonatomic,strong) UIButton *nickNameBtn;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UIImageView *myPhoto;
@property (nonatomic,strong) UITextField *nickTextField;
@property (nonatomic,strong) RegLoginScrollow *regLogScrollow;
@property (nonatomic,strong) UIScrollView *selfScrollView;
@property (nonatomic,strong) UITableView *mineTbView;
@property (nonatomic,strong) UIView *mineView;
@property (nonnull,strong)  UILabel *labelA;
@property (nonnull,strong)  UILabel *lineLabel;
// 创建下面的我的收藏，我的评论，我想要的
@property (nonatomic,strong) MineButton *myCollectionBtn;
@property (nonatomic,strong) MineButton *myCommentBtn;
@property (nonatomic,strong) MineButton *myWantBtn;
// 下面是标题评论，想要，收藏的array
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSMutableArray *vcArray;
@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic, assign)   MineButtonSelected mineButtonSelected;
@property (nonatomic, strong) UIView *noContentView;
@property (nonatomic, strong) UILabel *noContentL;
@property (nonatomic, strong) UIButton *nocontentB;
@property (nonatomic, strong) UserInfoModel *userInfoModel;
@end

@implementation MineViewController{
    UIButton *_mineBackBtn;
    UIButton *_setUpBtn;
    UIView *backView;
    UIView *setView;
}

- (void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"个人中心"];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    _wantArr = [NSMutableArray array];
    _collectionArr = [NSMutableArray array];
    _commentArr = [NSMutableArray array];
    [self createTbView];
    [self prepareData];
    [self createView];
    self.view.backgroundColor = [UIColor whiteColor];
    _mineButtonSelected = MineButtonSelectedWant;
    [self requestFirst];
    // 当点击微信登陆，微信登陆成功发送post，此为监听微信的post（通知中心，微信登陆view上发送的，这里为接收）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatLogin) name:@"wechatLogin" object:nil];

}

- (void)mineBackBtn:(id)sender{
 
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma 进入设置
- (void)setUpBtn:(id)sender{
    SetUpViewController *setupVctrl = [[SetUpViewController alloc]init];
//    CATransition* transition = [CATransition animation];
//    transition.type = kCATransitionPush;//可更改为其他方式
//    transition.subtype = kCATransitionFromRight;//可更改为其他方式
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController :setupVctrl animated:YES];
}

/**
 创建“我的”页面视图
 */
#pragma 头像,用户名
- (void)createView{
 
    // 个人私照
    self.myPhoto = [MyUtils createImageViewFrame:CGRectMake(145*kScreenWidthP, 64*kScreenWidthP, 85*kScreenWidthP, 85*kScreenWidthP) imageName:@"placeholderImage" cornerRadius:85/2*kScreenWidthP clipsToBounds:YES userInteractionEnabled:YES];
   
    [self.mineView addSubview:self.myPhoto];
    // 昵称
    self.nickTextField = [MyUtils createTextFieldFrame:CGRectMake(kScreenWidth/2-60*kScreenWidthP, CGRectGetMaxY(self.myPhoto.frame)+14*kScreenWidthP, 120*kScreenWidthP, 22*kScreenWidthP) borderStyle:UITextBorderStyleNone font:16*kScreenWidthP textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    self.nickTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16*kScreenWidthP];
    _nickTextField.returnKeyType = UIReturnKeyDone;
    self.nickTextField.adjustsFontSizeToFitWidth = YES;
    self.nickTextField.textAlignment = NSTextAlignmentCenter;
    self.nickTextField.delegate = self;
    [self.mineView addSubview:self.nickTextField];
    //返回按钮
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100*kScreenWidthP, 100*kScreenWidthP)];
    backView.userInteractionEnabled = YES;
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    UITapGestureRecognizer *tabBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mineBackBtn:)];
    [backView addGestureRecognizer:tabBack];
    _mineBackBtn = [MyUtils createButtonFrame:CGRectMake(18*kScreenWidthP, 31*kScreenWidthP, 11*kScreenWidthP, 22*kScreenWidthP) title:nil titleColor:nil backgroundColor:[UIColor clearColor] target:self action:@selector(mineBackBtn:)];
    [_mineBackBtn setImage:[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _mineBackBtn.userInteractionEnabled = NO;
    [backView addSubview:_mineBackBtn];
    
    setView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 100*kScreenWidthP, 0, 100*kScreenWidthP, 100*kScreenWidthP)];
    setView.userInteractionEnabled = YES;
    [self.view addSubview:setView];
    UITapGestureRecognizer *setTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setUpBtn:)];
    [setView addGestureRecognizer:setTap];
    
    _setUpBtn = [MyUtils createButtonFrame:CGRectMake(60*kScreenWidthP, 32*kScreenWidthP, 20, 20) title:nil titleColor:nil backgroundColor:[UIColor whiteColor] target:self action:@selector(setUpBtn:)];
    [_setUpBtn setImage:[[UIImage imageNamed:@"set-up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _setUpBtn.userInteractionEnabled = NO;
    [setView addSubview:_setUpBtn];
    
    // 把微信里面照片传递过来，赋给我的头像
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSString *imageStr = [usr objectForKey:@"zhigangImage"];
    // 在没有请求出数据的时候，显示上面的，否则，显示下面的
    
    if ([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]]) {
         self.myPhoto.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]];
         self.nickTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"wechatName"];
        
    }else{
        NSURL *url = [NSURL URLWithString:_userInfoModel.userLogo];
        [self.myPhoto sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        self.nickTextField.text = _userInfoModel.userTel;
    }
  
    // 加个点击事件
    UITapGestureRecognizer *myPhotoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showActionSheetForChangingAvatar)];
    [self.myPhoto addGestureRecognizer:myPhotoTap];

    // 修改昵称button
    self.nickNameBtn = [MyUtils createButtonFrame:CGRectMake(kScreenWidth/2-75*kScreenWidthP+150*kScreenWidthP, 215*kScreenWidthP, 20*kScreenWidthP, 20*kScreenWidthP) title:nil selectTitle:nil titleColor:nil bgImageName:@"Signature" selectImageName:@"Signature" backgroundColor:[UIColor whiteColor] layerCornerRadius:0.f target:self action:@selector(nickNameBtn:)];
    [self.mineView addSubview:self.nickNameBtn];
    
    // 此为注册登录的弹出页
    self.regLogScrollow = [[RegLoginScrollow alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.regLogScrollow.exitdelegate = self;
    self.regLogScrollow.forgetPasswordDelegate = self;
    self.regLogScrollow.weChatLoginDelegate = self;
    [self.view addSubview:self.regLogScrollow];
}
#pragma 获取用户信息数据
- (void)prepareData{
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSDictionary *dic = @{
                          @"userId":uid
                          };
    [UserStore POSTWithParams:dic URL:@"api/queryUserDetail.html" success:^(NSURLSessionDataTask *task, id responseObject) {
         _userInfoModel = [UserInfoModel mj_objectWithKeyValues:responseObject];
        [UserInfoModel savePerson:_userInfoModel];
        _userLogo = _userInfoModel.userLogo;
        NSURL *url = [NSURL URLWithString:_userLogo];
        [self.myPhoto sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Avatar_default"]];
        self.nickTextField.text = _userInfoModel.userName;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mineTbView reloadData];
        });
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
//    http://114.55.43.106/api/queryUserHobby.html
    self.titleArray = @[@"收藏的专题",@"我的评论",@"想要的装备"];
    self.vcArray = [NSMutableArray array];
}
#pragma 创建tableview
- (void)createTbView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mineTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20*kScreenWidthP, kScreenWidth, kScreenHeight-20*kScreenWidthP) style:UITableViewStylePlain];
    self.mineTbView.delegate = self;
    self.mineTbView.dataSource = self;
    _mineTbView.separatorStyle = NO;
    self.mineView = [MyUtils createViewFrame:CGRectMake(0, 0, kScreenWidth, 210*kScreenWidthP) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mineView];
    self.mineTbView.tableHeaderView = _mineView;
    [self.view addSubview:self.mineTbView];
    _mineTbView.tableFooterView = [[UIView alloc]init];
    [self creatFooter];
    
}
#pragma 底部刷新
- (void)creatFooter{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestCommentMore)];
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    _mineTbView.mj_footer = footer;
    _mineTbView.mj_footer.hidden = YES;
}
#pragma mark - 修改头像
- (void)showActionSheetForChangingAvatar{
    [MobClick event:@"ModifyUserHeadImage"];
    UIAlertController *c=[[UIAlertController alloc]init];
    [c addAction:[UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self takePhoto];
        
    }]];
    [c addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self retriveingPhotoFromLibrary];
    }]];
    [c addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [c.view setTintColor:RGBA(67, 181, 223, 1)];
    [self presentViewController:c animated:YES completion:nil];
    
    
}
- (void)takePhoto{
    
    if ([self isCameraAvailable] &&
        [self doesCameraSupportTakingPhotos]){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.allowsEditing = YES;
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSString *requiredMediaType = (NSString *)kUTTypeImage;
        controller.mediaTypes = [[NSArray alloc]
                                 initWithObjects:requiredMediaType, nil];
        controller.allowsEditing = YES;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"Camera is not available.");
    }
}
- (void)retriveingPhotoFromLibrary{
    if ([self isPhotoLibraryAvailable]){ UIImagePickerController *controller =
        [[UIImagePickerController alloc] init];
        controller.allowsEditing = YES;
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        if ([self canUserPickPhotosFromPhotoLibrary]){
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        }
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - Device ability

- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) doesCameraSupportTakingPhotos{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){ NSLog(@"Media type is empty."); return NO;
    }
    NSArray *availableMediaTypes =
    [UIImagePickerController
     availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         NSString *mediaType = (NSString *)obj;
         if ([mediaType isEqualToString:paramMediaType]){
             result = YES;
             *stop= YES; }
     }];
    return result;
}


/**
 从相册获取照片
 */
- (void)myPhotoTap:(id)sender{
    // 如果已经登陆了，那么可以选取照片
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"state"] integerValue] ==1) {
        UIImagePickerController *ctrl = [[UIImagePickerController alloc]init];
        ctrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ctrl.delegate = self;
        //模态风格转换
        ctrl.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        // 可以编辑
        ctrl.allowsEditing = YES;
        [self presentViewController:ctrl animated:YES completion:nil];
    }else{
//        Regist_LoginVC *reLogVctrl = [[Regist_LoginVC alloc]init];
    // 用一个nav去包装VC，达到下个页面（也即是登录页）能push的效果；这样相当于加载了一个新的nav；这种情况，Regist_LoginVC对应的VC的view 是不能设置透明的
//     [self presentViewController:[[UINavigationController alloc] initWithRootViewController: reLogVctrl] animated:YES completion:nil];
     self.navigationController.navigationBar.hidden = YES;
     [UIView animateWithDuration:0.3 animations:^{
      
         // 平移
         CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , -kScreenHeight);
         
         self.regLogScrollow .transform = translateForm;
     }];
    }
}
#pragma mark - UIImagePickerController代理
//点击取消按钮调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//选中一张图片的时候调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString     *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        UIImage *aImage;
        if (info[UIImagePickerControllerEditedImage]) {
            aImage = info[UIImagePickerControllerEditedImage];
        }else{
            aImage = info[UIImagePickerControllerOriginalImage];
        }
        NSData *imageData = UIImageJPEGRepresentation(aImage, 0.1);
        
        if (imageData) {
            [self method4:imageData];
        }
       
        self.myPhoto.image = aImage;
    }

        [picker dismissViewControllerAnimated:YES completion:nil];
}
//系统原生未封装请求方法
#pragma 上传头像
-(void)method4:(NSData *)data{
    NSNumber *userid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSString *uid = [NSString stringWithFormat:@"http://114.55.43.106/api/upload.html?userId=%@",userid];
    NSURL *uploadURL = [NSURL URLWithString:uid];
    //文件路径处理(随意)
    NSLog(@"请求路径为%@",uploadURL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
        //body
        NSData *body = [self prepareDataForUpload:data];
        //request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:uploadURL];
        [request setHTTPMethod:@"POST"];
        
        // 以下2行是关键，NSURLSessionUploadTask不会自动添加Content-Type头
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", @"----------V2ymHFg03ehbqgZCaKO6jy"];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
            
            NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [self dictionaryWithJsonString:message];
            NSLog(@"message: %@", message);
            if (dic) {
                _userLogo = [dic objectForKey:@"userLogo"];
            }
            [session invalidateAndCancel];
        }];
        
        [uploadTask resume];
    });
}
//生成bodyData
-(NSData*) prepareDataForUpload:(NSData *)fileData
{
    NSMutableData *body = [NSMutableData data];
    if (fileData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", @"----------V2ymHFg03ehbqgZCaKO6jy"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"fileName", @"lastPathfileName.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: multipart/form-data\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:fileData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", @"----------V2ymHFg03ehbqgZCaKO6jy"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return body;
}
#pragma json字符串转json
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

#pragma 修改用户名
- (void)request:(NSString *)url dic:(NSDictionary *)dic{
    [MobClick event:@"ModifyUserName"];
    [UserStore POSTWithParams:dic URL:url success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}



/**
 修改昵称
 */
- (void)nickNameBtn:(id)sender{
    self.nickTextField.allowsEditingTextAttributes = YES;
    [self.nickTextField becomeFirstResponder];
}
/**
 点击return时候隐藏键盘
 */
#pragma UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self modifyComplete];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.nickTextField resignFirstResponder];
}

- (void)modifyComplete{
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:uid forKey:@"userId"];
    if (_nickTextField.text.length > 0) {
        [dic setObject:_nickTextField.text forKey:@"userName"];
        
    }
    if (_userLogo) {
        [dic setObject:_userLogo forKey:@"userLogo"];
    }
    [self request:@"api/modify_user_info.html" dic:dic];
    [self.nickTextField resignFirstResponder];
}
#pragma mark-exitRegLoginDelegate
- (void)exitRegLogin{
    self.navigationController.navigationBar.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        // 平移
        CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , kScreenHeight);
        
        self.regLogScrollow .transform = translateForm;
    }];
}

#pragma mark-forgetPasswordDelegate
- (void)forgetPassword{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        // 平移
        CGAffineTransform translateForm = CGAffineTransformMakeTranslation(0 , kScreenHeight);
        
        self.regLogScrollow .transform = translateForm;
    }];
    ForgetWordViewController *forgetVctrl = [[ForgetWordViewController alloc]init];
    [self.navigationController pushViewController:forgetVctrl animated:YES];
}

#pragma mark-weChatLoginDelegate
- (void)weChatLogin{
    UIAlertView *weChatLoginAlView = [[UIAlertView alloc]initWithTitle:@"\"MVP\"想打开微信登陆" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开", nil];
    weChatLoginAlView.tag = 10000;
    [weChatLoginAlView show];
 
}

// alertView协议方法,调用微信的接口
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }else{
       //  是先执行移除self.regLogScrollow，发送通知，然后才是微信第三方登陆
        [MyUtils sendAuthRequest];
         [self.regLogScrollow removeFromSuperview];
        // 发送微信登录通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"wechatLogin" object:nil];
    }
}
// 接收通知中心里的方法
- (void)wechatLogin{
    BindPhoneViewController *bindPhoneVctrl = [[BindPhoneViewController alloc]init];
    [self.navigationController pushViewController:bindPhoneVctrl animated:NO];
}
#pragma  mark-UITabelveiwDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_mineButtonSelected == MineButtonSelectedWant) {
        {
            if (_wantArr.count > 0) {
                return _wantArr.count/2+1;
            }else{
                return 0;
            }
        }
        return 2;
    }else if (_mineButtonSelected == MineButtonSelectedCollection){
        return _collectionArr.count;
    }else{
        return _commentArr.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mineButtonSelected == MineButtonSelectedWant) {
        return 229.f;
    }else if (_mineButtonSelected == MineButtonSelectedCollection){
        return 63.f;
    }else{
        MineCommentModel *model = [_commentArr objectAtIndex:indexPath.row];
        return [MineCommentCell getCellHeight:model];
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mineButtonSelected == MineButtonSelectedWant) {
        return 180.f;
    }else if (_mineButtonSelected == MineButtonSelectedCollection){
        return 20;
    }else{
        return 30;
    }
}
// headView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 47.7*kScreenWidthP;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [self headerView];
    return view;
}
#pragma tableview  section header
- (UIView *)headerView{
    UIView *mineView = [[UIView alloc]init];
    mineView.backgroundColor = [UIColor whiteColor];
    _labelA = [[UILabel alloc]initWithFrame:CGRectMake(0, 0*kScreenWidthP, kScreenWidth, 0.5*kScreenWidthP)];
    UILabel *labelB = [[UILabel alloc]initWithFrame:CGRectMake(0, 47.6*kScreenWidthP, kScreenWidth, 0.5*kScreenWidthP)];
    _labelA.backgroundColor = RGBA(186, 186, 186, 1);
    labelB.backgroundColor = RGBA(186, 186, 186, 1);
    _labelA.tag = 100001;
    [mineView addSubview:_labelA];
    [mineView addSubview:labelB];
    
    for (int i = 1; i <= 3; i++) {
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*kScreenWidth/3, 17.5*kScreenWidthP, 1*kScreenWidthP, 12*kScreenWidthP)];
        lineLabel.tag = 10000+i;
        lineLabel.backgroundColor = RGBA(186, 186, 186, 1);
        [mineView  addSubview:lineLabel];
    }
    
    //写方法，传数字进去
    
    
    _myWantBtn = [[MineButton alloc]initWithFrame:CGRectMake(1*kScreenWidthP, 1*kScreenWidthP, kScreenWidth/3-2*kScreenWidthP, 45*kScreenWidthP)];
    [_myWantBtn setTitle:@"想要" forState:UIControlStateNormal];
    [_myWantBtn setTitleColor:RGBA(34, 34, 34, 1) forState:UIControlStateNormal];
    _myWantBtn.backgroundColor = [UIColor whiteColor];
    _myWantBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*kScreenWidthP];
    
    [_myWantBtn setImage:[UIImage imageNamed:@"fabbi_want"] forState:UIControlStateNormal];
    [_myWantBtn setImage:[UIImage imageNamed:@"fabbi_wanted"] forState:UIControlStateSelected];
    //    _myWantBtn.selected = YES;
    [_myWantBtn addTarget:self action:@selector(mywantBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mineView addSubview: _myWantBtn];
//    UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14*kScreenWidthP, 18*kScreenWidthP, 16*kScreenWidthP)];
//    ImageView.image = [UIImage imageNamed:@"fabbi_want"];
//    [mineView addSubview:ImageView];
    
    _myCollectionBtn = [[MineButton alloc]initWithFrame:CGRectMake(1*kScreenWidthP+kScreenWidth/3, 1*kScreenWidthP, kScreenWidth/3-2*kScreenWidthP, 45*kScreenWidthP)];
    [_myCollectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_myCollectionBtn setTitleColor:RGBA(34, 34, 34, 1) forState:UIControlStateNormal];
    _myCollectionBtn.backgroundColor = [UIColor whiteColor];
    _myCollectionBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*kScreenWidthP];
    _myCollectionBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [_myCollectionBtn setImage:[UIImage imageNamed:@"fabbi_collection"] forState:UIControlStateNormal];
    [_myCollectionBtn setImage:[UIImage imageNamed:@"fabbi_collectioned"] forState:UIControlStateSelected];
    [_myCollectionBtn addTarget:self action:@selector(mywantBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mineView addSubview: _myCollectionBtn];
    
    _myCommentBtn = [[MineButton alloc]initWithFrame:CGRectMake(1*kScreenWidthP+2*kScreenWidth/3, 1*kScreenWidthP, kScreenWidth/3-2*kScreenWidthP, 45*kScreenWidthP)];
    [_myCommentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [_myCommentBtn setTitleColor:RGBA(34, 34, 34, 1) forState:UIControlStateNormal];
    _myCommentBtn.backgroundColor = [UIColor whiteColor];
    _myCommentBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*kScreenWidthP];
    [_myCommentBtn setImage:[UIImage imageNamed:@"fabbi_comment"] forState:UIControlStateNormal];
    [_myCommentBtn setImage:[UIImage imageNamed:@"fabbi_commented"] forState:UIControlStateSelected];
//    _myCommentBtn.imageEdgeInsets = UIEdgeInsetsMake(13*kScreenWidthP, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    [_myCommentBtn addTarget:self action:@selector(mywantBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mineView addSubview: _myCommentBtn];
    if (_mineButtonSelected == MineButtonSelectedWant) {
        _myWantBtn.selected = YES;
    }else if (_mineButtonSelected == MineButtonSelectedCollection){
        _myCollectionBtn.selected = YES;
    }else{
        _myCommentBtn.selected = YES;
    }
    return mineView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mineButtonSelected == MineButtonSelectedWant) {
        static NSString *mineWantCellId= @"mineWantCellId";
        MineWantCell *mineWantCell = [tableView dequeueReusableCellWithIdentifier:mineWantCellId];
        if (mineWantCell == nil) {
            mineWantCell = [[MineWantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineWantCellId];
        }
        mineWantCell.delegate = self;
        [mineWantCell setContent:_wantArr atIndexPath:indexPath];
        mineWantCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mineWantCell;
    }else if (_mineButtonSelected == MineButtonSelectedCollection){
        static NSString *mineCollectionCellID = @"mineCollectionCellID";
        MineCollectionCell *mineCollectionCell = [tableView dequeueReusableCellWithIdentifier:mineCollectionCellID];
        if (mineCollectionCell == nil) {
            mineCollectionCell = [[MineCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCollectionCellID];
        }
        mineCollectionCell.delegate = self;
        MineCollectionModel *model = [_collectionArr objectAtIndex:indexPath.row];
        [mineCollectionCell content:model];
        mineCollectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mineCollectionCell;
    }else{
        static NSString *MineCommentCellId= @"MineCommentCellId";
        MineCommentCell *mineCell = [tableView dequeueReusableCellWithIdentifier:MineCommentCellId];
        if (mineCell == nil) {
            mineCell = [[MineCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MineCommentCellId];
        }
        mineCell.delegate = self;
        MineCommentModel *model = [_commentArr objectAtIndex:indexPath.row];
        [mineCell addTextAttributedLabel:model];
        mineCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mineCell;
    }
   
//    LibraryMovieModel *model = self.dataArray[indexPath.row];
    
    
}
#pragma 首次进入请求 <想要> 数据
- (void)requestFirst{
     [self removeContent];
    _myCollectionBtn.selected = NO;
    NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
    NSNumber *number = [NSNumber numberWithInt:1];
    NSDictionary *dic = @{
                          @"userId":uid,
                          @"hobbyType":number
                          };
    [self requestUrl:@"api/queryUserHobby.html" dic:dic];
}
#pragma mark-点击事件请求数据

- (void)mywantBtn:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    [self removeContent];
   
    if (btn == _myWantBtn) {
        [MobClick event:@"lookMyWant"];
        _mineTbView.mj_footer.hidden = YES;
        _mineButtonSelected = MineButtonSelectedWant;
        _mineTbView.separatorStyle = NO;
      
        _myWantBtn.selected = YES;
        _myCommentBtn.selected = NO;
        _myCollectionBtn.selected = NO;

        NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
        NSNumber *number = [NSNumber numberWithInt:1];
        NSDictionary *dic = @{
                              @"userId":uid,
                              @"hobbyType":number
                              };
        [self requestUrl:@"api/queryUserHobby.html" dic:dic];
        
        
    }else if (btn ==_myCommentBtn){
        [MobClick event:@"lookMyComment"];
        _mineTbView.mj_footer.hidden = NO;
         _mineTbView.separatorStyle = YES;
        _mineButtonSelected = MineButtonSelectedComment;
        _myWantBtn.selected = NO;
        _myCommentBtn.selected = YES;
        _myCollectionBtn.selected = NO;
        
        _currentPage = 1;
        NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
        NSDictionary *dic = @{
                              @"userId":uid,
                              @"currentPage":[NSNumber numberWithInteger:_currentPage]
                              
                              };
        [self requestUrl:@"api/queryComment.html" dic:dic];
    }else{
        [MobClick event:@"lookMyCollection"];
        _mineTbView.mj_footer.hidden = YES;
        _mineButtonSelected = MineButtonSelectedCollection;
         _mineTbView.separatorStyle = NO;
        _myWantBtn.selected = NO;
        _myCommentBtn.selected = NO;
        _myCollectionBtn.selected = YES;
        

        NSNumber *uid = UserDefaultObjectForKey(FABBI_AUTHORIZATION_UID);
        NSNumber *number = [NSNumber numberWithInt:2];
        NSDictionary *dic = @{
                              @"userId":uid,
                              @"hobbyType":number
            
                              };
        [self requestUrl:@"api/queryUserHobby.html" dic:dic];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mineTbView reloadData];
        
    });
    
}
- (void)requestUrl:(NSString *)url dic:(NSDictionary*)dic{
    [UserStore POSTWithParams:dic URL:url success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"222222222======");
        if (_mineButtonSelected == MineButtonSelectedCollection) {
            if (_collectionArr.count > 0) {
                [_collectionArr removeAllObjects];
            }
            NSArray *arr = (NSArray *)responseObject;
            if (arr.count > 0) {
                [self removeContent];
                for (NSDictionary *dic in arr) {
                    MineCollectionModel *collectionModel = [MineCollectionModel mj_objectWithKeyValues:dic];
                    [_collectionArr addObject:collectionModel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_mineTbView reloadData];
                });
            }else{
                [self noContentHint];
            }
        }else if (_mineButtonSelected == MineButtonSelectedWant){
            if (_wantArr.count > 0) {
                [_wantArr removeAllObjects];
            }
            NSArray *arr = (NSArray *)responseObject;
            if (arr.count > 0) {
                [self removeContent];
                for (NSDictionary *dic in arr) {
                    MineCollectionModel *collectionModel = [MineCollectionModel mj_objectWithKeyValues:dic];
                    [_wantArr addObject:collectionModel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_mineTbView reloadData];
                });
            }else{
                _mineTbView.mj_footer.hidden = YES;
                [self noContentHint];
            }

        }else{
            
            NSArray *commentArr = [responseObject objectForKey:@"resultList"];
            if (![NSArray isBlankArray:commentArr]) {
                [self removeContent];
                [commentArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic = (NSDictionary *)obj;
                    MineCommentModel *commentModel = [MineCommentModel mj_objectWithKeyValues:dic];
                    [_commentArr addObject:commentModel];
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_mineTbView reloadData];
                    [_mineTbView.mj_footer endRefreshing];
                    
                });
            }else{
                [self noContentHint];
                _mineTbView.mj_footer.hidden = YES;
            }
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
  
}
#pragma 获取更多评论
- (void)requestCommentMore{
    _currentPage += 1;
    NSDictionary *dic = @{
                          @"currentPage":[NSNumber numberWithInteger:_currentPage]
                          };
    [UserStore POSTWithParams:dic URL:@"/api/queryComment.html" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *commentArr = [responseObject objectForKey:@"resultList"];
        if (![NSArray isBlankArray:commentArr]) {
            for (NSDictionary *dic in commentArr) {
                MineCommentModel *commentModel = [MineCommentModel mj_objectWithKeyValues:dic];
                [_commentArr addObject:commentModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mineTbView reloadData];
                [_mineTbView.mj_footer endRefreshing];
                
            });
        }else{
           _mineTbView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
   
}
#pragma 无数据时提示
- (void)noContentHint{
    _noContentView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-100.f*kScreenWidthP, 350.f*kScreenWidthP, 200.f*kScreenWidthP, 200.f*kScreenWidthP)];
    _noContentView.backgroundColor = [UIColor clearColor];
    [_mineTbView addSubview:_noContentView];
    _noContentL = [[UILabel alloc]initWithFrame:CGRectMake(0, 61*kScreenWidthP, CGRectGetWidth(_noContentView.frame), 21*kScreenWidthP)];
    _noContentL.font = [UIFont systemFontOfSize:15];
    _noContentL.textAlignment = NSTextAlignmentCenter;
    _noContentL.textColor = RGBA(186, 186, 186, 1);
    [_noContentView addSubview:_noContentL];
    _nocontentB = [[UIButton alloc]initWithFrame:CGRectMake(60*kScreenWidthP, CGRectGetMaxY(_noContentL.frame)+25.f*kScreenWidthP, 80*kScreenWidthP, 32*kScreenWidthP)];
    _nocontentB.backgroundColor = RGBA(67, 181, 223, 1);
    _nocontentB.layer.masksToBounds = YES;
    _nocontentB.layer.cornerRadius = 3.f*kScreenWidthP;
    _nocontentB.titleLabel.textColor = [UIColor whiteColor];
    _nocontentB.titleLabel.font = [UIFont systemFontOfSize:13];
    [_nocontentB addTarget:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    [_noContentView addSubview:_nocontentB];
    if (_mineButtonSelected == MineButtonSelectedWant) {
        _noContentL.text = @"Fabbi一定有你想要";
        [_nocontentB setTitle:@"去逛逛" forState:UIControlStateNormal];
        
    }else if (_mineButtonSelected == MineButtonSelectedCollection){
        _noContentL.text = @"你还没有收藏的内容哦";
        [_nocontentB setTitle:@"去看看" forState:UIControlStateNormal];
        
    }else{
        _noContentL.text = @"你还没有发表任何评论哦";
       [_nocontentB setTitle:@"去逛逛" forState:UIControlStateNormal];
    }
}
- (void)removeContent{
    [_nocontentB removeFromSuperview];
    [_noContentL removeFromSuperview];
    [_noContentView removeFromSuperview];
}
- (void)backToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma minewantcelldelegate
- (void)favorAblumTapped:(MineCollectionModel *)groupItem{
    DetailPageViewController *detail = [[DetailPageViewController alloc]init];
    NSString *itemId= [NSString stringWithFormat:@"%ld",(long)groupItem.pointId];
    detail.itemId = itemId;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma minecollectioncellDelegate
- (void)toGoodDetail:(MineCollectionModel *)model{
    GoodsViewController *goodDetail = [[GoodsViewController alloc]init];
    NSString *itemId= [NSString stringWithFormat:@"%ld",(long)model.pointId];
    goodDetail.speicalId = itemId;
    [self.navigationController pushViewController:goodDetail animated:YES];
}
#pragma minecommentcellDelegate
-(void)toDetailOrGood:(MineCommentModel *)model{
    if ([model.commentType isEqualToString:@"2"]) {
        GoodsViewController *goodDetail = [[GoodsViewController alloc]init];
        NSString *itemId= [NSString stringWithFormat:@"%ld",(long)model.pointId];
        goodDetail.speicalId = itemId;
        [self.navigationController pushViewController:goodDetail animated:YES];
    }else{
        DetailPageViewController *detail = [[DetailPageViewController alloc]init];
        NSString *itemId= [NSString stringWithFormat:@"%ld",(long)model.pointId];
        detail.itemId = itemId;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
#pragma  mark - UIScrollowDelegate 事件的监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 210*kScreenWidthP) {
        _mineBackBtn.hidden = YES;
        backView.hidden = YES;
        setView.hidden = YES;
        _setUpBtn.hidden = YES;
        _labelA.hidden = YES;
        for (int i = 1; i<3; i++) {
            UILabel *label = [self.view viewWithTag:i+10000];
            label.hidden = YES;
        }
    }else{
        _mineBackBtn.hidden = NO;
        backView.hidden = NO;
        setView.hidden = NO;
        _setUpBtn.hidden = NO;
         _labelA.hidden = NO;
        for (int i = 1; i<3; i++) {
            UILabel *label = [self.view viewWithTag:i+10000];
            label.hidden = NO;
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"个人中心"];
}
@end
