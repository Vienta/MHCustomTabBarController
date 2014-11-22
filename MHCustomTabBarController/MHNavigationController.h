//
//  MHNavigationController.h
//  MHCustomTabBarControllerDemo
//
//  Created by Vienta on 14/11/22.
//  Copyright (c) 2014年 Martin Hartl. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const MHNavigationControllerViewControllerWillShowNotification;
extern NSString *const MHNavigationControllerViewControllerDidShowNotification;

@interface MHNavigationController : UINavigationController<UINavigationControllerDelegate>

@end
