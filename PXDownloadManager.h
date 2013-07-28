//
//  PXDownloadManager.h
//  Phylodex
//
//  Description: handles connections and downloads to Natureserve.org
//
//  Created by Steve King on 2013-07-07.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PXDownloadManagerDelegate;

// enum to define what web service is currently being queried
typedef NS_ENUM(NSInteger, WebServiceType) {
    GlobalSpeciesListByName,
    GlobalComprehensiveSpecies,
    SpeciesImages,
    ImageURL
};

@interface PXDownloadManager : NSObject

@property (nonatomic, assign)id <PXDownloadManagerDelegate>delegate;
@property (nonatomic, copy, readwrite)NSString *filePath;

- (id)initWithTypeOfService:(WebServiceType) service;
- (void)queryWebServiceForData:(NSString *) searchTerm;

@end

@protocol PXDownloadManagerDelegate
- (void)downloadDidStart;
- (void)updateStatus:(NSString *)statusString;
- (void)downloadDidStopWithStatus:(NSString *)statusString forService:(WebServiceType)service;
@end

