//
//  ExtrasTVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "ExtrasVC.h"
#import "iVIPAppDelegate.h"
#import "UIImageResizing.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExtrasVC

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Extras" ofType:@"plist"];
	
	arrayDB = [[NSArray alloc] initWithContentsOfFile:path];	
	self.title = @"Extras";
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	delegate.tabBarController.tabBar.selectedItem.title = @"Extras";
	
	[super viewDidLoad];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [arrayDB release];
	[super dealloc];
}


@end

