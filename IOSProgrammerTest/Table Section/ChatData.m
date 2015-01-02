//
//  ChatData.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/19/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatData.h"

@implementation ChatData
- (void)loadWithDictionary:(NSDictionary *)dict
{
    self.user_id = [[dict objectForKey:@"user_id"] intValue];
    self.username = [dict objectForKey:@"username"];
    self.avatar_url = [dict objectForKey:@"avatar_url"];
    self.message = [dict objectForKey:@"message"];
    
    NSURL *imageURL = [NSURL URLWithString:_avatar_url];
    
    if (imageURL) {
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        
        self.avatar = [[UIImage alloc]initWithData:data] ;
    }
    



}
@end
