//
//  BioDetailsVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "BioDetailsVC.h"
#import "iVIPAppDelegate.h"
#import "UIImageResizing.h"
#import <QuartzCore/QuartzCore.h>

@implementation BioDetailsVC

@synthesize details;

- (void)viewDidLoad
{
	self.title = [details objectForKey:@"Title"];

	txtSubtitle.text = [details objectForKey:@"Subtitle"];
	txtSubtitle.font = [UIFont boldSystemFontOfSize:17];
	txtSubtitle.backgroundColor = [UIColor clearColor];
    
	txtDetails.text = [details objectForKey:@"Description"];
	txtDetails.font = [UIFont systemFontOfSize:16];
	txtDetails.backgroundColor = [UIColor clearColor];
	
    NSString *img_name = [details objectForKey:@"Image"];
    NSString *img_path = [NSString stringWithFormat:@"%@.%@", img_name, kPicExtension];    
	imgView.image = [UIImage imageNamed:img_path];
    
	imgView.layer.masksToBounds = YES;
	imgView.layer.cornerRadius = 20;
	imgView.layer.borderWidth = 3;
	imgView.layer.borderColor = [[UIColor whiteColor] CGColor];
	
	backgroundView.layer.masksToBounds = YES;
	backgroundView.layer.cornerRadius = 20;
	backgroundView.layer.borderWidth = 3;
	backgroundView.layer.borderColor = [[UIColor whiteColor] CGColor];
	backgroundView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
	backgroundView.backgroundColor = [UIColor colorWithWhite:255.0 alpha:1.0];
	
	imgView.frame = backgroundView.frame;
	
    [super viewDidLoad];
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
	[txtDetails release];
	[txtSubtitle release];
	[imgView release];
	[backgroundView release];
    [super dealloc];
}


@end
