//
//  RelatedProductsCell.m
//  Fabbi
//
//  Created by zou145688 on 16/6/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "RelatedProductsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RelatedProductsView.h"
#import <DTCoreText/DTCoreText.h>
#import <TYAttributedLabel.h>
#import "MyUtils.h"
#define RelatedProductsH  100*kScreenWidthP
#define space 20*kScreenWidthP

@interface RelatedProductsCell ()<relatedProductsViewDelegate,DTLazyImageViewDelegate,DTAttributedTextContentViewDelegate>
@property (nonatomic, strong) DTAttributedLabel *lable;
@end
@implementation RelatedProductsCell
+(CGFloat)getCellHeight:(NSDictionary *)model{
    DTAttributedLabel*lable = [[DTAttributedLabel alloc] initWithFrame: CGRectMake(20*kScreenWidthP, 15*kScreenWidthP, kScreenWidth-40*kScreenWidthP, FLT_MAX)];
//    富文本数据源处理
    NSString * htmlcontent =  [NSMutableString stringWithFormat:@"%@",[model objectForKey:@"specialImg"]];
    htmlcontent = [htmlcontent stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    htmlcontent = [htmlcontent stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    htmlcontent = [htmlcontent stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    htmlcontent = [NSString stringWithFormat:@"<p>%@</p>",htmlcontent];
    
    lable.attributedString = [RelatedProductsCell _attributedStringForSnippetUsingiOS6Attributes:NO html:htmlcontent];
    
    [lable sizeToFit];
    CGFloat height = lable.frame.size.height + 35*kScreenWidthP;
    NSArray *itemList = [model objectForKey:@"itemList"];
    if (itemList.count > 0) {
        height += 25*kScreenWidthP;
        height += itemList.count *(RelatedProductsH + space);
    }
    
    return height;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _lable = [[DTAttributedLabel alloc] initWithFrame: CGRectMake(20*kScreenWidthP, 15*kScreenWidthP, kScreenWidth-40*kScreenWidthP, FLT_MAX)];
        _lable.delegate = self;
        [self addSubview:_lable];
    }
    return self;
}
- (void)setContentDictionary:(NSDictionary *)model{
    _contentDictionary = model;
    NSString * htmlcontent =  [model objectForKey:@"specialImg"];
    //    富文本数据源处理
    htmlcontent = [htmlcontent stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    htmlcontent = [htmlcontent stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    htmlcontent = [htmlcontent stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    htmlcontent = [NSString stringWithFormat:@"<p>%@</p>",htmlcontent];
    self.lable.attributedString = [RelatedProductsCell _attributedStringForSnippetUsingiOS6Attributes:NO html:htmlcontent];
    [_lable sizeToFit];
    _lable.frame = CGRectMake(20*kScreenWidthP, 15*kScreenWidthP, kScreenWidth-40*kScreenWidthP, _lable.frame.size.height);
    NSArray *itemList = [model objectForKey:@"itemList"];
    CGFloat heights = CGRectGetMaxY(_lable.frame)+14*kScreenWidthP;
    if (itemList.count > 0) {
        // 相关商品view
        UIView *goodView = [[UIView alloc]initWithFrame:CGRectMake(0, heights, kScreenWidth, 20*kScreenWidthP)];
        goodView.backgroundColor = RGBA(255, 255, 255, 1);
        // 线
        UILabel *labelA = [MyUtils createLabelFrame:CGRectMake(20*kScreenWidthP, 10*kScreenWidthP, 100*kScreenWidthP, 1) backgroundColor:RGBA(215, 215, 215, 1) title:nil font:0.f];
        [goodView addSubview:labelA];
        
        UILabel *labelB = [MyUtils createLabelFrame:CGRectMake(kScreenWidth - 120*kScreenWidthP, 10*kScreenWidthP, 100*kScreenWidthP, 1) backgroundColor:RGBA(215, 215, 215, 1) title:nil font:0.f];
        [goodView addSubview:labelB];
        
        UILabel *labelC = [MyUtils createLabelFrame:CGRectMake(kScreenWidth/2 - 50*kScreenWidthP, 0*kScreenWidthP, 100*kScreenWidthP, 20*kScreenWidthP) backgroundColor:RGBA(215, 215, 215, 0) title:@"相关商品" font:14];
        labelC.textColor = RGBA(186, 186, 186, 1);
        labelC.textAlignment = NSTextAlignmentCenter;
        
        [goodView addSubview:labelC];
        [self.contentView addSubview:goodView];
        CGFloat height = CGRectGetMaxY(goodView.frame);
        CGFloat start = height + 10*kScreenWidthP;
        for (int i = 0; i<itemList.count; i++) {
            NSDictionary *dic = [itemList objectAtIndex:i];
            RelatedProductsView *relatedProductsView = [[RelatedProductsView alloc]initWithFrame:CGRectMake(0, start+(RelatedProductsH +space)*i, kScreenWidth, 100*kScreenWidthP)];
            relatedProductsView.itemContenDic = dic;
            relatedProductsView.delegate = self;
            relatedProductsView.backgroundColor = [UIColor whiteColor];
            [self addSubview:relatedProductsView];
        }
    }
    
}
+ (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes html:(NSString *)htmlStr
{
    // Load HTML data
    
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake(kScreenWidth - 20.0, kScreenHeight - 20.0);
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            NSLog(@"oneChildElement.text====%@",oneChildElement.name);
            NSString *str = [NSString stringWithFormat:@"%@",oneChildElement.name];
            if ([str isEqualToString:@"img"]) {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                
                oneChildElement.textAttachment.originalSize = CGSizeMake(kScreenWidth - 40*kScreenWidthP, 300);
                
            }else if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
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
    
    [options setObject:htmlStr forKey:NSTextSizeMultiplierDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    return string;
    
}

#pragma mark Custom Views on Text


- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTTextHTMLElement class]]) {
        NSLog(@"frame.size.height=%f,frame.origin.y=%f",frame.size.height,frame.origin.y);
        
    }
    if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        
        int width = (int)(kScreenWidth-40*kScreenWidthP);
        CGRect imageviewFrame = CGRectMake(frame.origin.x, frame.origin.y,(kScreenWidth-40*kScreenWidthP), 300);
        // if the attachment has a hyperlinkURL then this is currently ignored
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:imageviewFrame];
        imageView.delegate = self;
        [imageView setContentMode:UIViewContentModeRedraw];
        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];
        
        // url for deferred loading
        //        ?imageView2/1/w/%d/h/300
        NSString *imageUrl = [NSString stringWithFormat:@"%@",attachment.contentURL];
        NSRange range = [imageUrl rangeOfString:@"jpg"];
        NSString *urlImag;
        if (range.length > 0) {
            NSArray *array = [imageUrl componentsSeparatedByString:@"jpg"];
            if (array.count > 0) {
                urlImag = [NSString stringWithFormat:@"%@jpg?imageView2/1/w/%d/h/300",[array objectAtIndex:0],width];
            }
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlImag] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        //        imageView.url = attachment.contentURL;
        
        // if there is a hyperlink then add a link button on top of this image
        if (attachment.hyperLinkURL)
        {
            // NOTE: this is a hack, you probably want to use your own image view and touch handling
            // also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
            imageView.userInteractionEnabled = YES;
            
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
            button.GUID = attachment.hyperLinkGUID;
            
            // use normal push action for opening URL
            //            [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
            
            // demonstrate combination with long press
            //            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
            //            [button addGestureRecognizer:longPress];
            
            //            [imageView addSubview:button];
        }
        
        return imageView;
    }
    else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
    {
        DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
        videoView.attachment = attachment;
        
        return videoView;
    }
    else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
    {
        // somecolorparameter has a HTML color
        NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
        UIColor *someColor = DTColorCreateWithHTMLName(colorName);
        
        UIView *someView = [[UIView alloc] initWithFrame:frame];
        someView.backgroundColor = someColor;
        someView.layer.borderWidth = 1;
        someView.layer.borderColor = [UIColor blackColor].CGColor;
        
        someView.accessibilityLabel = colorName;
        someView.isAccessibilityElement = YES;
        
        return someView;
    }
    
    return nil;
}
- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];
    
    CGColorRef color = [textBlock.backgroundColor CGColor];
    if (color)
    {
        CGContextSetFillColorWithColor(context, color);
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextFillPath(context);
        
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokePath(context);
        return NO;
    }
    
    return YES; // draw standard background
}
#pragma mark - DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    
    BOOL didUpdate = NO;
    
    // update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [_lable.layoutFrame textAttachmentsWithPredicate:pred])
    {
        // update attachments that have no original size, that also sets the display size
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
        {
            oneAttachment.originalSize = imageSize;
            
            didUpdate = YES;
        }
    }
    
    if (didUpdate)
    {
        // layout might have changed due to image sizes
        [_lable relayoutText];
    }
}

- (void)addFloatingView:(NSDictionary *)dic{
    [self.delegate addFloatingView:dic];
}


// 弹出浮层
- (void)firgoodsTapGesture:(UITapGestureRecognizer *)tap{
    //    [self.delegate addFloatingView];
    
}
@end
