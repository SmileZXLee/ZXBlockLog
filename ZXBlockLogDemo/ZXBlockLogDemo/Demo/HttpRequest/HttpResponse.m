//
//  HttpResponse.m
//  ZXBlockLogDemo
//
//  Created by 李兆祥 on 2019/5/21.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "HttpResponse.h"

@implementation HttpResponse
- (instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        _code = [dic[@"code"] intValue];
        _data = dic[@"data"];
    }
    return self;
}
@end
