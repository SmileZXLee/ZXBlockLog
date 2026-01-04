# ZXBlockLog
### 前言
* 此项目归属于[ZXHookDetection](https://github.com/SmileZXLee/iOSSignatureAnalysis)，仅限用于帮助iOS开发者从攻击者角度分析自己的应用，从而可以对自己的应用进行针对性的防护和检测，禁止用于任何其他用途！！！
  
### 基于[CTObjectiveCRuntimeAdditions](https://github.com/ebf/CTObjectiveCRuntimeAdditions)
### 如何使用
* 导入ZXBlockLog
```objective-c
#import "ZXBlockLog.h"
```
* 打印Block参数与返回值
```objective-c
NSLog(ZXBlockLog(block));
```
### 使用Demo场景示例&捕获并修改block参数演示
#### 功能&需求
* 目标App主要功能:点击目标App界面，会弹出一个输入框，输入任意内容，模拟提交给服务器(默认提交什么内容，返回什么内容)返回结果并显示在当前页面上
* hook目的:拦截网络请求block，分析block内部参数并修改
* 原功能示例
<img src="http://www.zxlee.cn/blocklogdemo/blocklogdemo5.gif"/>

#### 分析
* 使用class-dump导出目标App的头文件
* 查看HttpRequest.h
```objective-c
#import "NSObject.h"
@interface HttpRequest : NSObject
{
}
+ (void)sendRequestWithData:(id)arg1 callBack:(CDUnknownBlockType)arg2;
@end
```
由于class-dump无法解析block，因此显示为CDUnknownBlockType

* 编写tweak，hook HttpRequest的+ (void)sendRequestWithData:(id)arg1 callBack:(CDUnknownBlockType)arg2方法
```objective-c
#import <UIKit/UIKit.h>
#import "ZXBlockLog.h"
//block的本质是结构体，此处CDUnknownBlockType修改id类型即可
%hook HttpRequest
+ (void)sendRequestWithData:(id)arg1 callBack:(id)arg2{
    //打印block
    NSLog(ZXBlockLog(arg2));
    %orig;
}
%end
```
* 查看打印结果，`[Block声明]`可以认为是block的声明写法，`[Block实现]`可以认为是block的实现写法，此处打印出来可以省去重新写的时间
```c
2019-05-21 21:53:33.281180+0800 ZXBlockLogDemo[62025:5648976] 
----------------------[ZXBlockLogStart]----------------------
[Block声明]void(^)(BOOL,HttpResponse *)
[Block实现]^void(BOOL arg1,HttpResponse *arg2)
-----------------------[ZXBlockLogEnd]-----------------------
```
* 现在我们清楚了block的内部构造，这个block的返回值是void，有BOOL和HttpResponse两个参数类型，开始恢复block，直接复制[Block声明]后的代码代替原位置的id即可
```objective-c
#import <UIKit/UIKit.h>
#import "ZXBlockLog.h"
@class HttpResponse;
%hook HttpRequest
+ (void)sendRequestWithData:(id)arg1 callBack:(void(^)(BOOL,HttpResponse *))arg2{
    %orig;
}
%end
```
* 查看HttpResponse.h头文件
```objective-c
#import "NSObject.h"
@class NSString;
@interface HttpResponse : NSObject
{
    int _code;
    NSString *_data;
}
@property(readonly, nonatomic) int code; // @synthesize code=_code;
@property(readonly, copy, nonatomic) NSString *data; // @synthesize data=_data;
- (void).cxx_destruct;
- (id)initWithDic:(id)arg1;
@end
```
可见HttpResponse中有code和data两个属性，可以直接hook - (id)initWithDic:(id)arg1达到修改返回信息的目的，此例为演示block参数修改，因此不使用此方法

* 完善sendRequestWithData函数内部信息，若需要统一将所有的响应信息修改为"hooked"
```objective-c
%hook HttpRequest
+ (void)sendRequestWithData:(id)arg1 callBack:(void(^)(BOOL,HttpResponse *))arg2{
    Class cls = NSClassFromString(@"HttpResponse");
    id resp = [cls new];
    [resp setValue:@200 forKey:@"code"];
    [resp setValue:@"hooked" forKey:@"data"];
    arg2(YES,resp);
}
%end
```
* 查看效果
<img src="http://www.zxlee.cn/blocklogdemo/blocklogdemo3.gif"/>

* 继续完善，若需要在原先的响应信息的前面加上"[hooked]"字符串,直接复制`[Block实现]`即为block实现的写法，我们实现这个block，并在block的实现中获取%orig中原block传递进来的参数，拼接之后传给arg2，达到修改block参数的目的，block的调用实质是调用block指向的函数地址对应的函数，并传递相关参数。
```objective-c
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
```
* 查看效果
<img src="http://www.zxlee.cn/blocklogdemo/blocklogdemo4.gif"/>

#### 至此，我们达到了捕获block内部参数并修改的目的



