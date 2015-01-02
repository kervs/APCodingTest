//
//  ChatData.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/19/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//i added an extra property because i thould it would be more efficient to change the url into a picture in the model
@interface ChatData : NSObject
@property (nonatomic, readwrite) int user_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar_url;
@property (nonatomic, strong) NSString *message;
@property (nonatomic,strong) UIImage *avatar;
- (void)loadWithDictionary:(NSDictionary *)dict;
@end
