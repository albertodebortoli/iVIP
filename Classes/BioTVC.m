//
//  BioTVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//  

#import "BioTVC.h"
#import "BioDetailsVC.h"
#import "iVIPAppDelegate.h"
#import "UIImageResizing.h"
#import <QuartzCore/QuartzCore.h>

@implementation BioTVC


#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

	NSString *path;
	path = [[NSBundle mainBundle] pathForResource:@"Bio" ofType:@"plist"];
	
	arrayDB = [[NSArray alloc] initWithContentsOfFile:path];	
	self.navigationItem.title = @"Biography";
	self.tableView.separatorColor = [UIColor viewFlipsideBackgroundColor];
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight]; 
	[infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem * buttonInfo = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	[self.navigationItem setRightBarButtonItem:buttonInfo];
    [buttonInfo release];
	
	[super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayDB count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BioCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 240, 20)];
	UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 240, 15)];
	NSString *img_name = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Image"];
    NSString *img_path = [NSString stringWithFormat:@"%@.%@", img_name, kPicExtension];
    
	UIImageView *imgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:img_path] scaleAndCropToSize:CGSizeMake(96, 96) onlyIfNeeded:YES]];
	
	UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 54)];
	
	titleLabel.text = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Title"];
	titleLabel.font = [UIFont boldSystemFontOfSize:16];
	titleLabel.backgroundColor = [UIColor clearColor];
	
	subtitleLabel.text = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Subtitle"];
	subtitleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:0.8];
	subtitleLabel.font = [UIFont systemFontOfSize:12];
	subtitleLabel.backgroundColor = [UIColor clearColor];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	imgView.frame = CGRectMake(3, 3, 48, 48);
	[imgView.layer setBorderColor:[[UIColor blackColor] CGColor]];
	[imgView.layer setBorderWidth:1.0];
	
	[containerView addSubview:imgView];
	[containerView addSubview:titleLabel];
	[containerView addSubview:subtitleLabel];
	[cell addSubview:containerView];
	
	[titleLabel release];
	[subtitleLabel release];
	[imgView release];
	[containerView release];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *altCellColor;
	if (indexPath.row == 0 || indexPath.row%2 == 0) {
		altCellColor = [UIColor colorWithWhite:kWhiteColorForEvenCells alpha:1.0];
	}
	else {
		altCellColor = [UIColor colorWithWhite:kWhiteColorForOddCells alpha:1.0];
	}
    cell.backgroundColor = altCellColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kTableViewCellHeight;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BioDetailsVC *bioDetail = [[BioDetailsVC alloc] initWithNibName:@"BioDetailsVC" bundle:nil];
	bioDetail.details = [arrayDB objectAtIndex:indexPath.row];
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.bioNC pushViewController:bioDetail animated:YES];
	[bioDetail release];
}

- (void)AboutViewControllerDidFinish:(AboutViewController *)controller
{    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo
{    
	AboutViewController *controller;
	controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	[controller release];
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

