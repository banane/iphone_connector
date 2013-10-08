//
//  User.m
//  w2connect
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize UID,email;

static User * _instance = nil;

+ (User *) instance
{
    if(_instance == nil)
    {
        _instance = [[User alloc] init];
        
    }
    
    return _instance;
}

- (id)init
{
    self = [super init];
    
    self.UID = @"";
    self.email = @"";
    
    return self;
}

-(void)saveUser:(NSDictionary *)params{
    self.email = params[@"email"];
    self.UID = params[@"id"];
    
}

@end
