//
//  ChatRoomViewController.h
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRoomViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property UITableView* entireChat;
@property UILabel* textMessage;

@end
