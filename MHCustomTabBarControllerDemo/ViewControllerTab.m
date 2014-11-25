//
//  ViewControllerTab.m
//  MHCustomTabBarControllerDemo
//
//  Created by Vienta on 14/11/22.
//  Copyright (c) 2014年 Martin Hartl. All rights reserved.
//

#import "ViewControllerTab.h"

@interface ViewControllerTab ()

@end

@implementation ViewControllerTab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tbvTab setContentInset:UIEdgeInsetsMake(0,0,56,0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHHHHHH" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HHHHHHH"];
        NSLog(@"cell %@", cell);
    }
    return cell;
}

@end
