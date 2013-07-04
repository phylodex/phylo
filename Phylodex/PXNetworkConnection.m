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
    NSString *queryWords = [[NSString alloc]initWithFormat:@"https://services.natureserve.org/idd/rest/ns/v1/globalSpecies/list/nameSearch?name=*%@&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d",query];
    NSURL *url = [[NSURL alloc]initWithString:queryWords];
    searchResultXMLData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // for the prototype, we will return some dummy data
//    searchResultXMLData = @"dummy data";
    return searchResultXMLData;
}

- (UIImage *)queryWebServiceForPhoto:(NSString *)query
{
    // TO-DO: query the webservice for a photo
    
    // for prototype, we do nothing
    return nil;
}

@end
