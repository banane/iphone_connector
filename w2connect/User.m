//
//  User.m
//  w2connect
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize UID,email,numTimesLogin,profilePhoto,token, lastLoginDate,member;

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
    
    self.UID = 0;
    self.email = @"";
    self.numTimesLogin = 0;
    self.profilePhoto = @"";
    self.token = @"";
    self.lastLoginDate = [NSDate date];
    self.member = 0;
    
    return self;
}

- (void)incrementVisit{
    
    
    self.numTimesLogin = self.numTimesLogin +  1;
    
    NSLog(@"num times %d", self.numTimesLogin);
    
}

-(void)saveUser:(NSDictionary *)params email:(NSString *)theEmail{
    self.email = theEmail;
    self.UID = [params[@"id"] intValue];
    self.profilePhoto = params[@"profile_photo"];
    self.token = params[@"token"];
    self.member = [params[@"member"] intValue];
    self.lastLoginDate = [NSDate date]; // update to now
        NSLog(@"num times %d", self.numTimesLogin);
    
}

-(void)saveProfilePhoto:(NSString *)profile_photo{
    self.profilePhoto = profile_photo;
}

- (bool)notExpired{
    bool result_value = NO;
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //Calculates the date of tomorrow:
    NSDate *expiresDate = [self.lastLoginDate addTimeInterval: (secondsPerDay+secondsPerDay)];
    NSDate *today = [NSDate date];
    NSComparisonResult result = [expiresDate compare:today];
    
    
    
    if(result==NSOrderedAscending){
        NSLog(@"Date1 is in the future");
        result_value = NO;
    } else if(result==NSOrderedDescending) {
        NSLog(@"Date1 is in the past");
        result_value = YES;
    } else {
        result_value = YES;
        NSLog(@"Both dates are the same");
    }
    
    
    return result_value;
}

-(bool)needsLogin{
    
   if([self isValidToken] && [self notExpired]){
      return NO;
    } else {
      return YES;
    }
}

-(bool)isValidToken{
    
    if([self.token length] > 0){
        return YES;
    } else {
        return NO;
    }
}

-(bool)hasNoPhoto{
    if([self.profilePhoto length] == 0){
        return YES;
    } else {
        return NO;
    }
}

-(bool)isMember{
    
    
    if(self.member == 1){
        return YES;
    } else {
        return NO;
    }
}

-(void)loadFromDefaults{
    NSLog(@"loading from defaults");
    self.numTimesLogin =  [[NSUserDefaults standardUserDefaults] integerForKey:@"num_times_login"];
    self.lastLoginDate =  [[NSUserDefaults standardUserDefaults] objectForKey:@"last_login_date"];
    self.token =  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    self.UID = [[NSUserDefaults standardUserDefaults] integerForKey:@"UID"];
    self.profilePhoto =  [[NSUserDefaults standardUserDefaults] objectForKey:@"profile_photo"];
    self.member = [[NSUserDefaults standardUserDefaults] integerForKey:@"member"];
    
    NSLog(@"userNumTimes: %d", self.numTimesLogin);
}

-(void)saveToDefaults{
    NSLog(@"saving to defaults");
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.numTimesLogin forKey:@"num_times_login"];
    [defaults setInteger:self.UID forKey:@"UID"];
    [defaults setObject:self.lastLoginDate forKey:@"last_login_date"];
    [defaults setObject:self.token forKey:@"token"];
    [defaults setObject:self.profilePhoto forKey:@"profile_photo"];
    [defaults setInteger:self.member forKey:@"member"];
    [defaults synchronize];
    
    NSLog(@"num_times_login: %d", self.numTimesLogin);
    
}

@end
