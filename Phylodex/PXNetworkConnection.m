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

//BASIC IDEA OF SENDING QUERYS TO SERVER IS:
//1. SENDING THE FIRST QUERY FROM "PXNetworkConnection.m" TO GET THE "Global Species List by Name" SEARCHING RESULT (USUALLY ONLY "UniqueID" IS NEEDED). I DID NOT UES "queryWebServiceForPhoto" METHOD IN THIS FILE, BECAUSE I NEED TO SEND QUERYS IN A ROW
//2. GET "NSString" RESULT CALLED "searchResultXMLData" IN METHOD "queryWebServiceForData" IN THIS FILE AND SEND BACK TO "PXWebSearchViewController.m"
//3. "PXWebSearchViewController.m" WILL GIVE "PXXMLParser.m" A REQUEST TO PARSERING XML FILE (VARIABLE "searchResultXMLData" IN METHOD "searchButtonWasPressed" IN FILE "PXWebSearchViewController.m") AND WE WILL PASS THE VARIABLE "Data" (SAME AS VARIABLE "searchResultXMLData" IN "PXWebSearchViewController.m") FROM "PXXMLParser.m" TO "PXXMLParserFirstStep.m"
//4. IN "PXXMLParserFirstStep.m", WE WILL PARSERING THE CONTENT OF THE XML FILE. FIRST, WE NEED TO INITIALIZE ALL KEYS IN EACH DICTIONARY, AND THEN, FORMALLY PARSERING THE FIRST QUERY RESULT DATA AND RETURN THE ARRAY ("animalNameArray")" TO "PXXMLParser.m" CALLED "firstStepResults"
//5. IN "PXXMLParser.m" I PASS "firstStepResults" TO A METHOD CALLED "parseFileSecondStep" IN THE SAME FILE, AND IT WILL GENERATE THE SECOND QUERY SENDING TO SERVER. FOR EACH ELEMENT IN THE "firstStepResults" (EACH ELEMENT IS A NSMutableDictionary, AND I DO THIS IN A FOR LOOP), I SEND A QUERY TO GET THE XML FILE STORED IN VARIABLE "dataString", AND PASS IT TO "PXXMLParserSecondStep.m"
//6. IN "PXXMLParserSecondStep.m", I FORMALLY PARSERING NSMutableDictionary "name" (SAME AS "[firstStepArray objectAtIndex: i]" IN "PXXMLParser.m") AND IT WILL RETURN "SpeciesArray" TO "PXXMLParser.m" (CALLED "secondStepResults" IN "PXXMLParser.m")
//7. SAME AS PREVIOUS ONE, PASS "secondStepResults" TO METHOD "parseFileThirdStep" IN THE SAME FILE AND GENERATE THE LAST QUERY USING FOR LOOP TO THE SERVER, GET THE RESULT DATA(CALLED "dataString") AND PASS IT TO "PXXMLParserThirdStep.m"
//8. IN "PXXMLParserThirdStep.m", FORMALLY PAERSING NSMutableDictionary "name" (SAME AS "[secondStepArray objectAtIndex: i]" IN "PXXMLParser.m") AND IT WILL RETURN "ImageArray" TO "PXXMLParser.m" (CALLED "thirdStepResults" IN "PXXMLParser.m"), AND ASSIGNED IT TO A VARIABLE "Result", WHICH IS THE FINAL RESULT, AND RETURN IT TO THE CALLING METHOD
//HOPING THAT HELPS


- (id)init
{
    // TO-DO: initialize a network connection
    
    return self;
}

- (NSString *)queryWebServiceForData:(NSString *)query
{
    // TO-DO: query the web service
    
    //format query by replacing whitespace with "%20"
    NSString *formattedQuery = [[NSString alloc] initWithString:[[query componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@"%20"]];
    
    NSString *queryWords = [[NSString alloc]initWithFormat:@"https://services.natureserve.org/idd/rest/ns/v1/globalSpecies/list/nameSearch?name=*%@*&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d",formattedQuery];
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
