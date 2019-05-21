//
//  ZXShowImgView.h
//  ZXHookUtilDemoDylib
//
//  Created by 李兆祥 on 2019/3/11.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXShadowView.h"

@interface ZXShowInputView : ZXShadowView
+ (instancetype)show;
@property(nonatomic,copy)BOOL(^confirmBlock)(NSString *data);
@end
