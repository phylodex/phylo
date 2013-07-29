//
//  PXSearchResultPhotoViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-06-23.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXSearchResultPhotoViewController.h"
#import "PXXMLParserSecondStep.h"
#import "PXXMLParserThirdStep.h"

@interface PXSearchResultPhotoViewController ()
#define kTotalDownloads 3 // number of max requests made to Natureserve
@property (nonatomic, assign)BOOL isDownloading;
@property (nonatomic, assign)int downloadCounter;
@property (nonatomic, assign)int totalDownloads;
@property (nonatomic, retain)PXDownloadManager *comprehensiveDownloadManager;
@property (nonatomic, retain)PXDownloadManager *imageInfoDownloadManager;
@property (nonatomic, retain)PXDownloadManager *imageFileDownloadManager;
@end

@implementation PXSearchResultPhotoViewController

@synthesize image;
@synthesize imageView;
//@synthesize nameText;
//@synthesize creditText;
//@synthesize nameLabel;
//@synthesize creditLabel;
@synthesize isDownloading;
@synthesize downloadCounter;
@synthesize totalDownloads;
@synthesize uuid;
@synthesize comprehensiveDownloadManager;
@synthesize imageInfoDownloadManager;
@synthesize imageFileDownloadManager;
@synthesize speciesData;
@synthesize activityIndicator;
@synthesize table;
@synthesize scroller;

static NSString *CellTableIdentifier = @"PXNameAndContentCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        downloadCounter = 0;
        totalDownloads = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // start a two part search, first using comprehensive webservice...
    comprehensiveDownloadManager = [[PXDownloadManager alloc] initWithTypeOfService:GlobalComprehensiveSpecies];
    comprehensiveDownloadManager.delegate = self;
    [comprehensiveDownloadManager queryWebServiceForData:uuid];
    
    // ...then using image webservice
    imageInfoDownloadManager = [[PXDownloadManager alloc] initWithTypeOfService:SpeciesImages];
    imageInfoDownloadManager.delegate = self;
    [imageInfoDownloadManager queryWebServiceForData:uuid];
    
    showData = [[NSMutableArray alloc]init];
    scroller = [[UIScrollView alloc]init];
    table = [[UITableView alloc]init];
    UINib *nib = [UINib nibWithNibName:@"PXNameAndContentCell" bundle:nil];
    table.rowHeight = 120;
    [table registerNib:nib forCellReuseIdentifier: CellTableIdentifier];
    [scroller setScrollEnabled:YES];
    scroller.backgroundColor = [UIColor whiteColor];
    table.delegate = self;
    table.dataSource = self;
    scroller.delegate = self;
    [scroller addSubview:table];
    
//    NSLog(@"speciesData is %@", speciesData);
}


-(void)resetView
{
    //reset your view components.
    [self.view setNeedsDisplay];
}

-(void)viewWillAppear
{
    [self resetView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadImageFromURL:(NSString *)url {
    imageFileDownloadManager = [[PXDownloadManager alloc] initWithTypeOfService:ImageURL];
    imageFileDownloadManager.delegate = self;
    [imageFileDownloadManager queryWebServiceForData:url];
}

- (void)downloadDidEnd {
    // make the progress indicator disappear and reset the view
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    downloadCounter = 0;
    totalDownloads = 0;
    
    //set default image if no image downloaded
    if (image == nil) {
        UIImage *defaultImage = [UIImage imageNamed:@"noimage.jpg"];
        image = defaultImage;
        imageView.image = image;
    }
    

    
    [self resetView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXNameAndContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PXNameAndContentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (showData.lastObject == nil) {
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Credit: ";
            cell.contentLabel.text = [imageInfo objectForKey:@"CopyrightsHolder"];
        }
        if (indexPath.row == 1) {
            cell.nameLabel.text = @"Name: ";
            cell.contentLabel.text = [speciesData objectForKey:@"Name"];
        }
        if (indexPath.row == 2) {
            cell.nameLabel.text = @"Latin Name: ";
            cell.contentLabel.text = [speciesData objectForKey:@"Latin Name"];
        }
        if (indexPath.row == 3) {
            cell.nameLabel.text = @"Evolutionary Tree: ";
            cell.contentLabel.text = [speciesData objectForKey:@"Kingdom"];
        }
        if (indexPath.row == 4) {
            cell.nameLabel.text = @"Habitat: ";
            cell.contentLabel.text = [speciesData objectForKey:@"Habitat"];
        }
    }
    if (showData.lastObject != nil) {
        cell.contentLabel.text = [showData objectAtIndex:indexPath.row];
//        NSLog(@"%@",cell.contentLabel.text);
    }
    
    return cell;
}


#pragma mark - web search view delegate methods for updating the UI

- (void)downloadDidStart
{
    [activityIndicator startAnimating];
    isDownloading = YES;
    downloadCounter++;
    totalDownloads++;
}

- (void)updateStatus:(NSString *)statusString
{
    
}

- (void)downloadDidStopWithStatus:(NSString *)statusString forService:(WebServiceType)service
{
    downloadCounter--;
    
    // if the status is nil, it means the download was OK
    if (statusString == nil) {
        // extract the data into the view
        if (service == GlobalComprehensiveSpecies) {
            NSString *XMLDataString = [[NSString alloc] initWithContentsOfFile:comprehensiveDownloadManager.filePath encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"xml data: %@", XMLDataString);

            // parse the XML data into a mutable array
            PXXMLParserSecondStep *parser = [[PXXMLParserSecondStep alloc] init];
            speciesData = [parser parseSpeciesArray:XMLDataString intoDictionary:speciesData];

            // populate the UI fields with the info
//            nameLabel.text = [speciesData objectForKey:@"Name"];
        }
        if (service == SpeciesImages) {
            // parse xml for image info and url
            NSString *XMLImageDataString = [[NSString alloc] initWithContentsOfFile:imageInfoDownloadManager.filePath encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"xml data: %@", XMLImageDataString);
            
            // parse the XML data into a mutable array
            PXXMLParserThirdStep *parser = [[PXXMLParserThirdStep alloc] init];
            imageInfo = [parser parseImageArray:XMLImageDataString];
            
            // download the image if available
            if ([imageInfo objectForKey:@"ImageURL"] != nil) {
                [self downloadImageFromURL:[imageInfo objectForKey:@"ImageURL"]];
            }
            else {
                // stop here, no more info available
                totalDownloads++;
            }
        }
        if (service == ImageURL) {
            // downloading of the actual image complete
            image = [UIImage imageWithContentsOfFile:imageFileDownloadManager.filePath];
            if (image != nil) {
                imageView.image = image;
            }
        }
        if (downloadCounter == 0 && totalDownloads >= kTotalDownloads) {
            isDownloading = NO; // all downloads complete
            [self downloadDidEnd];
        }
    }
}

- (void)downloadWasTerminated{}

@end
