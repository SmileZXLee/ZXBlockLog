//
//  ZXShowImgView.m
//  ZXHookUtilDemoDylib
//
//  Created by 李兆祥 on 2019/3/11.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXShowInputView.h"
@interface ZXShowInputView()

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end
@implementation ZXShowInputView

+ (instancetype)view{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}
+ (instancetype)show{
    ZXShowInputView *view = [self view];
    [view show];
    [view.inputTextView becomeFirstResponder];
    return view;
}
- (IBAction)confirmAction:(id)sender {
    if(!self.inputTextView.text.length){
        return;
    }
    if(self.confirmBlock){
        BOOL close = self.confirmBlock(self.inputTextView.text);
        if(close){
           [self disMiss];
        }
    }else{
        [self disMiss];
    }
    
}

@end
