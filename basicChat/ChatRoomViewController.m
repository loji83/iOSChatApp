//
//  ChatRoomViewController.m
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import "ChatRoomViewController.h"

@implementation ChatRoomViewController

@synthesize entireChat;
@synthesize textMessage;
@synthesize cell;
@synthesize dataArr;



-(void) viewDidLoad
{
    NSLog(@"%d", (int)self.view.frame.size.width);
    NSLog(@"%d", (int)self.view.frame.size.height);

    self.title = @"ChatRoom";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    entireChat = [[UITableView alloc]init];
    entireChat.backgroundColor = [UIColor lightGrayColor];
    entireChat.rowHeight = 90;
    [entireChat setFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height*14/15)];
    [entireChat setDataSource:self];
    [entireChat setDelegate:self];
 
    textMessage = [[UITextField alloc]initWithFrame:CGRectMake(0, entireChat.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/15)];
    textMessage.backgroundColor = [UIColor blueColor];
    
    
    [self.view addSubview:self.entireChat];
    [self.view addSubview:self.textMessage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
}

-(void)keyboardShow:(NSNotification*) noti
{
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 100, self.view.frame.size.width, self.view.frame.size.height)];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (ChatRoomViewCell*)[self.entireChat dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == NULL)
    {
        cell = [[ChatRoomViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textMessege.text = @"adfgdfgdfgdfgdfhfgjdfgjdtsrtdrtsfdfsfadfgdfgdfgdfgdfhfgjdfgjdtsrtdrtsfdfsf";
    return cell;
}


-(void) viewWillDisappear:(BOOL)animated
{
    cell = nil;
}

@end
