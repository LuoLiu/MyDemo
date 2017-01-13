//
//  ViewController.m
//  LLDemo
//
//  Created by LuoLiu on 17/1/12.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

#import "ViewController.h"
#import "AlertController.h"
#import "PopoverController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)okAlert:(id)sender {
    AlertController *alert = [AlertController AlertControllerWithTitle:@"My Alert"
                                                               message:@"This is an alert."
                                                               handler:^(UIAlertAction *action) {
        NSLog(@"OK Action");
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)customSingleAlert:(id)sender {
    AlertController *alert = [AlertController alertControllerWithTitle:@"My Alert"
                                                               message:@"This is an alert."
                                                           buttonTitle:@"Custom"
                                                               handler:^(UIAlertAction *action) {
        NSLog(@"Custom Action");
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)defaultAlert:(id)sender {
    AlertController *alert = [AlertController alertControllerWithTitle:@"My Alert"
                                                               message:@"This is an alert."
                                                        confirmHandler:^(UIAlertAction *action) {
                                                            NSLog(@"Confirm Alert");
                                                        }
                                                         cancelHandler:^(UIAlertAction *action) {
                                                             NSLog(@"Cancel Alert");
                                                         }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)popFromBarItem:(id)sender {
    
    PopoverController *popVC = [[PopoverController alloc] init];
    
    UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
    [popVC presentFromVC:self
           barButtonItem:barButtonItem
permittedArrowDirections:UIPopoverArrowDirectionUp
                animated:YES
              completion:nil];
}

- (IBAction)popFromButton:(id)sender {
    
    PopoverController *popVC = [[PopoverController alloc] initWithPreferredContentSize:CGSizeMake(150, 50)];
    
    UIView *sourceView = (UIView *)sender;
    CGRect sourceRect = CGRectMake(0, 0, sourceView.frame.size.width, sourceView.frame.size.height);
    
    [popVC presentFromVC:self
                    rect:sourceRect
                  inView:sourceView
permittedArrowDirections:UIPopoverArrowDirectionDown
                animated:YES
              completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
