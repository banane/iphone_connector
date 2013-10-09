//
//  User.h
//  w2connect
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *UID;
    NSString *email;
    int numTimesLogin;
    NSString *profilePhoto;
}

@property (nonatomic, strong) NSString *UID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *profilePhoto;
@property int numTimesLogin;


+ (User *) instance;
- (void) saveUser:(NSDictionary *)params;
- (void) loadFromDefaults;
- (void) saveToDefaults;
- (void) incrementVisit;

@end
