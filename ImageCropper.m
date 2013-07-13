//
//  ImageCropper.m
//  Created by http://github.com/iosdeveloper
//

#import "ImageCropper.h"
#import "PXDetailViewController.h"
#import "PXAppDelegate.h"

@interface ImageCropper (){
    NSManagedObjectContext *context;
}
@end

@implementation ImageCropper

@synthesize scrollView, imageView;


- (id)initWithImage:(UIImage *)image {
	self = [super init];
	self=[super init];
	if (self) {
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
		
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 40.0, 320.0, 480.0)];
		[scrollView setBackgroundColor:[UIColor blackColor]];
		[scrollView setDelegate:self];
		[scrollView setShowsHorizontalScrollIndicator:NO];
		[scrollView setShowsVerticalScrollIndicator:NO];
		[scrollView setMaximumZoomScale:2.0];

        PXAppDelegate *photo = [[UIApplication sharedApplication]delegate];
        context = [photo managedObjectContext];
        
		imageView = [[UIImageView alloc] initWithImage:image];
		
		CGRect rect;
		rect.size.width = image.size.width;
		rect.size.height = image.size.height;
		
		[imageView setFrame:rect];
		
		[scrollView setContentSize:[imageView frame].size];
		[scrollView setMinimumZoomScale:[scrollView frame].size.width / [imageView frame].size.width];
		[scrollView setZoomScale:[scrollView minimumZoomScale]];
		[scrollView addSubview:imageView];
		
		[[self view] addSubview:scrollView];
		
		UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
		[navigationBar setBarStyle:UIBarStyleBlack];
		[navigationBar setTranslucent:YES];
		
		UINavigationItem *aNavigationItem = [[UINavigationItem alloc] initWithTitle:@"Move and Scale"];
		[aNavigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCropping)]];
		[aNavigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishCropping)]];
		
		[navigationBar setItems:[NSArray arrayWithObject:aNavigationItem]];
		
//		[aNavigationItem release];
		
		[[self view] addSubview:navigationBar];
		
//		[navigationBar release];
	}
	
	return self;
}

- (void)cancelCropping {
    [self dismissViewControllerAnimated:YES completion:nil];
//	[delegate imageCropperDidCancel:self];
}

- (void)finishCropping {
	float zoomScale = 1.0 / [scrollView zoomScale];
	
	CGRect rect;
	rect.origin.x = [scrollView contentOffset].x * zoomScale;
	rect.origin.y = [scrollView contentOffset].y * zoomScale;
	rect.size.width = [scrollView bounds].size.width * zoomScale;
	rect.size.height = [scrollView bounds].size.height * zoomScale;
	
	CGImageRef cr = CGImageCreateWithImageInRect([[imageView image] CGImage], rect);
	
	UIImage *cropped = [UIImage imageWithCGImage:cr];
	
	CGImageRelease(cr);
    
    
//    -------------------------
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    NSManagedObject *croppedImage = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    [croppedImage setValue:cropped forKey:@"image"];
    
    NSLog(@"cropped Image is %@", cropped);
    
//    -------------------------
    
	
	[delegate imageCropper:self didFinishCroppingWithImage:cropped];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageView;
}



@end