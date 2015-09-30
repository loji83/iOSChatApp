//
//  LoginViewController.h
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatRoomViewController.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic)UIButton* enterChat;
@property (strong, nonatomic)ChatRoomViewController* chatRoomController;

-(void) enterChat:(UIButton*)enterButton;

@end
