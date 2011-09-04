//
//  VideosTVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "VideosTVC.h"
#import "iVIPAppDelegate.h"

@implementation VideosTVC

- (UIWebView *)embedYouTube:(NSString *)youtubeId
{  
	NSString *htmlString = @"<html><head>\
	<meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 100\"/></head>\
	<body style=\"background:#ccc;margin-top:0px;margin-left:0px\">\
	<div><object width=\"100\" height=\"60\">\
	<param name=\"movie\" value=\"http://www.youtube.com/v/%@&amp;hl=it_IT&amp;fs=1\"></param>\
	<param name=\"wmode\" value=\"transparent\"></param>\
	<embed src=\"http://www.youtube.com/v/%@&amp;hl=it_IT&amp;fs=1\"\
	type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"100\" height=\"60\"></embed>\
	</object></div></body></html>";
	
	UIWebView * wb = [[UIWebView alloc] initWithFrame:CGRectMake(5, 5, 100, 60)];
	[wb loadHTMLString:[NSString stringWithFormat:htmlString, youtubeId, youtubeId] baseURL:nil];
	
	return [wb autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"plist"];
	arrayDB = [[NSArray alloc] initWithContentsOfFile:path];
    
	activityIndicators = [[NSMutableArray alloc] init];
	webViews = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < [arrayDB count]; i++) {
		UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(45, 25, 20, 20)];
        [activityIndicators addObject:ai];
        [ai release];
        
		((UIActivityIndicatorView *) [activityIndicators objectAtIndex:i]).hidesWhenStopped = YES;
		((UIActivityIndicatorView *) [activityIndicators objectAtIndex:i]).activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[((UIActivityIndicatorView *) [activityIndicators objectAtIndex:i]) startAnimating];
		
        [webViews addObject:[self embedYouTube:[[arrayDB objectAtIndex:i] objectForKey:@"Id"]]];
		((UIWebView *)[webViews objectAtIndex:i]).delegate = self;
	}

	self.tableView.separatorColor = [UIColor viewFlipsideBackgroundColor];
	self.navigationItem.title = @"Videos";
}

- (void)viewWillDisappear:(BOOL)animated
{
	self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [arrayDB count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VideoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
	
	[containerView addSubview:[webViews objectAtIndex:indexPath.row]];
	[containerView addSubview:[activityIndicators objectAtIndex:indexPath.row]];
	
	UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 205, 40)];
	UILabel * lblDuration = [[UILabel alloc] initWithFrame:CGRectMake(215, 45, 100, 20)];
	UILabel * lblYear = [[UILabel alloc] initWithFrame:CGRectMake(110, 45, 105, 20)];
	
	lblTitle.numberOfLines = 2;
	lblTitle.font = [UIFont boldSystemFontOfSize:16];
	lblDuration.font = [UIFont systemFontOfSize:14];
	lblDuration.textColor = [UIColor grayColor];
	lblYear.font = [UIFont italicSystemFontOfSize:14];
	lblYear.textColor = [UIColor grayColor];
	
	lblTitle.backgroundColor = [UIColor clearColor];
	lblDuration.backgroundColor = [UIColor clearColor];
	lblYear.backgroundColor = [UIColor clearColor];
	
	lblTitle.text = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Title"];
	lblDuration.text = [NSString stringWithFormat:@"(%@)", [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Duration"]];
	lblYear.text = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Year"];
	
	lblDuration.textAlignment = UITextAlignmentRight;
	
	[containerView addSubview:lblTitle];
	[containerView addSubview:lblDuration];
	[containerView addSubview:lblYear];
	
	[cell addSubview:containerView];

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	[containerView release];
	[lblTitle release];
	[lblDuration release];
	[lblYear release];
	
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
/*	
    self.hidesBottomBarWhenPushed = YES;
	
	VideosFullVC * videoFull = [[VideosFullVC alloc] initWithNibName:@"VideosFullV" bundle:nil];
	videoFull.videoTitle = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Title"];
	videoFull.videoDuration = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Duration"];
	videoFull.videoYear = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Year"];
	videoFull.videoId = [[arrayDB objectAtIndex:indexPath.row] objectForKey:@"Id"];
	
	iVIPAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
	[delegate.videosNC pushViewController:videoFull animated:YES];
	[videoFull release];	
*/
}


#pragma mark - WebView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	int i = 0;
	while (webView != [webViews objectAtIndex:i]) {
		++i;
	}
	[((UIActivityIndicatorView *) [activityIndicators objectAtIndex:i]) stopAnimating];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[arrayDB release];
	[webViews release];
	[activityIndicators release];
    [super dealloc];
}

@end
