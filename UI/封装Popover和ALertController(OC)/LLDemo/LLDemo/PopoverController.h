//
//  PopoverController.h
//  LLDemo
//
//  Created by LuoLiu on 17/1/13.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverController : UIViewController

- (instancetype)initWithPreferredContentSize:(CGSize)preferredContentSize;
// 从某个View弹出
- (void)presentFromVC:(UIViewController *)controller rect:(CGRect)sourceRect inView:(UIView *)sourceView permittedArrowDirections:(UIPopoverArrowDirection)arrowDirection animated:(BOOL)animated completion:(void (^)(void))completion;
// 从某个UIBarButtonItem弹出
- (void)presentFromVC:(UIViewController *)controller barButtonItem:(UIBarButtonItem *)barButtonItem permittedArrowDirections:(UIPopoverArrowDirection)arrowDirection animated:(BOOL)animated completion:(void (^)(void))completion;

@end
