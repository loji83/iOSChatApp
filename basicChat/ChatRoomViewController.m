//
//  ChatRoomViewController.m
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import "ChatRoomViewController.h"

@implementation ChatRoomViewController
{
    float kbHeight;
}

@synthesize entireChat;
@synthesize textMessage;
@synthesize cell;
@synthesize dataArr;

//-(void) viewDidLoad
//{
//    
//}

-(void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"didLoad");
    self.title = @"ChatRoom";
    
    entireChat = [[UITableView alloc]init];
    entireChat.backgroundColor = [UIColor lightGrayColor];
    entireChat.rowHeight = 70;
    
    [entireChat setFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height*14/15)];
    NSLog(@"%@", [entireChat description]);
    [entireChat setDataSource:self];
    [entireChat setDelegate:self];
    
    textMessage = [[UITextField alloc]initWithFrame:CGRectMake(0, entireChat.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/15)];
    textMessage.backgroundColor = [UIColor blueColor];
    [textMessage setDelegate:self];
    
    dataArr = [[NSMutableArray alloc]init];
    [dataArr addObject:@"들어가라"];
    [dataArr addObject:@"제발"];
    [dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발"];[dataArr addObject:@"제발 좀~~~~"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:self.entireChat];
    [self.view addSubview:self.textMessage];
    NSLog(@"%f",entireChat.contentSize.height);
  
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if(entireChat.frame.size.height < entireChat.contentSize.height)
    {
        
        CGPoint offset = CGPointMake(0, entireChat.contentSize.height - entireChat.frame.size.height + self.navigationController.navigationBar.frame.size.height + 20);
        [entireChat setContentOffset:offset animated:YES];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(![textMessage.text isEqual:@""])
    {
    [dataArr addObject:textMessage.text];
    NSLog(@"%@",[dataArr description]);
    textMessage.text = @"";
    [entireChat reloadData];
    }
    [textMessage resignFirstResponder];
    
    return true;
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [dataArr count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell = [self.entireChat dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == NULL)
    {
        cell = [[ChatRoomViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textMessege.text = [dataArr objectAtIndex:indexPath.row];
    return cell;
}



-(void)keyboardShow:(NSNotification*) noti
{
    kbHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - kbHeight, self.view.frame.size.width, self.view.frame.size.height)];
}
-(void) keyboardHide:(NSNotificationCenter*) noti
{
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + kbHeight, self.view.frame.size.width, self.view.frame.size.height)];
}


-(void) viewWillDisappear:(BOOL)animated
{
    [self.textMessage resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    cell = nil;
    self.view = nil;
    
}

@end
