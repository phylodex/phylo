//
//  PXNetworkConnection.h
//  Phylodex
//
//  Description: Makes a network connection to Natureserve.org, sending a query string, and
//               returning an xml file
//
//  Created by Steve King on 2013-06-21.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER @"http://natureserve.org"

@interface PXNetworkConnection : NSObject

@property (nonatomic, retain) NSString *searchResultXMLData;
@property (nonatomic, retain) UIImage *searchResultImage;

- (NSString *)queryWebServiceForData:(NSString *)query;
- (UIImage *)queryWebServiceForPhoto:(NSString *)query;

@end
