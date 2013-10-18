//
//  User.m
//  w2connect
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize UID,email,numTimesLogin,profilePhoto,token, lastLoginDate;

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
    
    return self;
}

- (void)incrementVisit{
    self.numTimesLogin += 1;
    
}

-(void)saveUser:(NSDictionary *)params email:(NSString *)theEmail{
    self.email = theEmail;
    self.UID = [params[@"id"] intValue];
    self.profilePhoto = params[@"profile_photo"];
    self.token = params[@"token"];
    
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
        result_value = YES;
    } else if(result==NSOrderedDescending) {
        NSLog(@"Date1 is in the past");
        result_value = NO;
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

-(void)loadFromDefaults{
    NSLog(@"loading from defaults");
    self.numTimesLogin =  [[NSUserDefaults standardUserDefaults] integerForKey:@"num_times_login"];
    self.lastLoginDate =  [[NSUserDefaults standardUserDefaults] objectForKey:@"last_login_date"];
    self.token =  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    self.UID = [[NSUserDefaults standardUserDefaults] integerForKey:@"UID"];
    self.profilePhoto =  [[NSUserDefaults standardUserDefaults] objectForKey:@"profile_photo"];
}

-(void)saveToDefaults{
    NSLog(@"saving to defaults");
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.numTimesLogin forKey:@"num_times"];
    [defaults setInteger:self.UID forKey:@"UID"];
    [defaults setObject:self.lastLoginDate forKey:@"last_login_date"];
    [defaults setObject:self.token forKey:@"token"];
    [defaults setObject:self.profilePhoto forKey:@"profile_photo"];
    [defaults synchronize];
    
    NSLog(@"to save defaults: %@", defaults);
    
}

@end
