//
//  ViewController.h
//  MVP
//
//  Created by 刘志刚 on 16/5/18.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "ViewController.h"
#import "FirstPageViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController (){
//    NSTimer *timer;
    UIImageView *startImageView;
}
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property(nonatomic ,strong)AVAudioSession *avaudioSession;
//@property(nonatomic ,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"1-merge.mp4" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    [_moviePlayer play];
    [_moviePlayer.view setFrame:self.view.bounds];
    
    [self.view addSubview:_moviePlayer.view];
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer setFullscreen:YES];
    
    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    UIView *skipAnimationView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 80*kScreenWidthP, 0, 80*kScreenWidthP, 80*kScreenWidthP)];
    skipAnimationView.backgroundColor = [UIColor clearColor];
     skipAnimationView.userInteractionEnabled = YES;
    [self.view addSubview:skipAnimationView];
    
    UITapGestureRecognizer *tapSkip = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAllView)];
    [skipAnimationView addGestureRecognizer:tapSkip];
    UILabel *skipL = [[UILabel alloc]initWithFrame:CGRectMake(16*kScreenWidthP, 20*kScreenWidthP, 44*kScreenWidthP, 26*kScreenWidthP)];
    skipL.backgroundColor = RGBA(0, 0, 0, 0.3);
    skipL.textColor = [UIColor whiteColor];
    skipL.text = @"跳过";
    skipL.textAlignment = NSTextAlignmentCenter;
    skipL.layer.masksToBounds = YES;
    skipL.layer.cornerRadius = 3.*kScreenWidthP;
    skipL.font = [UIFont systemFontOfSize:13];
    [skipAnimationView addSubview:skipL];
    startImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    startImageView.image = [UIImage imageNamed:@"MAIN.jpg"];
    startImageView.userInteractionEnabled = YES;
    startImageView.hidden = YES;
    [self.view addSubview:startImageView];
    UITapGestureRecognizer *tapStartImageView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapStartImageViewAction:)];
    [startImageView addGestureRecognizer:tapStartImageView];
//    [self.view addSubview:self.midView];
//    [self.view addSubview:self.scrollView];
  
}
-(void)playbackStateChanged{
    
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            _moviePlayer.view.hidden = YES;
            startImageView.hidden = NO;
            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;
            
        default:
            NSLog(@"无法辨识的状态");
            break;
    }
}
- (void)tapStartImageViewAction:(UITapGestureRecognizer *)tapGes{
    CGPoint locationTap = [tapGes locationInView:self.view];
    if (locationTap.y > (kScreenHeight - 200*kScreenWidthP)&&locationTap.y<kScreenHeight) {
        [self removeAllView];
    }
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"screen800x500.jpeg"]];
        
        [_scrollView addSubview:imageView];
        _scrollView.contentSize = CGSizeMake(imageView.frame.size.width, kScreenHeight);
    }
    return _scrollView;
}


#pragma mark setterfmidView
- (UIView *)midView{
    if (_midView == nil) {
        _midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/3)];
        _midView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        _midView.backgroundColor = [UIColor clearColor];
        NSArray *components = [NSArray arrayWithObjects:@"Fabbi",@"帮你找到好看又",@"好用的运动装备", nil];
        for (int i = 0; i < 3; i++) {
            M80AttributedLabel *midText = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(0, i *kScreenWidth/9, kScreenWidth, kScreenWidth/9)];
            midText.lineBreakMode = kCTLineBreakByTruncatingTail;
            [midText setTextAlignment:kCTTextAlignmentCenter];
            midText.backgroundColor = [UIColor clearColor];
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:components[i]];
            if (i == 0) {
                attributedText.font = [UIFont fontWithName:@"HiraMinProN-W3" size:40*kScale];
            }else if(i == 1){
                attributedText.font = [UIFont systemFontOfSize:23*kScale];
            }else
            {
                attributedText.font = [UIFont systemFontOfSize:23*kScale];
            }
            [midText appendAttributedText:attributedText];
            midText.textColor = [UIColor colorWithRed:0.53f green:0.42f blue:0.43f alpha:1.00f];
            [_midView addSubview:midText];
            _midView.alpha = 0;
            [UIView animateWithDuration:1.4 animations:^{
                _midView.alpha = 1;
            } completion:^(BOOL finished) {
                [self.view addSubview:self.bgImageView];
                [self.view bringSubviewToFront:self.midView];
            }];
        }
    }
    return _midView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.rightHeaderImageView2.frame.origin.y+self.rightHeaderImageView2.frame.size.height+80*kScale, kScreenWidth, kScreenWidth/3)];
        _bottomView.backgroundColor = [UIColor clearColor];
        NSArray *components = [NSArray arrayWithObjects:@"Seeg On-demand",@"我 要 的， 现 在 就 要",@"图片求购服务，从此所见即所得", nil];
        for (int i = 0; i < 3; i++) {
            M80AttributedLabel *midText = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(0, i *kScreenWidth/9, kScreenWidth, kScreenWidth/9)];
            midText.lineBreakMode = kCTLineBreakByTruncatingTail;
            [midText setTextAlignment:kCTTextAlignmentCenter];
            midText.backgroundColor = [UIColor clearColor];
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:components[i]];
            if (i == 0) {
                attributedText.font = [UIFont fontWithName:@"HiraMinProN-W3" size:25*kScale];
            }else if(i == 1){
                attributedText.font = [UIFont systemFontOfSize:23*kScale];
            }else
            {
                attributedText.font = [UIFont systemFontOfSize:15*kScale];
            }
            [midText appendAttributedText:attributedText];
            midText.textColor = [UIColor colorWithRed:0.53f green:0.42f blue:0.43f alpha:1.00f];
            [_bottomView addSubview:midText];
        }
        _bottomView.alpha = 0;
    }
    return _bottomView;
}

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*2, kScreenHeight)];
        _bgImageView.image = [UIImage imageNamed:@"1.jpg"];
        [UIView animateWithDuration:2.0 animations:^{
            _bgImageView.transform = CGAffineTransformMakeTranslation(-kScreenWidth, 0);
        }completion:^(BOOL finished) {
            [self.view addSubview:self.blurView];
            [self.view bringSubviewToFront:self.midView];
            [UIView animateWithDuration:0.9 animations:^{
                _midView.alpha = 0;
            } completion:^(BOOL finished) {
                [self.view addSubview:self.bgView];
            }];
        }];
    }
    return _bgImageView;
}

- (FXBlurView *)blurView{
    if (_blurView == nil) {
        _blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _blurView.tintColor = [UIColor clearColor];
    }
    return _blurView;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3/2)];
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:self.rightHeaderImageView];
    }
    return _bgView;
}

- (UIImageView *)rightHeaderImageView{
    if (_rightHeaderImageView == nil) {
        _rightHeaderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-100*kScale, 60*kScreenHeight/375, 50*kScale, 50*kScale)];
        _rightHeaderImageView.layer.masksToBounds = YES;
        _rightHeaderImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightHeaderImageView.layer.borderWidth = 1;
        _rightHeaderImageView.layer.cornerRadius = 25*kScale;
        _rightHeaderImageView.image = [UIImage imageNamed:@"123.jpg"];
        
        [self.bgView addSubview:self.chatView1];
        [UIView animateWithDuration:0.6 animations:^{
            self.chatView1.frame = CGRectMake(_rightHeaderImageView.frame.origin.x-200*kScale, _rightHeaderImageView.frame.origin.y, 200*kScale, 240*kScale);
            self.contentImage1.frame = CGRectMake(10*kScale, 10*kScale, self.chatView1.frame.size.width-20*kScale, self.chatView1.frame.size.height-10*kScale-30*kScale);
            self.contentText1.frame = CGRectMake(10*kScale, self.chatView1.frame.size.height-30*kScale, self.chatView1.frame.size.width-20*kScale, 30*kScale);
        }completion:^(BOOL finished) {
            [self.bgView addSubview:self.leftHeaderImageView];
        }];
        
    }
    return _rightHeaderImageView;
}

- (UIImageView *)leftHeaderImageView{
    if (_leftHeaderImageView == nil) {
        _leftHeaderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50*kScale, 60*kScreenHeight/375 + 240*kScale + 100*kScale, 50*kScale, 50*kScale)];
        _leftHeaderImageView.layer.masksToBounds = YES;
        _leftHeaderImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _leftHeaderImageView.layer.borderWidth = 1;
        _leftHeaderImageView.layer.cornerRadius = 25*kScale;
        _leftHeaderImageView.image = [UIImage imageNamed:@"444.jpg"];
        _leftHeaderImageView.alpha = 0;
        
        [UIView animateWithDuration:0.6 animations:^{
            _leftHeaderImageView.transform = CGAffineTransformMakeTranslation(0, -50*kScale);
            _leftHeaderImageView.alpha = 1;
        }completion:^(BOOL finished) {
            [self.bgView addSubview:self.chatView2];
            [self.chatView2 setFrame:CGRectMake(_leftHeaderImageView.frame.origin.x+50*kScale, _leftHeaderImageView.frame.origin.y, 0, 0)];
            [UIView animateWithDuration:0.6 animations:^{
                self.chatView2.frame = CGRectMake(_leftHeaderImageView.frame.origin.x+50*kScale, _leftHeaderImageView.frame.origin.y, 250*kScale, 200*kScale);
                self.contentText2.frame = CGRectMake(10*kScale, 0, self.chatView2.frame.size.width-20*kScale, 50*kScale);
                self.contentImage2.frame = CGRectMake(10*kScale, 50*kScale, self.chatView2.frame.size.width-20*kScale, self.chatView2.frame.size.height-60*kScale);
                [self.contentImage2 addSubview:self.buyBtn];
            }completion:^(BOOL finished) {
                // bgView上移 第一条聊天隐藏
                [UIView animateWithDuration:0.6 animations:^{
                    self.bgView.transform = CGAffineTransformMakeTranslation(0, -self.chatView1.frame.size.height);
                    self.rightHeaderImageView.alpha = 0;
                    self.chatView1.alpha = 0;
                    self.contentImage1.alpha = 0;
                    self.contentText1.alpha = 0;
                }completion:^(BOOL finished) {
                    // 出现第三天聊天
                    [_bgView addSubview:self.rightHeaderImageView2];
                }];
            }];
        }];
        
    }
    return _leftHeaderImageView;
}

- (UIImageView *)rightHeaderImageView2{
    if (_rightHeaderImageView2 == nil) {
        _rightHeaderImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-100*kScale, self.chatView2.frame.origin.y+self.chatView2.frame.size.height+100*kScale, 50*kScale, 50*kScale)];
        _rightHeaderImageView2.layer.masksToBounds = YES;
        _rightHeaderImageView2.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightHeaderImageView2.layer.borderWidth = 1;
        _rightHeaderImageView2.layer.cornerRadius = 25*kScale;
        _rightHeaderImageView2.image = [UIImage imageNamed:@"123.jpg"];
        _rightHeaderImageView2.alpha = 0;
        
        [UIView animateWithDuration:0.6 animations:^{
            _rightHeaderImageView2.transform = CGAffineTransformMakeTranslation(0, -50*kScale);
            _rightHeaderImageView2.alpha = 1;
        }completion:^(BOOL finished) {
            [self.bgView addSubview:self.chatView3];
            [UIView animateWithDuration:0.6 animations:^{
                self.chatView3.frame = CGRectMake(_rightHeaderImageView2.frame.origin.x-200*kScale, _rightHeaderImageView2.frame.origin.y, 200*kScale, 50*kScale);
                self.contentText3.frame = CGRectMake(10*kScale, 0, self.chatView3.frame.size.width-20*kScale, 50*kScale);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    [self.buyBtn setBackgroundColor:[UIColor colorWithRed:0.98f green:0.40f blue:0.55f alpha:1.00f]];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4 animations:^{
                        self.buyBtn.transform = CGAffineTransformMakeScale(1.25, 1.25);
                    } completion:^(BOOL finished) {
                        self.buyBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        
                        // 出现底下文字
                        [self.bgView addSubview:self.bottomView];
                        [UIView animateWithDuration:0.6 animations:^{
                            self.bottomView.alpha = 1;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.6 animations:^{
                                self.bgView.alpha = 0;
                            } completion:^(BOOL finished) {
                                [self.view addSubview:self.bgView2];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }
    return _rightHeaderImageView2;
}

- (UIView *)chatView1{
    if (_chatView1 == nil) {
        _chatView1 = [[UIView alloc]initWithFrame:CGRectMake(self.rightHeaderImageView.frame.origin.x, self.rightHeaderImageView.frame.origin.y, 0, 0)];
        _chatView1.backgroundColor = [UIColor whiteColor];
        [_chatView1 addSubview:self.contentImage1];
        [_chatView1 addSubview:self.contentText1];
        _chatView1.layer.cornerRadius = 5;
    }
    return _chatView1;
}

- (UIView *)chatView2{
    if (_chatView2 == nil) {
        _chatView2 = [[UIView alloc]initWithFrame:CGRectMake(self.rightHeaderImageView.frame.origin.x, self.rightHeaderImageView.frame.origin.y, 0, 0)];
        _chatView2.backgroundColor = [UIColor whiteColor];
        [_chatView2 addSubview:self.contentImage2];
        [_chatView2 addSubview:self.contentText2];
        _chatView2.layer.cornerRadius = 5;
    }
    return _chatView2;
}

- (UIView *)chatView3{
    if (_chatView3 == nil) {
        _chatView3 = [[UIView alloc]initWithFrame:CGRectMake(self.rightHeaderImageView2.frame.origin.x, self.rightHeaderImageView2.frame.origin.y, 0, 0)];
        _chatView3.backgroundColor = [UIColor whiteColor];
        [_chatView3 addSubview:self.contentText3];
        _chatView3.layer.cornerRadius = 5;
    }
    return _chatView3;
}

- (UIImageView *)contentImage1{
    if (_contentImage1 == nil) {
        _contentImage1 = [[UIImageView alloc]initWithFrame:self.chatView1.frame];
        _contentImage1.image = [UIImage imageNamed:@"3.jpg"];
    }
    return _contentImage1;
}

- (UILabel *)contentText1{
    if (_contentText1 == nil) {
        _contentText1 = [[UILabel alloc]initWithFrame:self.chatView1.frame];
        _contentText1.textColor = [UIColor blackColor];
        _contentText1.backgroundColor = [UIColor clearColor];
        _contentText1.font = [UIFont systemFontOfSize:10*kScale];
        _contentText1.text = @"这件连衣裙好好看,See能帮我找到吗？";
    }
    return _contentText1;
}

- (UIImageView *)contentImage2{
    if (_contentImage2 == nil) {
        _contentImage2 = [[UIImageView alloc]initWithFrame:self.chatView2.frame];
        _contentImage2.image = [UIImage imageNamed:@"5.jpg"];
    }
    return _contentImage2;
}

- (UILabel *)contentText2{
    if (_contentText2 == nil) {
        _contentText2 = [[UILabel alloc]initWithFrame:self.chatView2.frame];
        _contentText2.textColor = [UIColor blackColor];
        _contentText2.backgroundColor = [UIColor clearColor];
        _contentText2.font = [UIFont systemFontOfSize:13*kScale];
        _contentText2.text = @"原款找到啦,是韩国Chuu的呢。搭配简洁包包上身很漂亮喔!";
        _contentText2.lineBreakMode = NSLineBreakByWordWrapping;
        _contentText2.numberOfLines = 0;
    }
    return _contentText2;
}

- (UILabel *)contentText3{
    if (_contentText3 == nil) {
        _contentText3 = [[UILabel alloc]initWithFrame:self.chatView3.frame];
        _contentText3.textColor = [UIColor blackColor];
        _contentText3.backgroundColor = [UIColor whiteColor];
        _contentText3.font = [UIFont systemFontOfSize:13*kScale];
        _contentText3.text = @"谢谢，又要剁手啦!";
        _contentText3.lineBreakMode = NSLineBreakByWordWrapping;
        _contentText3.numberOfLines = 0;
    }
    return _contentText3;
}

- (UIButton *)buyBtn{
    if (_buyBtn == nil) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake(self.contentImage2.frame.size.width-70*kScale, self.contentImage2.frame.size.height/2, 60*kScale, 30*kScale);
        _buyBtn.layer.cornerRadius = 5;
        _buyBtn.backgroundColor = [UIColor whiteColor];
        [_buyBtn setTitleColor:[UIColor colorWithRed:0.98f green:0.40f blue:0.55f alpha:1.00f] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:15*kScale];
    }
    return _buyBtn;
}

#pragma mark 第二阶段
- (UIView *)bgView2{
    if (_bgView2 == nil) {
        _bgView2 = [[UIView alloc]initWithFrame:CGRectMake(-kScreenWidth/3, -kScreenWidth/3, kScreenWidth+kScreenWidth/3, kScreenHeight+kScreenWidth/3)];
        _bgView2.backgroundColor = [UIColor whiteColor];
        [_bgView2 addSubview:self.imageLeft];
    }
    return _bgView2;
}

- (UIImageView *)imageLeft{
    if (_imageLeft == nil) {
        _imageLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50*kScale+kScreenWidth/3, kScreenWidth/3, kScreenWidth/3)];
        _imageLeft.image = [UIImage imageNamed:@"6.jpg"];
        [UIView animateWithDuration:0.6 animations:^{
            _imageLeft.transform = CGAffineTransformMakeTranslation(kScreenWidth/3,0);
        } completion:^(BOOL finished) {
            [self.bgView2 addSubview:self.imageTop];
        }];
    }
    return _imageLeft;
}

- (UIImageView *)imageTop{
    if (_imageTop == nil) {
        _imageTop = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth/3, kScreenWidth/3)];
        _imageTop.image = [UIImage imageNamed:@"444.jpg"];
        [UIView animateWithDuration:0.6 animations:^{
            _imageTop.transform = CGAffineTransformMakeTranslation(0,kScreenWidth/3);
        } completion:^(BOOL finished) {
            [self.bgView2 addSubview:self.imageRight];
        }];
    }
    return _imageTop;
}

- (UIImageView *)imageRight{
    if (_imageRight == nil) {
        _imageRight = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth+kScreenWidth/3, kScreenHeight+kScreenWidth/3, kScreenWidth/3, kScreenWidth/3)];
        _imageRight.image = [UIImage imageNamed:@"8.jpg"];
        [UIView animateWithDuration:0.6 animations:^{
            _imageRight.transform = CGAffineTransformMakeTranslation(-kScreenWidth/3,-kScreenWidth/3-50*kScale);
        } completion:^(BOOL finished) {
            [self.bgView2 addSubview:self.imageBottom];
        }];
    }
    return _imageRight;
}

- (UIImageView *)imageBottom{
    if (_imageBottom == nil) {
        _imageBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight+kScreenWidth/3, kScreenWidth/3, kScreenWidth/3)];
        _imageBottom.image = [UIImage imageNamed:@"9.jpg"];
        [UIView animateWithDuration:0.6 animations:^{
            _imageBottom.transform = CGAffineTransformMakeTranslation(kScreenWidth/3,-kScreenWidth/3);
        } completion:^(BOOL finished) {
            [self.bgView2 addSubview:self.glasses];
        }];
    }
    return _imageBottom;
}

- (UIImageView *)glasses{
    if (_glasses == nil) {
        _glasses = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth, (self.bgView2.frame.size.height - kScreenWidth/3)/2-kScreenWidth/6, kScreenWidth/3, kScreenWidth/3)];
        _glasses.image = [UIImage imageNamed:@"10.jpg"];
        _glasses.alpha = 0;
        [UIView animateWithDuration:0.6 animations:^{
            _glasses.alpha = 1;
        } completion:^(BOOL finished) {
            [self.bgView2 addSubview:self.hat];
        }];
    }
    return _glasses;
}

- (UIImageView *)hat{
    if (_hat == nil) {
        _hat = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3, (self.bgView2.frame.size.height - kScreenWidth/3)/2+kScreenWidth/6, kScreenWidth/3,kScreenWidth/3)];
        _hat.image = [UIImage imageNamed:@"11.jpg"];
        _hat.alpha = 0;
        [UIView animateWithDuration:0.6 animations:^{
            _hat.alpha = 1;
        } completion:^(BOOL finished) {
            [self.bgView2 addSubview:self.midView2];
        }];
    }
    return _hat;
}

- (UIView *)midView2{
    if (_midView2 == nil) {
        _midView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/3)];
        _midView2.center = CGPointMake(kScreenWidth/2+kScreenWidth/3, kScreenHeight/2+kScreenWidth/3);
        _midView2.backgroundColor = [UIColor clearColor];
        NSArray *components = [NSArray arrayWithObjects:@"Daily Fashion",@"你 的 时 尚 聚 集 地",@"明星、影视、自媒体...不错过任何时尚热点", nil];
        for (int i = 0; i < 3; i++) {
            M80AttributedLabel *midText = [[M80AttributedLabel alloc]initWithFrame:CGRectMake(0, i *kScreenWidth/9, kScreenWidth, kScreenWidth/9)];
            midText.lineBreakMode = kCTLineBreakByTruncatingTail;
            [midText setTextAlignment:kCTTextAlignmentCenter];
            midText.backgroundColor = [UIColor clearColor];
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:components[i]];
            if (i == 0) {
                attributedText.font = [UIFont fontWithName:@"HiraMinProN-W3" size:25*kScale];
            }else if(i == 1){
                attributedText.font = [UIFont systemFontOfSize:23*kScale];
            }else
            {
                attributedText.font = [UIFont systemFontOfSize:15*kScale];
            }
            [midText appendAttributedText:attributedText];
            midText.textColor = [UIColor colorWithRed:0.53f green:0.42f blue:0.43f alpha:1.00f];
            [_midView2 addSubview:midText];
            _midView2.alpha = 0;
            [UIView animateWithDuration:0.6 animations:^{
                _midView2.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.6 animations:^{
                    _midView2.alpha = 0;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.6 animations:^{
                        self.glasses.alpha = 0;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.6 animations:^{
                            self.hat.alpha = 0;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.6 animations:^{
                                _imageLeft.transform = CGAffineTransformMakeTranslation(-kScreenWidth/3,0);
                                _imageTop.transform = CGAffineTransformMakeTranslation(0,-kScreenWidth/3);
                                _imageRight.transform = CGAffineTransformMakeTranslation(kScreenWidth/3,kScreenWidth/3+50*kScale);
                                _imageBottom.transform = CGAffineTransformMakeTranslation(kScreenWidth/3,kScreenWidth/3);
                            } completion:^(BOOL finished) {
                                [self.view addSubview:self.bgView3];
                            }];
                        }];
                    }];
                }];
            }];
        }
        
    }
    return _midView2;
}

#pragma mark 第三阶段
- (UIImageView *)bgView3{
    if (_bgView3 == nil) {
        _bgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView3.image = [UIImage imageNamed:@"12.jpg"];
        _bgView3.alpha = 0;
        [UIView animateWithDuration:0.6 animations:^{
            _bgView3.alpha = 1;
        } completion:^(BOOL finished) {
            [_bgView3 addSubview:self.logo];
        }];
    }
    return _bgView3;
}

- (UIImageView *)logo{
    if(_logo == nil){
        _logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70*kScale, 70*kScale)];
        _logo.center = self.bgView3.center;
        _logo.layer.masksToBounds = YES;
        _logo.layer.cornerRadius = 35*kScale;
        _logo.backgroundColor = [UIColor colorWithRed:0.95f green:0.47f blue:0.44f alpha:1.00f];
        _logo.alpha = 0;
        [UIView animateWithDuration:0.6 animations:^{
            _logo.alpha = 1;
        } completion:^(BOOL finished) {
            [self.bgView3 addSubview:self.note];
        }];
    }
    return _logo;
}

- (UILabel *)note{
    if (_note == nil) {
        _note = [[UILabel alloc]initWithFrame:CGRectMake(0, self.logo.frame.origin.y+self.logo.frame.size.height, kScreenWidth, 50*kScale)];
        _note.textColor = [UIColor colorWithRed:0.53f green:0.42f blue:0.43f alpha:1.00f];
        _note.text = @"时尚在此刻";
        _note.font = [UIFont systemFontOfSize:25*kScale];
        _note.textAlignment = NSTextAlignmentCenter;
        _note.alpha = 0;
        [UIView animateWithDuration:0.6 animations:^{
            _note.alpha = 1;
        } completion:^(BOOL finished) {
            [self.view addSubview:self.openSee];
        }];
    }
    return _note;
}

- (UIButton *)openSee{
    if (_openSee == nil) {
        _openSee = [UIButton buttonWithType:UIButtonTypeCustom];
        _openSee.frame = CGRectMake(60*kScale, kScreenHeight-100*kScale, kScreenWidth-120*kScale, 60*kScale);
        _openSee.layer.cornerRadius = 10;
        [_openSee setTitle:@"开启 See 2016" forState:UIControlStateNormal];
        [_openSee setTitleColor:[UIColor colorWithRed:0.58f green:0.58f blue:0.58f alpha:1.00f] forState:UIControlStateNormal];
        [_openSee setBackgroundColor:[UIColor colorWithRed:0.91f green:0.92f blue:0.93f alpha:1.00f]];
        
    }
    return _openSee;
}

- (void)removeAllView{
    
    for (id tt in self.view.subviews) {
        [tt removeFromSuperview];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"createFirstPageVctrl" object:nil];
    }
}

@end
