//
//  PXNetworkConnection.m
//  Phylodex
//
//  Created by Steve King on 2013-06-21.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXNetworkConnection.h"

@implementation PXNetworkConnection

@synthesize searchResultImage;
@synthesize searchResultXMLData;

- (id)init
{
    // TO-DO: initialize a network connection
    
    return self;
}

- (NSString *)queryWebServiceForData:(NSString *)query
{
    // TO-DO: query the web service
    
    // for the prototype, we will return some dummy data
    searchResultXMLData = @"dummy data";
    return searchResultXMLData;
}

- (UIImage *)queryWebServiceForPhoto:(NSString *)query
{
    // TO-DO: query the webservice for a photo
    
    // for prototype, we do nothing
    return nil;
}

@end
