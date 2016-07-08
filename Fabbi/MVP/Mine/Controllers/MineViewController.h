//
//  MineViewController.h
//  MVP
//
//  Created by 刘志刚 on 16/4/19.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController
@property (nonatomic,strong)NSMutableArray *wantArr;
@property (nonatomic,strong)NSMutableArray *collectionArr;
@property (nonatomic,strong)NSMutableArray *commentArr;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,strong)NSString *userLogo;
@end
