//
//  ViewController.m
//  ZXBlockLogDemo
//
//  Created by 李兆祥 on 2019/5/20.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ViewController.h"
#import "ZXShowInputView.h"
#import "HttpRequest.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZXShowInputView *view = [ZXShowInputView show];
    __weak typeof(self) weakSelf = self;
    view.confirmBlock = ^BOOL(NSString *data) {
        [HttpRequest sendRequestWithData:@{@"data":data} callBack:^(BOOL result, HttpResponse * _Nonnull data) {
            weakSelf.dataLabel.text = data.data;
        }];
        return YES;
    };
}
@end
