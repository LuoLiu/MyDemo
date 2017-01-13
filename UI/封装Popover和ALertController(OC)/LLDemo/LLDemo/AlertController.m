//
//  AlertController.m
//  LLDemo
//
//  Created by LuoLiu on 17/1/12.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@end

@implementation AlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 单个按钮_文字固定为"OK"
+ (instancetype)AlertControllerWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *action))handler {
    
    AlertController *alert = [AlertController alertControllerWithTitle:title
                                                               message:message
                                                           buttonTitle:@"OK"
                                                               handler:handler];

    return alert;
}

// 单个按钮_文字自定义
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle handler:(void (^)(UIAlertAction *action))handler {
    
    AlertController *alert = [AlertController alertControllerWithTitle:title
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle
                                                     style:UIAlertActionStyleDefault
                                                   handler:handler];
    [alert addAction:action];
    
    return alert;
}

// 两个按钮_文字固定为"OK"，“Cancel”
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler {
    
    AlertController *alert = [AlertController alertControllerWithTitle:title
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:confirmHandler];
    [alert addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelHandler];
    [alert addAction:cancelAction];
    
    return alert;
}

@end
