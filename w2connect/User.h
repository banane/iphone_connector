//
//  User.h
//  w2connect
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    int UID;
    NSString *email;
    int numTimesLogin;
    NSString *profilePhoto;
    NSString *token;
    NSDate *lastLoginDate;
    int member;
}

@property int UID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *profilePhoto;
@property (nonatomic, strong) NSString *token;
@property int numTimesLogin;
@property (nonatomic, strong) NSDate *lastLoginDate;
@property int member;

+ (User *) instance;
- (void) saveUser:(NSDictionary *)params email:(NSString *)theEmail;
- (void) loadFromDefaults;
- (void) saveToDefaults;
- (void) incrementVisit;
- (bool) needsLogin;
- (bool) isValidToken;
- (bool) hasNoPhoto;
- (bool) isUserNotExpired;
-(void) saveProfilePhoto:(NSString *)profile_photo;
-(bool) isMember;


@end
