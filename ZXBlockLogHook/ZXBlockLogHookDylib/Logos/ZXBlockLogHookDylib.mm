#line 1 "/Users/lzx/Documents/GitHub/ZXBlockLog/ZXBlockLogHook/ZXBlockLogHookDylib/Logos/ZXBlockLogHookDylib.xm"


#import <UIKit/UIKit.h>
#import "ZXBlockLog.h"
@interface HttpResponse : NSObject

@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class HttpRequest; 
static void (*_logos_meta_orig$_ungrouped$HttpRequest$sendRequestWithData$callBack$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$HttpRequest$sendRequestWithData$callBack$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); 

#line 9 "/Users/lzx/Documents/GitHub/ZXBlockLog/ZXBlockLogHook/ZXBlockLogHookDylib/Logos/ZXBlockLogHookDylib.xm"


static void _logos_meta_method$_ungrouped$HttpRequest$sendRequestWithData$callBack$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    int(^kGetDataEventHandler) (int a) = ^int(int a){
        return 123;
    };
    NSLog(ZXBlockLog(kGetDataEventHandler));
    








    _logos_meta_orig$_ungrouped$HttpRequest$sendRequestWithData$callBack$(self, _cmd, arg1, arg2);
    
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$HttpRequest = objc_getClass("HttpRequest"); Class _logos_metaclass$_ungrouped$HttpRequest = object_getClass(_logos_class$_ungrouped$HttpRequest); MSHookMessageEx(_logos_metaclass$_ungrouped$HttpRequest, @selector(sendRequestWithData:callBack:), (IMP)&_logos_meta_method$_ungrouped$HttpRequest$sendRequestWithData$callBack$, (IMP*)&_logos_meta_orig$_ungrouped$HttpRequest$sendRequestWithData$callBack$);} }
#line 29 "/Users/lzx/Documents/GitHub/ZXBlockLog/ZXBlockLogHook/ZXBlockLogHookDylib/Logos/ZXBlockLogHookDylib.xm"
