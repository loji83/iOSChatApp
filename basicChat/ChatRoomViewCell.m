//
//  ChatRoomViewCell.m
//  basicChat
//
//  Created by Kang on 2015. 9. 30..
//  Copyright © 2015년 Kang. All rights reserved.
//

#import "ChatRoomViewCell.h"

@implementation ChatRoomViewCell

@synthesize pic, textMessege;

-(ChatRoomViewCell*) init
{
    
    ChatRoomViewCell* cell = [[ChatRoomViewCell alloc]initWithFrame:CGRectMake(0,0, self.window.frame.size.width, 160)];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
    
}

@end
