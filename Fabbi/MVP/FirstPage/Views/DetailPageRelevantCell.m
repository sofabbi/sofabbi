//
//  DetailPageRelevantCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/21.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "DetailPageRelevantCell.h"
#import <DTCoreText/DTCoreText.h>

@interface DetailPageRelevantCell ()
{
    UILabel *mainTitle;
    UILabel *subTitle;
}
@property (nonatomic,strong) DTAttributedLabel *lable;

@end
@implementation DetailPageRelevantCell
+ (CGFloat)getAddTextAttributedLabel:(NSDictionary *)dic{
    CGFloat height;
    DTAttributedLabel*lable = [[DTAttributedLabel alloc] initWithFrame: CGRectMake(20*kScreenWidthP, 20*kScreenWidthP, kScreenWidth-40*kScreenWidthP, FLT_MAX)];
    NSString * htmlcontent =  [dic objectForKey:@"itemContens"];
    lable.attributedString = [DetailPageRelevantCell _attributedStringForSnippetUsingiOS6Attributes:NO html:htmlcontent];
    [lable sizeToFit];
    height += [lable intrinsicContentSize].height+123*kScreenWidthP;
    return height;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIView *titlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 98*kScreenWidthP)];
        titlView.backgroundColor = [UIColor clearColor];
        [self addSubview:titlView];
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(138*kScreenWidthP, 26*kScreenWidthP, 2*kScreenWidthP, 12*kScreenWidthP)];
        [titlView addSubview:line1];
        line1.backgroundColor = RGBA(34, 34, 34, 1);
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth -138*kScreenWidthP, 26*kScreenWidthP, 2*kScreenWidthP, 12*kScreenWidthP)];
        line2.backgroundColor = RGBA(34, 34, 34, 1);
        [titlView addSubview:line2];
        mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64*kScreenWidthP, 22*kScreenWidthP)];
        mainTitle.center = CGPointMake(kScreenWidth/2, 31*kScreenWidthP);
        mainTitle.font = [UIFont boldSystemFontOfSize:16];
        mainTitle.text = @"品牌故事";
        mainTitle.textAlignment = NSTextAlignmentCenter;
        [titlView addSubview:mainTitle];
        subTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTitle.frame)+20*kScreenWidthP, kScreenWidth, 25*kScreenWidthP)];
        subTitle.font = [UIFont boldSystemFontOfSize:18];
        subTitle.text = @"Olympia Activewear";
        subTitle.textAlignment = NSTextAlignmentCenter;
        [titlView addSubview:subTitle];
        
        _lable = [[DTAttributedLabel alloc]initWithFrame:CGRectMake(20*kScreenWidthP, 0, kScreenWidth -40*kScreenWidthP, FLT_MAX)];
        [self addSubview:_lable];
    }
    return self;
}
- (void)addTextAttributedLabel:(NSDictionary *)dic{
    NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", [dic objectForKey:@"itemContens"]];
    self.lable.attributedString = [DetailPageRelevantCell _attributedStringForSnippetUsingiOS6Attributes:NO html:htmlcontent];
    [_lable sizeToFit];
    _lable.frame = CGRectMake(20*kScreenWidthP,110*kScreenWidthP, kScreenWidth - 40*kScreenWidthP, _lable.frame.size.height);
}
+ (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes html:(NSString *)htmlStr
{
    // Load HTML data
    
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake(kScreenWidth - 20.0, kScreenHeight - 20.0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, [NSNumber numberWithFloat:16],DTDefaultFontSize ,[NSNumber numberWithInt:NSTextAlignmentJustified],DTDefaultTextAlignment,@"PingFangSC-Light",DTDefaultFontName,[NSNumber numberWithFloat:1.4],DTDefaultLineHeightMultiplier,nil];
    
    if (useiOS6Attributes)
    {
        [options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
    }
    
    [options setObject:htmlStr forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}

@end
