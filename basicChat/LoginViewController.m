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
@synthesize userName;
@synthesize chatRoomController;
@synthesize totalLoginView;

-(void) viewDidLoad
{
    
    self.title = @"Log in";
    self.view.backgroundColor = [UIColor redColor];
    
    
    totalLoginView = [[UIView alloc]initWithFrame:CGRectMake(
                                                              self.view.frame.size.width/6,
                                                              self.view.frame.size.height/3,
                                                              self.view.frame.size.width*2/3,
                                                              self.view.frame.size.height/5)
                      ];
    
    
    userName = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, totalLoginView.frame.size.width, totalLoginView.frame.size.height/3)];

    userName.backgroundColor = [UIColor lightGrayColor];
    
    
    enterChat = [[UIButton alloc]initWithFrame:CGRectMake(totalLoginView.frame.size.width/3, totalLoginView.frame.size.height*2/3, totalLoginView.frame.size.width/3, totalLoginView.frame.size.height/3)];
    enterChat.backgroundColor = [UIColor blueColor];
    [enterChat setTitle:@"Enter" forState:UIControlStateNormal];
    
    chatRoomController = [[ChatRoomViewController alloc]init];
    
    [self.view addSubview:totalLoginView];
    [totalLoginView addSubview:enterChat];
    [totalLoginView addSubview:userName];

    [self.enterChat addTarget:self action:@selector(enterChat:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [userName resignFirstResponder];
    return true;
}



-(void)enterChat:(UIButton *)enterButton
{
    [userName resignFirstResponder];
    if([userName.text isEqualToString:@""])
    {
        NSLog(@"이름을 입력해주세요");
        return;
    }
    if([chatRoomController connectServer : userName.text] != 0)
    {
        return;
    };
    
    [[self navigationController] pushViewController:chatRoomController animated:true];
    
}


@end
