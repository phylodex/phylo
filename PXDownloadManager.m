//
//  PXDownloadManager.m
//  Phylodex
//
//  Created by Steve King on 2013-07-07.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXDownloadManager.h"
#import "PXNetworkManager.h"

@interface PXDownloadManager ()

@property (nonatomic, assign, readonly ) BOOL isReceiving;
@property (nonatomic, strong, readwrite) NSURLConnection *connection;
//@property (nonatomic, copy,   readwrite) NSString *filePath;
@property (nonatomic, strong, readwrite) NSOutputStream *fileStream;
@property (nonatomic, assign) WebServiceType currentWebService;

// format strings used to query service for type of service
#define kGlobalSpeciesListByNameURL @"https://services.natureserve.org/idd/rest/ns/v1/globalSpecies/list/nameSearch?name=*%@*&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d"
//#define kGlobalComprehensiveSpeciesURL @"https://services.natureserve.org/idd/rest/ns/v1.1/globalSpecies/comprehensive?uid=%@&NSAccessKeyId=72ddf45a-c751-44c7-9bca-8db3b4513347"
#define kGlobalComprehensiveSpeciesURL @"https://services.natureserve.org/idd/rest/ns/v1.1/globalSpecies/comprehensive?uid=%@&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d"
#define kSpeciesImageURL @"https://services.natureserve.org/idd/rest/ns/v1/globalSpecies/images?uid=%@"

// used for creating tmp directories to hold input files
#define kGlobalSpeciesListPrefix @"gsl"
#define kGlobalComprehensiveSpeciesPrefix @"gcs"
#define kSpeciesImagePrefix @"img"

@end


@implementation PXDownloadManager

@synthesize delegate;
@synthesize isReceiving;
@synthesize connection;
@synthesize filePath;
@synthesize fileStream;
@synthesize currentWebService;

- (id)initWithTypeOfService:(WebServiceType) service
{
    self = [super init];
    if (self) {
        currentWebService = service;
    }
    return self;
}

// Starts a connection to make a search to current webservice
- (void)queryWebServiceForData:(NSString *)query
{
    switch (currentWebService) {
        case GlobalSpeciesListByName:
            [self querySpeciesNameServiceForData:query];
            break;
        case GlobalComprehensiveSpecies:
            // do something
            [self queryGlobalComprehensiveServiceForData:query];
            break;
        case SpeciesImages:
            // do something
            [self queryImageServiceForImage:query];
            break;
        case ImageURL:
            [self downloadImageFromURL:query];
            break;
        default:
            // terminate
            break;
    }
}

- (void)terminateConnection
{
    [connection cancel];
    [delegate downloadWasTerminated];
    [[PXNetworkManager sharedInstance] didStopNetworkOperation];
}

- (void)receiveDidStopWithStatus:(NSString *)statusString forService:(WebServiceType)service
{
    // inform the delegate about the data being received
    if (statusString == nil) {
        // success
        assert(self.filePath != nil);
    }
    // inform the UI or delegate that the receive is finished with status
    [delegate downloadDidStopWithStatus:statusString forService:currentWebService];
    
    [[PXNetworkManager sharedInstance] didStopNetworkOperation];
}

# pragma mark - private methods to query the different web services for data
- (void)querySpeciesNameServiceForData:(NSString *)query
{
    // format query by replacing whitespace with "%20"
    NSString *formattedQuery = [[NSString alloc] initWithString:[[query componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@"%20"]];
    NSString *queryWords = [[NSString alloc] initWithFormat:kGlobalSpeciesListByNameURL, formattedQuery];
    NSURL *url = [[NSURL alloc] initWithString:queryWords];
    
    // don't send the same request more than once
    assert(connection == nil);
    assert(fileStream == nil);        
    assert(filePath == nil);           
    
    // Open a stream for the file we're going to receive into.
    
    // create a unique path for the temporary file on disk
    self.filePath = [self pathForTemporaryFileWithPrefix:kGlobalSpeciesListPrefix];
    assert(self.filePath != nil);
    
    self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
    assert(self.fileStream != nil);
    
    [self.fileStream open];
    
    // Open a connection for the URL.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    assert(request != nil);
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    assert(self.connection != nil);
    
    [[PXNetworkManager sharedInstance] didStartNetworkOperation];
    [delegate downloadDidStart]; // inform the UI
}

- (void)queryGlobalComprehensiveServiceForData:(NSString *) uuid
{
    NSString *query = [[NSString alloc] initWithFormat:kGlobalComprehensiveSpeciesURL, uuid];
    NSURL *url = [[NSURL alloc] initWithString:query];
    
    // don't send the same request more than once
    assert(connection == nil);
    assert(fileStream == nil);
    assert(filePath == nil);
    
    // Open a stream for the file we're going to receive into.
    
    // create a unique path for the temporary file on disk
    self.filePath = [self pathForTemporaryFileWithPrefix:kGlobalComprehensiveSpeciesPrefix];
    assert(self.filePath != nil);
    
    self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
    assert(self.fileStream != nil);
    
    [self.fileStream open];
    
    // Open a connection for the URL.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    assert(request != nil);
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    assert(self.connection != nil);
    
    [[PXNetworkManager sharedInstance] didStartNetworkOperation];
    [delegate downloadDidStart]; // inform the UI
}

- (void)queryImageServiceForImage:(NSString *) uuid
{
    NSString *query = [[NSString alloc] initWithFormat:kSpeciesImageURL, uuid];
    NSURL *url = [[NSURL alloc] initWithString:query];
    
    // don't send the same request more than once
    assert(connection == nil);
    assert(fileStream == nil);
    assert(filePath == nil);
    
    // Open a stream for the file we're going to receive into.
    
    // create a unique path for the temporary file on disk
    self.filePath = [self pathForTemporaryFileWithPrefix:kSpeciesImagePrefix];
    assert(self.filePath != nil);
    
    self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
    assert(self.fileStream != nil);
    
    [self.fileStream open];
    
    // Open a connection for the URL.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    assert(request != nil);
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    assert(self.connection != nil);
    
    [[PXNetworkManager sharedInstance] didStartNetworkOperation];
    [delegate downloadDidStart]; // inform the UI
}

- (void)downloadImageFromURL:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    // don't send the same request more than once
    assert(connection == nil);
    assert(fileStream == nil);
    assert(filePath == nil);
    
    // Open a stream for the file we're going to receive into.
    
    // create a unique path for the temporary file on disk
    self.filePath = [self pathForTemporaryFileWithPrefix:kSpeciesImagePrefix];
    assert(self.filePath != nil);
    
    self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
    assert(self.fileStream != nil);
    
    [self.fileStream open];
    
    // Open a connection for the URL.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    assert(request != nil);
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    assert(self.connection != nil);
    
    [[PXNetworkManager sharedInstance] didStartNetworkOperation];
    [delegate downloadDidStart]; // inform the UI
}

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    // create a unique identifier for the temporary file on disk
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    // just for investigating... will remove later
//    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
//    NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:@"pkm"] URLByAppendingPathExtension:extension];
//    NSLog(@"fileURL: %@", [fileURL path]);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

# pragma mark - NSURLConnection Delegate methods

// A delegate method called by the NSURLConnection when the request/response
// exchange is complete.  We look at the response to check that the HTTP
// status code is 2xx and that the Content-Type is acceptable.  If these checks
// fail, we give up on the transfer.
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse;
    NSString *contentTypeHeader;
    
    assert(theConnection == connection);
    
    httpResponse = (NSHTTPURLResponse *) response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    
    if ((httpResponse.statusCode / 100) != 2) {
//        [self stopReceiveWithStatus:[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode]];
        // handle the non-OK status
    }
    else {
        // -MIMEType strips any parameters, strips leading or trailer whitespace, and lower cases
        // the string, so we can just use -isEqual: on the result.
        contentTypeHeader = [httpResponse MIMEType];
        if (contentTypeHeader == nil) {
//            [self stopReceiveWithStatus:@"No Content-Type!"];
            // no content type error
        }
        BOOL supportedContentType = NO;
        NSArray *contentTypes;
        switch (currentWebService) {
            case GlobalSpeciesListByName:
                // check that we are receiving xml data
                contentTypes = [[NSArray alloc] initWithObjects:@"application/xml", @"text/xml", @"application/xhtml+xml", nil];
                break;
            case GlobalComprehensiveSpecies:
                contentTypes = [[NSArray alloc] initWithObjects:@"application/xml", @"text/xml", @"application/xhtml+xml", nil];
                break;
            case SpeciesImages:
                contentTypes = [[NSArray alloc] initWithObjects:@"image/jpeg", @"image/png", @"image/gif", nil];
                break;
            default:
                // terminate
                break;
        }
        supportedContentType = [self isSupportedContentType:contentTypeHeader forMimeTypes:contentTypes];
        
        if (supportedContentType) {
            // all is well
        }
        else {
            // terminate, the content type is invalid
        }
    }
}

- (BOOL)isSupportedContentType:(NSString *)header forMimeTypes:(NSArray *)types
{
    for (NSString *type in types) {
        if ([header isEqual:type]) {
            return YES;
        }
    }
    return NO;
}

// A delegate method called by the NSURLConnection as data arrives.  We just
// write the data to the file.
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    NSInteger dataLength;
    const uint8_t *dataBytes;
    NSInteger bytesWritten;
    NSInteger bytesWrittenSoFar;
    
    assert(theConnection == self.connection);
    
    dataLength = [data length];
    dataBytes  = [data bytes]; // byte buffer
    
    bytesWrittenSoFar = 0;
    do {
        bytesWritten = [self.fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
        assert(bytesWritten != 0);
        if (bytesWritten == -1) {
            //[self stopReceiveWithStatus:@"File write error"];
            // handle some file write error
            break;
        } else {
            bytesWrittenSoFar += bytesWritten;
        }
    } while (bytesWrittenSoFar != dataLength);
}

// A delegate method called by the NSURLConnection if the connection fails.
// We shut down the connection and display the failure.  Production quality code
// would either display or log the actual error.
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    assert(theConnection == self.connection);
    NSLog(@"Error: %@", error);
    
    // [self stopReceiveWithStatus:@"Connection failed"];
    // handle a connection error
}

// A delegate method called by the NSURLConnection when the connection has been
// done successfully.  We shut down the connection with a nil status, which
// causes the image to be displayed.
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    assert(theConnection == self.connection);
    
//    [self stopReceiveWithStatus:nil];
    // inform the UI or delegate that the connection was OK
    [delegate downloadDidStopWithStatus:nil forService:currentWebService];
}


@end
