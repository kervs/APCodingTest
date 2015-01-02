//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"
#import <QuartzCore/CALayer.h>

@interface ChatCell ()
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@end

@implementation ChatCell

- (void)awakeFromNib
{
    // Initialization code
    self.messageTextView.editable = NO;
    self.profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/1.75;
    self.profileImageView.clipsToBounds = YES;
    
}

- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    
    self.profileImageView.image = chatData.avatar;

    
}
@end
