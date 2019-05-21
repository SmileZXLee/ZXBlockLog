//
//  HttpResponse.h
//  ZXBlockLogDemo
//
//  Created by 李兆祥 on 2019/5/21.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpResponse : NSObject
- (instancetype)initWithDic:(NSDictionary *)dic;
@property (copy, readonly, nonatomic) NSString *data;
@property (assign, readonly, nonatomic) int code;
@end

NS_ASSUME_NONNULL_END
