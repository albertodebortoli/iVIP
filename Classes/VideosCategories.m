//
//  VideosInCategory.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "VideosCategories.h"
#import "VideosTVC.h"
#import "iVIPAppDelegate.h"
#import "UIImageResizing.h"
#import <QuartzCore/QuartzCore.h>

@implementation VideosCategories


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationItem.title = @"Videos";
	
	self.tableView.separatorColor = [UIColor viewFlipsideBackgroundColor];
	
	categories = [[NSArray alloc] initWithObjects:@"Keynotes", @"Interviews", @"Funny Videos", @"Miscellaneous", nil];
	
	keynotes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Keynotes" ofType:@"plist"]];
	interviews = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Interviews" ofType:@"plist"]];
	funny = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Funny" ofType:@"plist"]];
	miscellaneous = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Miscellaneous" ofType:@"plist"]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCategoryCell"];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 240, 20)];
	UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 240, 15)];
	NSString *img_path = [NSString stringWithFormat:@"%@Icon.png", [categories objectAtIndex:indexPath.row]];
	UIImageView *imgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:img_path] scaleAndCropToSize:CGSizeMake(96, 96) onlyIfNeeded:YES]];
	
	UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 54)];
	
	if (cell != nil) {
      [cell release];
    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoCategoryCell"];	
	
	titleLabel.text = [categories objectAtIndex:indexPath.row];
	titleLabel.font = [UIFont boldSystemFontOfSize:16];
	titleLabel.backgroundColor = [UIColor clearColor];
	
	NSString * detail;
	
	switch (indexPath.row) {
		case 0:
			detail = [NSString stringWithFormat:@"%d videos", [keynotes count]];
			break;
		case 1:
			detail = [NSString stringWithFormat:@"%d videos", [interviews count]];
			break;
		case 2:
			detail = [NSString stringWithFormat:@"%d videos", [funny count]];
			break;
		case 3:
			detail = [NSString stringWithFormat:@"%d videos", [miscellaneous count]];
			break;
		default:
            detail = @"";
			break;
	}	
	
	subtitleLabel.text = detail;
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	VideosTVC * videoController = [[VideosTVC alloc] initWithNibName:@"VideosTVC" bundle:nil];
//	switch (indexPath.row) {
//		case 0:
//			videoController.arrayDB = keynotes;
//			break;
//		case 1:
//			videoController.arrayDB = interviews;
//			break;
//		case 2:
//			videoController.arrayDB = funny;
//			break;
//		case 3:
//			videoController.arrayDB = miscellaneous;
//			break;
//		default:
//			break;
//	}
//	videoController.viewTitle = [categories objectAtIndex:indexPath.row];
	
	iVIPAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
	[delegate.videosNC pushViewController:videoController animated:YES];
	[videoController release];	
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[categories release];
	[keynotes release];
	[interviews release];
	[funny release];
	[miscellaneous release];
	[thumbnails release];
    [super dealloc];
}


@end

