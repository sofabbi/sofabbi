//
//  PETexttInputPanelView.m
//  Fabbi
//
//  Created by zou145688 on 16/6/8.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "PETexttInputPanelView.h"


@interface PETexttInputPanelView()<UITextViewDelegate>

@property (nonatomic) NSInteger selectedLocation;
@end

@implementation PETexttInputPanelView
@synthesize textContentHeight;
@synthesize commentTextView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(230, 230, 230, 1);
        commentTextView = [[UITextView alloc]initWithFrame:CGRectMake(11.f*kScreenWidthP, 9.f*kScreenWidthP,kScreenWidth - 70.f*kScreenWidthP, kMinorHeight)];
        commentTextView.editable = YES;
        commentTextView.delegate = self;
        commentTextView.returnKeyType = UIReturnKeySend;
        commentTextView.backgroundColor = [UIColor whiteColor];
        commentTextView.layer.cornerRadius = 4.f;
        commentTextView.layer.borderColor = [UIColor colorWithRed:204.f/255.f green:204.f/255.f blue:204.f/255.f alpha:1.f].CGColor;
        commentTextView.layer.borderWidth = 1.f;
        if ([commentTextView respondsToSelector:@selector(textContainerInset)]) {
            commentTextView.textContainerInset = UIEdgeInsetsMake(5.0f, 3.0f, 5.0f, 23.0f);
        }
        
        commentTextView.font = [UIFont systemFontOfSize:15.0f];
        commentTextView.scrollEnabled = YES;
        [commentTextView setScrollsToTop:NO];
        [self addSubview:commentTextView];
        
        UIButton *bt_send = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 55.f, 0., 50., 49.)];
        [bt_send setTitle:@"发送" forState:UIControlStateNormal];
        [bt_send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt_send.titleLabel setFont:[UIFont systemFontOfSize:16.]];
        [bt_send addTarget:self action:@selector(tapSendAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt_send];
    }
    return self;
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"textViewDidBeginEditing");
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        
        [self tapSendAction];
        [textView resignFirstResponder];
        
        NSString *commentContent = commentTextView.text;
        if (commentContent.length > 0) {
            [textView resignFirstResponder];
            [self.delegate sendContent:commentContent];
            commentTextView.text = @"";
        }
        
        return NO;
    }
    return YES;
}



- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect frame = textView.frame;
    textContentHeight = MAX(kMinorHeight, textView.contentSize.height);
    textContentHeight = MIN(80.f, textContentHeight);
    frame.size.height = textContentHeight;
    textView.frame = frame;
    
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        [textView setContentOffset:offset];
    }
    
    //    NSLog(@"zzzz=%zd",textView.selectedRange.location);
    if (textView.selectedRange.location >= textView.text.length) {
        CGPoint bottomOffset = CGPointMake(0, textView.contentSize.height - textView.frame.size.height);
        //    [textView setContentOffset: CGPointMake(0,0) animated:NO];
        [textView setContentOffset:bottomOffset animated:YES];
        
    }
    
    if (self.delegate)
    {
        [self.delegate updateFrameWithContentHeight:textContentHeight];
    }
    
    
}


#pragma mark - 发送
- (void)tapSendAction
{
    textContentHeight = kMinorHeight;
    [commentTextView resignFirstResponder];
    NSString *commentContent = commentTextView.text;
    if (commentContent.length > 0)
    {
        [self.delegate sendContent:commentContent];
        commentTextView.text = @"";
    }
    //重置textview高度
    CGRect frame = commentTextView.frame;
    frame.size.height = kMinorHeight;
    commentTextView.frame = frame;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    [commentTextView resignFirstResponder];
}

@end

