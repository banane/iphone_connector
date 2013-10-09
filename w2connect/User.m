//
//  User.m
//  w2connect
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize UID,email,numTimesLogin,profilePhoto;

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
    self.numTimesLogin = 0;
    self.profilePhoto = @"";
    
    return self;
}

- (void)incrementVisit{
    self.numTimesLogin += 1;
    
}

-(void)saveUser:(NSDictionary *)params{
    self.email = params[@"email"];
    self.UID = params[@"id"];
    self.profilePhoto = params[@"profile_photo"];
    
}

-(void)loadFromDefaults{
    NSLog(@"loading from defaults");
    self.numTimesLogin =  [[NSUserDefaults standardUserDefaults] integerForKey:@"num_times_login"];
}

-(void)saveToDefaults{
    NSLog(@"saving to defaults");
    NSNumber *numTimes = [NSNumber numberWithInt:self.numTimesLogin];
    NSDictionary *appDefaults  = [NSDictionary dictionaryWithObjectsAndKeys:numTimes, @"num_times_login", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
