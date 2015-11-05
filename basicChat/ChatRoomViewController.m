//
//  ChatRoomViewController.m
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import "ChatRoomViewController.h"

#import <errno.h>

@implementation ChatRoomViewController
{
    float kbHeight;
}

@synthesize entireChat;
@synthesize textMessage;
@synthesize cell;
@synthesize dataArr;

@synthesize dateFormat;

@synthesize server_sockfd;

@synthesize chatName;
@synthesize chatContent;



-(void) viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"didLoad");
    
    self.title = @"ChatRoom";
    
    entireChat = [[UITableView alloc]init];
    entireChat.backgroundColor = [UIColor lightGrayColor];
    entireChat.rowHeight = 70;
    
    [entireChat setFrame:CGRectMake(0,0,self.view.frame.size.width, (self.view.frame.size.height*14/15))];
    [entireChat setDataSource:self];
    [entireChat setDelegate:self];
    
    textMessage = [[UITextField alloc]initWithFrame:CGRectMake(0, entireChat.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/15)];
    textMessage.backgroundColor = [UIColor blueColor];
    [textMessage setDelegate:self];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy MM dd, hh mm ss"];
    
    [self.view addSubview:self.entireChat];
    [self.view addSubview:self.textMessage];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [self connectServer];
    
    NSLog(@"my Name : %@", self.chatName);
    
    dataArr = [[NSMutableArray alloc]init];
    chatContent = [[NSMutableArray alloc]init];
    
    for(int i = 0 ; i < 12; i++)
    {
      
        NSString* a = @"내용";
        NSString* combine = [NSString stringWithFormat:@"%@ %d", a, i];
    
        [chatContent addObject:chatName];
        [chatContent addObject:combine];
        NSString* date = [dateFormat stringFromDate:[NSDate date]];
        [chatContent addObject:date];
        NSLog(@"%@", chatContent);
        [dataArr addObject:chatContent];
        NSLog(@"%@", dataArr);
    }
    
    NSLog(@"%@", dataArr);
    
//    [dataArr addObject:@"들어가라"];
//    [dataArr addObject:@"제발1"];
//    [dataArr addObject:@"제발2"];
//    [dataArr addObject:@"제발3"];
//    [dataArr addObject:@"제발4"];
//    [dataArr addObject:@"제발5"];
//    [dataArr addObject:@"제발6"];
//    [dataArr addObject:@"제발7"];
//    [dataArr addObject:@"제발8"];
//    [dataArr addObject:@"제발9"];
//    [dataArr addObject:@"제발10"];
//    [dataArr addObject:@"제발11"];
//    [dataArr addObject:@"제발12"];
//    [dataArr addObject:@"제발 좀~~~~"];
    
    [self scrollToBottom];
    
}

-(void)scrollToBottom
{
    [entireChat reloadData];
    NSIndexPath* ip = [NSIndexPath indexPathForRow: [entireChat numberOfRowsInSection:0]-1 inSection:0];
    [entireChat scrollToRowAtIndexPath:ip  atScrollPosition:UITableViewScrollPositionTop animated:true];
    
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    if(![textMessage.text isEqual:@""])
    {
        [chatContent addObject:chatName];
        [chatContent addObject:textField.text];
        NSString* date = [dateFormat stringFromDate:[NSDate date]];
        [chatContent addObject:date];

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
    close(server_sockfd);
    printf("socket close\n");
    cell = nil;
    self.view = nil;
    
}

-(void) connectServer
{
    struct sockaddr_in serveraddr;
    int client_len;
    
    
    if((server_sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1)
    {
        printf("socket error\n");
    }
    
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_addr.s_addr = inet_addr("192.168.0.23");
    serveraddr.sin_port = htons(8000);
    
    client_len = sizeof(serveraddr);
    
    if((connect(server_sockfd, (struct sockaddr*) &serveraddr, client_len)) == 0)
    {
        printf("connect complete\n");
    }else
    {
        printf("connect fail\n");
    };
    
    char message[1024] = "dfghdfg";
    
    if((send(server_sockfd, message, 1024, 0)) == -1)
    {
        printf("send error\n");
    }else{
        printf("send ok\n");
    };
    
}


@end
