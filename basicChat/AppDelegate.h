//
//  AppDelegate.h
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) UIWindow *window;
@property UINavigationController* mainNav;
@property LoginViewController* logInViewController;

@end

