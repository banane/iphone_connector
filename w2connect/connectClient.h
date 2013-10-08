//
//  connectClient.h
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>

extern NSString * const kBaseURLString;

@interface connectClient : AFHTTPClient

+(connectClient *)sharedClient;

@end

