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

-(void) viewDidLoad
{
    
    self.title = @"ChatRoom";
    
    self.view.backgroundColor = [UIColor greenColor];
    //self.view.frame = [UIScreen mainScreen].bounds;
    
    entireChat = [[UITableView alloc]init];
    entireChat.backgroundColor = [UIColor lightGrayColor];
    [entireChat setFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height*14/15)];
    [entireChat setDataSource:self];
    [entireChat setDelegate:self];
 
    textMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, entireChat.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/15)];
    textMessage.backgroundColor = [UIColor blueColor];
    
 
    [self.view addSubview:self.entireChat];
    [self.view addSubview:self.textMessage];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

 
    
    cell = (ChatRoomViewCell*)[self.entireChat dequeueReusableCellWithIdentifier:@"Cell"];
   
    if(cell == NULL)
    {
        cell = [[ChatRoomViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textMessege.text = @"adsf";
    
    return cell;
}


-(void) viewWillDisappear:(BOOL)animated
{
    cell = nil;
}

@end
