//
//  PopoverController.m
//  LLDemo
//
//  Created by LuoLiu on 17/1/13.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

#import "PopoverController.h"

@interface PopoverController ()

@end

@implementation PopoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
    }
    return self;
}

- (instancetype)initWithPreferredContentSize:(CGSize)preferredContentSize {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.preferredContentSize = preferredContentSize;
    }
    
    return self;
}

- (void)presentFromVC:(UIViewController *)controller rect:(CGRect)sourceRect inView:(UIView *)sourceView permittedArrowDirections:(UIPopoverArrowDirection)arrowDirection animated:(BOOL)animated completion:(void (^)(void))completion {
    
    UIPopoverPresentationController *presentationController = [self popoverPresentationController];
    presentationController.permittedArrowDirections = arrowDirection;
    presentationController.sourceView = sourceView;
    presentationController.sourceRect = sourceRect;

    [controller presentViewController:self animated: animated completion: completion];
}

- (void)presentFromVC:(UIViewController *)controller barButtonItem:(UIBarButtonItem *)barButtonItem permittedArrowDirections:(UIPopoverArrowDirection)arrowDirection animated:(BOOL)animated completion:(void (^)(void))completion {
    
    UIPopoverPresentationController *presentationController = [self popoverPresentationController];
    presentationController.permittedArrowDirections = arrowDirection;
    presentationController.barButtonItem = barButtonItem;

    [controller presentViewController:self animated: animated completion: completion];
}

@end
