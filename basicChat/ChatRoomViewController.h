//
//  ChatRoomViewController.h
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <netdb.h>
#include <arpa/inet.h>

#import <UIKit/UIKit.h>
#import "ChatRoomViewCell.h"

@interface ChatRoomViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,  UITextFieldDelegate, NSStreamDelegate>

@property UITableView* entireChat;
@property UITextField* textMessage;
@property ChatRoomViewCell* cell;
@property NSMutableArray* dataArr;

@property NSString* chatName;
@property NSMutableArray* chatContent;
@property NSDateFormatter* dateFormat;

@property int server_sockfd;

@end
