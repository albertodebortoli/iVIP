//
//  AboutViewController.m
//  Utility
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

@synthesize delegate;

- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	[super viewDidLoad];
    
    lblTitle.text = [NSString stringWithFormat:@"%@", kApplicationName]; 
    lblDevelopers.text = [NSString stringWithFormat:@"%@", kApplicationDevelopers];
    lblVersion.text = [NSString stringWithFormat:@"version v%@", kApplicationVersion];
    lblDescription.text = [NSString stringWithFormat:@"%@", kApplicationDescription];
}

- (IBAction)done
{
	[self.delegate AboutViewControllerDidFinish:self];	
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}


@end
