//
//  QuotesFavTVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "QuotesRatedTVC.h"
#import "QuotesDetailsVC.h"
#import <SCRatingView.h>

@implementation QuotesRatedTVC

@synthesize parent;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationItem.title = @"Rated";
	
	UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" 
                                                                      style:UIBarButtonItemStylePlain 
                                                                     target:self 
                                                                     action:@selector(doneButton)];
	
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(editButton)];
	
	[self.navigationItem setLeftBarButtonItem:editButton animated:YES];
	[self.navigationItem setRightBarButtonItem:dismissButton animated:YES];
	
	self.tableView.separatorColor = [UIColor viewFlipsideBackgroundColor];
	
	[dismissButton release];
	[editButton release];
	[super viewDidLoad];
}

- (IBAction)doneButton
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction)editDone
{
	[self.tableView setEditing:NO animated:YES];
	UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                             target:self action:@selector(editButton)];
	[self.navigationItem setLeftBarButtonItem:editBtn animated:YES];
	UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(doneButton)];
	[self.navigationItem setRightBarButtonItem:dismissButton animated:YES];
	[editBtn release];
	[dismissButton release];	
}

- (IBAction)editButton
{
	[self.tableView setEditing:YES animated:YES];
	UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self action:@selector(editDone)];
	[self.navigationItem setRightBarButtonItem:editBtn animated:YES];
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	[editBtn release];
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
	return 50;
}


#pragma mark - Table view data source

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(int)previousUserRating to:(int)userRating
{	

}

- (void)ratingView:(SCRatingView *)ratingView didChangeRatingFrom:(float)previousRating to:(float)rating
{

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.parent.arrayDBRated count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		NSString *id_rated = [[self.parent.arrayDBRated objectAtIndex:indexPath.row] objectForKey:@"Id"];
		int id_rated_int = [id_rated intValue];
		
		[[self.parent.arrayDB objectAtIndex:id_rated_int] setValue:@"0" forKey:@"Rating"];
		[self.parent.arrayDBRated removeObjectAtIndex:indexPath.row];
		
		//store in the plist files
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *pathRatedDocs = [documentsDirectory stringByAppendingPathComponent:@"Rated.plist"];
		NSString *pathQuotesDocs = [documentsDirectory stringByAppendingPathComponent:@"Quotes.plist"];
		
		BOOL arrayDBsaved = [self.parent.arrayDB writeToFile:pathQuotesDocs atomically:YES];
		BOOL arrayDBRatedsaved = [self.parent.arrayDBRated writeToFile:pathRatedDocs atomically:YES];
        
        NSAssert(arrayDBsaved, @"arrayDB saving failed");
        NSAssert(arrayDBRatedsaved, @"arrayDBRated saving failed");
        
		[self.parent showInfoSetEntry:[self.parent.arrayDB objectAtIndex:id_rated_int] setIndex:id_rated_int];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *id_rated = [[self.parent.arrayDBRated objectAtIndex:indexPath.row] objectForKey:@"Id"];
	NSDictionary *entry = [self.parent.arrayDB objectAtIndex:[id_rated intValue]];
	
    static NSString *CellIdentifier = @"RatedCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	UIView *ratingUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 100, 300)];
	SCRatingView *ratingView = [[SCRatingView alloc] initWithFrame:CGRectMake(160, 2, 150, 61)];
	
	[ratingView setStarImage:[UIImage imageNamed:@"small-star-nonselected.png"] forState:kSCRatingViewNonSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"small-star-selected.png"] forState:kSCRatingViewSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"small-star-halfselected.png"] forState:kSCRatingViewHalfSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"small-star-hot.png"] forState:kSCRatingViewHot];
	[ratingView setStarImage:[UIImage imageNamed:@"small-star-highlighted.png"] forState:kSCRatingViewHighlighted];
	
	[cell addSubview:ratingUIView];
	
	ratingView.userInteractionEnabled = NO;
	[ratingView setDelegate:self];
	[ratingUIView addSubview:ratingView];
	ratingView.rating =  (CGFloat)[[entry objectForKey:@"Rating"] intValue];
	
	cell.textLabel.text = [entry objectForKey:@"Citation"];
	cell.detailTextLabel.text = @" ";
	
	[ratingUIView release];
	[ratingView release];
	
	return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int id_rated = [[[self.parent.arrayDBRated objectAtIndex:indexPath.row] objectForKey:@"Id"] intValue];
	[self.parent showInfoSetEntry:[self.parent.arrayDB objectAtIndex:id_rated] setIndex:id_rated];
	[self.navigationController dismissModalViewControllerAnimated:YES];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[super dealloc];
}


@end

