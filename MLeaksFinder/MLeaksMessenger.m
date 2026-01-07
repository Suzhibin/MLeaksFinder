/**
 * Tencent is pleased to support the open source community by making MLeaksFinder available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *
 * https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 */

#import "MLeaksMessenger.h"
static __weak UIAlertView *alertView;
@implementation UIViewController (TopMostViewController)
+ (UIViewController *)obtainCurrentUIViewController {
    UIViewController *var;
    var = [self configUIViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (var.presentedViewController) {
        var = [self configUIViewController:var.presentedViewController];
    }
    
    return var;
}

+ (UIViewController *)configUIViewController:(UIViewController *)var {
    if ([var isKindOfClass:[UINavigationController class]]) {
        return [self configUIViewController:[(UINavigationController *)var topViewController]];
    } else if ([var isKindOfClass:[UITabBarController class]]) {
        return [self configUIViewController:[(UITabBarController *)var selectedViewController]];
    } else {
        return var;
    }
    return nil;
}
+ (UIViewController *)currentViewController
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [rootVC topMostViewController];
}

- (UIViewController *)topMostViewController
{
    if (self.presentedViewController == nil)
    {
        return self;
    }
    else if ([self.presentedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)self.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [lastViewController topMostViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)self.presentedViewController;
    return [presentedViewController topMostViewController];
}
@end
@implementation MLeaksMessenger

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    [self alertWithTitle:title message:message delegate:nil additionalButtonTitle:nil];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
              delegate:(id<UIAlertViewDelegate>)delegate
 additionalButtonTitle:(NSString *)additionalButtonTitle {
//    [alertView dismissWithClickedButtonIndex:0 animated:NO];
//    UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:title
//                                                            message:message
//                                                           delegate:delegate
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:additionalButtonTitle, nil];
//    [alertViewTemp show];
//    alertView = alertViewTemp;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }]];

    [[UIViewController obtainCurrentUIViewController] presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"MLeaksMessenger -- %@: %@: %@", title, message,additionalButtonTitle);
}

@end

