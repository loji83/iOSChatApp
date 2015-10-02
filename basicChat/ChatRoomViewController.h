//
//  ChatRoomViewController.h
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatRoomViewCell.h"

@interface ChatRoomViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,  UITextFieldDelegate>

@property UITableView* entireChat;
@property UITextField* textMessage;
@property ChatRoomViewCell* cell;
@property NSMutableArray* dataArr;

@end
