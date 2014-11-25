//
//  ViewControllerTab.h
//  MHCustomTabBarControllerDemo
//
//  Created by Vienta on 14/11/22.
//  Copyright (c) 2014年 Martin Hartl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerTab : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvTab;

@end
