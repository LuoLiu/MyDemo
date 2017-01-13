//
//  AlertController.h
//  LLDemo
//
//  Created by LuoLiu on 17/1/12.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIAlertController

// 单个按钮_文字固定为"OK"
+ (instancetype)AlertControllerWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *action))handler;
// 单个按钮_文字自定义
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle handler:(void (^)(UIAlertAction *action))handler;
// 两个按钮_文字固定为"OK"，“Cancel”
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler;
@end
