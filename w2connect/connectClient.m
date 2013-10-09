//
//  connectClient.m
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "connectClient.h"
#import <AFJSONRequestOperation.h>
#import "Constants.h"


@implementation connectClient

+(connectClient *)sharedClient {
    static connectClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];

    
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    return self;
}


@end
