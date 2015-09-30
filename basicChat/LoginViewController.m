//
//  LoginViewController.m
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize enterChat;
@synthesize chatRoomController;

-(void) viewDidLoad
{
    
    self.title = @"Log in";
    self.view.backgroundColor = [UIColor redColor];
    
    enterChat = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    enterChat.center = self.view.center;
    enterChat.backgroundColor = [UIColor blueColor];
    [enterChat setTitle:@"Enter" forState:UIControlStateNormal];
    
    chatRoomController = [[ChatRoomViewController alloc]init];

    
    [self.view addSubview:enterChat];

    [self.enterChat addTarget:self action:@selector(enterChat:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)enterChat:(UIButton *)enterButton
{
    [[self navigationController] pushViewController:self.chatRoomController animated:true];
}


@end
