//
//  HttpRequest.m
//  ZXBlockLogDemo
//
//  Created by 李兆祥 on 2019/5/21.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "HttpRequest.h"
@implementation HttpRequest
+ (void)sendRequestWithData:(NSDictionary *)data callBack:(kGetDataEventHandler)callBack{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HttpResponse *resp = [[HttpResponse alloc]initWithDic:@{@"code":@200,@"data":data[@"data"]}];
        callBack(YES,resp);
    });
}
@end
