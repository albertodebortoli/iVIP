//
//  PicturesFullVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "PicturesFullVC.h"
#import "iVIPAppDelegate.h"
#import "SHK.h"
#import "SHKFacebook.h"
#import "SHKMail.h"
#import "SHKCopy.h"

@implementation PicturesFullVC

@synthesize abbreviation, numberOfImages, numberOfCurrentImage, imageFull;

- (void)viewDidLoad
{	
	[imageView setImage:imageFull];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	
	if (numberOfCurrentImage == numberOfImages || numberOfImages == 1) {
		[buttonNext setEnabled:NO];
	} else {
        [buttonNext setEnabled:YES];
	}
    
    if (numberOfCurrentImage == 1) {
        [buttonPrev setEnabled:NO];
    } else {
        [buttonPrev setEnabled:YES];
    }
	
	[imageView setUserInteractionEnabled:YES];	
	[super viewDidLoad];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	NSString *textPic = [NSString stringWithFormat:@"Look at this picture of %@! (via %@ for iPhone)", kVIPname, kApplicationName];
	SHKItem *item = [SHKItem image:imageFull title:textPic];
	
	if (buttonIndex == 0) {
		[SHKFacebook shareItem:item];
	}
	if (buttonIndex == 1) {
		[SHKMail shareItem:item];
	}
	if (buttonIndex == 2) {
		[SHKCopy shareItem:item];
	}
	if (buttonIndex == 3) {
		NSParameterAssert(imageFull);
		UIImageWriteToSavedPhotosAlbum(imageFull,nil, nil, nil);;
	}
}

- (IBAction)sharePic
{	
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Mail", @"Copy",@"Save to camera roll",nil];
	sheet.actionSheetStyle = UIActionSheetStyleDefault;
	
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[sheet showFromTabBar:delegate.tabBarController.tabBar];

	[sheet release];
}

- (IBAction)photoPrev
{
	NSString *a = [NSString stringWithFormat:@"%@%d.%@", abbreviation, numberOfCurrentImage - 1, kPicExtension];
	numberOfCurrentImage--;
	[imageFull release];
	imageFull = [UIImage imageNamed:a];
	[imageView setImage:imageFull];
	
	if (numberOfCurrentImage == 1) {
		[buttonPrev setEnabled:NO];
	} else {
		[buttonPrev setEnabled:YES];
	}
	[buttonNext setEnabled:YES];
}


- (IBAction)photoNext
{
	NSString *a = [NSString stringWithFormat:@"%@%d.%@", abbreviation, numberOfCurrentImage + 1, kPicExtension];
	numberOfCurrentImage++;
	[imageFull release];
	imageFull = [UIImage imageNamed:a];
	[imageView setImage:imageFull];
	
	if (numberOfCurrentImage == numberOfImages) {
		[buttonNext setEnabled:NO];
	} else {
		[buttonNext setEnabled:YES];
	}
	[buttonPrev setEnabled:YES];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[abbreviation release];
	[imageFull release];
	[imageView release];
	[buttonPrev release];
	[buttonNext release];
    [super dealloc];
}


@end
