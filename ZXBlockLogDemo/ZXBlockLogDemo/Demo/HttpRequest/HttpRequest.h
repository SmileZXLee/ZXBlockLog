//
//  HttpRequest.h
//  ZXBlockLogDemo
//
//  Created by 李兆祥 on 2019/5/21.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponse.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^kGetDataEventHandler) (BOOL result, HttpResponse *data);
@interface HttpRequest : NSObject
+ (void)sendRequestWithData:(NSDictionary *)data callBack:(kGetDataEventHandler)callBack;
@end

NS_ASSUME_NONNULL_END
