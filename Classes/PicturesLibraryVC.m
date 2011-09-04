//
//  PicturesLibraryVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "PicturesLibraryVC.h"
#import "PicturesFullVC.h"
#import "iVIPAppDelegate.h"
#import "UIImageResizing.h"


@implementation PicturesLibraryVC

#define PADDING_TOP 93
#define PADDING 4
#define THUMBNAIL_COLS 4
#define THUMBNAIL 150
#define THUMBNAIL_75 75

@synthesize details;

- (void)viewDidLoad {
	self.title = [details objectForKey:@"Title"];
	
	UIButton *button;
	UIImage *thumbnail;
	int images_count = [[details objectForKey:@"Images"] intValue];
	 
	for (int i = 0; i < images_count; i++) {
		NSString *a = [NSString stringWithFormat:@"%@%d.%@", [details objectForKey:@"Abbreviation"], i + 1, kPicExtension];
        
		thumbnail = [[UIImage imageNamed:a] scaleAndCropToSize:CGSizeMake(THUMBNAIL, THUMBNAIL) onlyIfNeeded:YES];
		 
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setImage:thumbnail forState:UIControlStateNormal];
		button.showsTouchWhenHighlighted = YES;
		button.userInteractionEnabled = YES;
		[button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
		button.tag = i;
		button.frame = CGRectMake(THUMBNAIL_75 * (i % THUMBNAIL_COLS) + PADDING * (i % THUMBNAIL_COLS) + PADDING,
								  THUMBNAIL_75 * (i / THUMBNAIL_COLS) + PADDING * (i / THUMBNAIL_COLS) + PADDING + PADDING_TOP,
								  THUMBNAIL_75, THUMBNAIL_75);
	 
		[scrollView addSubview:button];
	}
	 
	int rows = images_count / THUMBNAIL_COLS;
	if (((float)images_count / THUMBNAIL_COLS) - rows != 0) {
		rows++;
	}
	int height = THUMBNAIL_75 * rows + PADDING * rows + PADDING + PADDING_TOP;
	 
	scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
	scrollView.clipsToBounds = YES;
	 	
    [super viewDidLoad];
}

- (void)viewWillDisappear: (BOOL)animated
{
	self.hidesBottomBarWhenPushed = NO;
}

- (void)buttonTouched:(UIButton *)sender
{
	self.hidesBottomBarWhenPushed = YES;
	
	PicturesFullVC *picturesFull = [[PicturesFullVC alloc] initWithNibName:@"PicturesFullVC" bundle:nil];
	
	NSString *a = [NSString stringWithFormat:@"%@%d.%@", [details objectForKey:@"Abbreviation"], ((sender.tag) + 1), kPicExtension];
	
	picturesFull.imageFull = [UIImage imageNamed:a];
	picturesFull.numberOfCurrentImage = (int) ((sender.tag) + 1);
	picturesFull.numberOfImages = [[details objectForKey:@"Images"] intValue];
	picturesFull.abbreviation = [details objectForKey:@"Abbreviation"];
	
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.picturesNC pushViewController:picturesFull animated:YES];
	[picturesFull release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
	[details release];
	[scrollView release];
    [super dealloc];
}


@end
