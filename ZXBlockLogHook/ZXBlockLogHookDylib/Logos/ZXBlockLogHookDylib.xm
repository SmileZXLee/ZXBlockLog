// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "ZXBlockLog.h"
@interface HttpResponse : NSObject

@end

%hook HttpRequest

+ (void)sendRequestWithData:(id)arg1 callBack:(void(^)(BOOL,HttpResponse *))arg2{
    arg2 = ^void(BOOL arg3,HttpResponse *arg4) {
        Class cls = NSClassFromString(@"HttpResponse");
        id resp = [cls new];
        [resp setValue:@200 forKey:@"code"];
        [resp setValue:[NSString stringWithFormat:@"[hooked]%@",[arg4 valueForKey:@"data"]]forKey:@"data"];
        arg2(YES,resp);
    };
    %orig;
    
}
%end
