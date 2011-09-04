//
//  PicturesTVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "PicturesTVC.h"
#import "PicturesLibraryVC.h"
#import "UIImageResizing.h"
#import "iVIPAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation PicturesTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Pictures" ofType:@"plist"];
	arrayDB = [[NSArray alloc] initWithContentsOfFile:path];
	
	self.tableView.separatorColor = [UIColor viewFlipsideBackgroundColor];
	self.navigationItem.title = @"Pictures";
}


#pragma mark - Table view methods

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
    static NSString *CellIdentifier = @"PictureCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 240, 20)];
	UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 240, 15)];
	NSString *img_name = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Icon"];
    NSString *img_path = [NSString stringWithFormat:@"%@.%@", img_name, kThumbExtension];
	UIImageView *imgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:img_path] scaleAndCropToSize:CGSizeMake(96, 96) onlyIfNeeded:YES]];
	
	UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 54)];
	
	titleLabel.text = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Title"];
	titleLabel.font = [UIFont boldSystemFontOfSize:16];
	titleLabel.backgroundColor = [UIColor clearColor];
	
	subtitleLabel.text = [NSString stringWithFormat:@"%@ pictures", [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Images"]];
	subtitleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:0.8];
	subtitleLabel.font = [UIFont systemFontOfSize:12];
	subtitleLabel.backgroundColor = [UIColor clearColor];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	imgView.frame = CGRectMake(3, 3, 48, 48);
	[imgView.layer setBorderColor: [[UIColor blackColor] CGColor]];
	[imgView.layer setBorderWidth: 1.0];
	
	
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	PicturesLibraryVC *picturesLibrary = [[PicturesLibraryVC alloc] initWithNibName:@"PicturesLibraryVC" bundle:nil];
	picturesLibrary.details = [arrayDB objectAtIndex:indexPath.row];
    
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.picturesNC pushViewController:picturesLibrary animated:YES];
	[picturesLibrary release];
}


# pragma mark - Memory management

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

