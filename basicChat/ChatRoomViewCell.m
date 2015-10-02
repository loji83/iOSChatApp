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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    
    if (self) {
    
        self.backgroundColor = [UIColor brownColor];
        [self setFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, 70)];

        
        self.pic = [[UIView alloc]init];
        [self.pic setFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        self.pic.backgroundColor = [UIColor yellowColor];
        
        
        self.textMessege = [[UILabel alloc]init];
        [self.textMessege setFrame:CGRectMake(self.frame.size.height , 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
        self.textMessege.backgroundColor = [UIColor orangeColor];
        
        
        [self addSubview:self.pic];
        [self addSubview:self.textMessege];
    }
  
    
    return self;
}

@end
