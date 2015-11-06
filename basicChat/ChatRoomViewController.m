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

@synthesize server_sockfd;

@synthesize chatName;



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
    
    [self.view addSubview:self.entireChat];
    [self.view addSubview:self.textMessage];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    dataArr = [[NSMutableArray alloc]init];
    
    
    //    for(int i = 0 ; i < 12; i++)
    //    {
    //
    //        NSString* combine = [NSString stringWithFormat:@"content : %d", i];
    //        [dataArr addObject:combine];
    //        NSLog(@"dummy data created...(%d)", i);
    //    }
    //    NSLog(@"%@", dataArr);
    
    
    
    
    if([dataArr count] > 0)
    {
        [self scrollToBottom];
    }
    
    
}

-(void)scrollToBottom
{
    NSLog(@"scroll action");
    [entireChat reloadData];
    NSLog(@"%@", [entireChat description]);
    NSIndexPath* ip = [NSIndexPath indexPathForRow: [entireChat numberOfRowsInSection:0]-1 inSection:0];
    NSLog(@"ip : %@, count : %d", ip, (int)[dataArr count]);
    
    
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return");
    
    
    
    
    if(![textMessage.text isEqual:@""])
    {
        
        [self sendContext:chatName andText:textField.text andTime:@"hh-mm-ss"];
        
        
        NSMutableArray* chatArray = [[NSMutableArray alloc]initWithCapacity:3];
        [chatArray addObject:chatName];
        [chatArray addObject:textMessage.text];
        [chatArray addObject:@"시간"];
        
        
        
        textMessage.text = @"";
    }
    
    [textMessage resignFirstResponder];
    
    return true;
}




-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count");
    
    return [dataArr count];
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"table");
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

-(int) sendContext : (NSString*) Username andText : (NSString*) chattext andTime : (NSString*)nowTime
{
    NSLog(@"sending");
    NSString* now = [NSString stringWithString:nowTime];

    const char* name = [chatName UTF8String];
    const char* text = [textMessage.text cStringUsingEncoding:NSUTF8StringEncoding];
    const char* time = [now cStringUsingEncoding:NSUTF8StringEncoding];
    
    printf("%lu",sizeof(&chatName));
    
    
    
    send(server_sockfd, name, sizeof(name), 0);
    printf("sizeof name : %lu\n", sizeof(name));
    memset((void*) name, 0x00, sizeof(name));
    read(server_sockfd, (void*)name, sizeof(name));
    
    send(server_sockfd, text, sizeof(text), 0);
    memset((void*) text, 0x00, sizeof(text));
    read(server_sockfd, (void*)text, sizeof(text));
    
    send(server_sockfd, time, sizeof(time), 0);
    printf("sizeof time : %lu\n", sizeof(time));
    printf("sizrof time : %lu\n", sizeof(&time));
    memset((void*) time, 0x00, sizeof(time));
    read(server_sockfd, (void*)time, sizeof(time));

    
    
    
    return 0;
}


-(void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"exit");
    
    [self.textMessage resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    

    //종료 메세지 전달
    
    [self sendContext:@"admin" andText:@"exit" andTime:@"hh-mm-ss"];


    close(server_sockfd);
    printf("socket close\n");
    cell = nil;
    self.view = nil;
    
}

-(int) connectServer : (NSString*) name
{
    struct sockaddr_in serveraddr;
    int client_len;
    
    chatName = name;
    
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
        return 1;
        
    };
    
    const char *message = [chatName cStringUsingEncoding:NSUTF8StringEncoding];
    
    if((send(server_sockfd, message, 1024, 0)) == -1)
    {
        printf("send error\n");
    }else{
        printf("send ok\n");
    };
    
    return 0;
    
}


@end
