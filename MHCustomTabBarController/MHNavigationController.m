//
//  MHNavigationController.m
//  MHCustomTabBarControllerDemo
//
//  Created by Vienta on 14/11/22.
//  Copyright (c) 2014年 Martin Hartl. All rights reserved.
//

#import "MHNavigationController.h"

NSString *const MHNavigationControllerViewControllerWillShowNotification = @"kMHNavigationControllerViewControllerWillShowNotification";
NSString *const MHNavigationControllerViewControllerDidShowNotification = @"kMHNavigationControllerViewControllerDidShowNotification";

@interface MHNavigationController ()

@end

@implementation MHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    self.delegate = (id)self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"~~~~~~~~~~~~will show:%@", viewController);
    [[NSNotificationCenter defaultCenter] postNotificationName:MHNavigationControllerViewControllerWillShowNotification object:viewController];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"~~~~~~~~~~~~did show:%@", viewController);
    [[NSNotificationCenter defaultCenter] postNotificationName:MHNavigationControllerViewControllerDidShowNotification object:viewController];
}
/*
- (NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    NSLog(@"~~~~~~~~~~~~%s", __PRETTY_FUNCTION__);
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    NSLog(@"~~~~~~~~~~~~%s", __PRETTY_FUNCTION__);
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    NSLog(@"~~~~~~~~~~~~%s", __PRETTY_FUNCTION__);
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    NSLog(@"~~~~~~~~~~~~%s", __PRETTY_FUNCTION__);
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
