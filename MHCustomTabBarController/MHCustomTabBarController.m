/*
 * Copyright (c) 2013 Martin Hartl
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "MHCustomTabBarController.h"
#import "MHNavigationController.h"

#import "MHTabBarSegue.h"

NSString *const MHCustomTabBarControllerViewControllerChangedNotification = @"MHCustomTabBarControllerViewControllerChangedNotification";
NSString *const MHCustomTabBarControllerViewControllerAlreadyVisibleNotification = @"MHCustomTabBarControllerViewControllerAlreadyVisibleNotification";

@interface MHCustomTabBarController ()

@property (nonatomic, strong) NSMutableDictionary *viewControllersByIdentifier;

@end

@implementation MHCustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllersByIdentifier = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewController:) name:MHTabBarControllerViewControllerPushNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewController:) name:MHTabBarControllerViewControllerPopNotification object:nil];
}

- (void)pushViewController:(NSNotification *)noti
{
    UIViewController *notiViewController = noti.object;
    MHNavigationController *nav = (MHNavigationController *)self.destinationViewController;
    UIViewController *rootViewController = [[nav viewControllers] objectAtIndex:0];
    if (![notiViewController isEqual:rootViewController]) {
        if (self.tabbar.superview) {
            [self.tabbar removeFromSuperview];
        }
        [rootViewController.view addSubview:self.tabbar];
    }
    [self tabbarConstraint];
}

- (void)popViewController:(NSNotification *)noti
{
    MHNavigationController *nav = (MHNavigationController *)self.destinationViewController;
    if ([[nav viewControllers] count] <= 1) {
        if (self.tabbar.superview) {
            [self.tabbar removeFromSuperview];
        }
        [self.view addSubview:self.tabbar];
    }
    [self tabbarConstraint];
}

void cleanReoveFromSuperView(UIView *view)
{
    if (!view || !view.superview) {
        return;
    }
    
    NSMutableArray *constraintsToRemove = [NSMutableArray arrayWithCapacity:0];
    UIView *superView = view.superview;
    
    for (NSLayoutConstraint *constraint in superView.constraints) {
        if (constraint.firstItem == view || constraint.secondItem == view) {
            [constraintsToRemove addObject:constraint];
        }
    }
    [superView removeConstraints:constraintsToRemove];
    
    [view removeFromSuperview];
}

- (void)tabbarConstraint
{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        if (self.tabbar.superview) {
            self.tabbar.translatesAutoresizingMaskIntoConstraints = NO;
            NSString *constraintHStr = @"H:|-0-[_tabbar]-0-|";
            NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:constraintHStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tabbar)];
            [self.tabbar.superview addConstraints:constraintH];
            
            NSString *constraintVStr = @"V:[_tabbar(==49)]-0-|";
            NSArray *constrintV = [NSLayoutConstraint constraintsWithVisualFormat:constraintVStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tabbar)];
            [self.tabbar.superview addConstraints:constrintV];
        }
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.childViewControllers.count < 1) {
        [self performSegueWithIdentifier:@"viewController1" sender:[self.buttons objectAtIndex:0]];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.destinationViewController.view.frame = self.container.bounds;
}



#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (![segue isKindOfClass:[MHTabBarSegue class]]) {
        [super prepareForSegue:segue sender:sender];
        return;
    }
    
    self.oldViewController = self.destinationViewController;
    
    //if view controller isn't already contained in the viewControllers-Dictionary
    if (![self.viewControllersByIdentifier objectForKey:segue.identifier]) {
        [self.viewControllersByIdentifier setObject:segue.destinationViewController forKey:segue.identifier];
    }
    
    for (UIButton *aButton in self.buttons) {
        [aButton setSelected:NO];
    }
    
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    self.destinationIdentifier = segue.identifier;
    self.destinationViewController = [self.viewControllersByIdentifier objectForKey:self.destinationIdentifier];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MHCustomTabBarControllerViewControllerChangedNotification object:nil];
    
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([self.destinationIdentifier isEqual:identifier]) {
        //Dont perform segue, if visible ViewController is already the destination ViewController
        [[NSNotificationCenter defaultCenter] postNotificationName:MHCustomTabBarControllerViewControllerAlreadyVisibleNotification object:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [[self.viewControllersByIdentifier allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        if (![self.destinationIdentifier isEqualToString:key]) {
            [self.viewControllersByIdentifier removeObjectForKey:key];
        }
    }];
    [super didReceiveMemoryWarning];
}

@end
