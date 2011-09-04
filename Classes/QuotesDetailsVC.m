//
//  QuotesDetailsVC.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "iVIPAppDelegate.h"
#import "QuotesDetailsVC.h"
#import "QuotesTVC.h"
#import "QuotesRatedTVC.h"
#import "SHK.h"
#import "SHKFacebook.h"
#import "SHKTwitter.h"
#import "SHKMail.h"
#import "SHKCopy.h"

@implementation QuotesDetailsVC

@synthesize arrayDB, arrayDBRated;

- (void)viewDidLoad
{
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	[self loadFromPlist];
	
	int random = arc4random() % [arrayDB count];
	
	// background UIImageView
	imgView.layer.masksToBounds = YES;
	imgView.layer.cornerRadius = 20;
	imgView.layer.borderWidth = 3;
	imgView.layer.borderColor = [[UIColor whiteColor] CGColor];
	imgView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
	
	backgroundView.layer.masksToBounds = YES;
	backgroundView.layer.cornerRadius = 20;
	backgroundView.layer.borderWidth = 3;
	backgroundView.layer.borderColor = [[UIColor whiteColor] CGColor];
	backgroundView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];

	btnShare.layer.masksToBounds = YES;
	btnShare.layer.cornerRadius = 10;
	btnShare.layer.borderWidth = 2;
	btnShare.layer.borderColor = [[UIColor whiteColor] CGColor];
	btnShare.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
	[btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	btnPickRandom.layer.masksToBounds = YES;
	btnPickRandom.layer.cornerRadius = 10;
	btnPickRandom.layer.borderWidth = 2;
	btnPickRandom.layer.borderColor = [[UIColor whiteColor] CGColor];
	btnPickRandom.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
	[btnPickRandom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	imgView.frame = backgroundView.frame;	
	
	[ratingUIView setBackgroundColor:[UIColor clearColor]];
	[txtDetails setBackgroundColor:[UIColor clearColor]];
	
	UIBarButtonItem *listButton = [[UIBarButtonItem	alloc] initWithImage:[UIImage imageNamed:@"buttonList.png"] style:UIBarButtonItemStylePlain target:self action:@selector(listView)];
	[self.navigationItem setLeftBarButtonItem:listButton];
	
	UIBarButtonItem *favouritesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"buttonStar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(favouritesView)];
	[self.navigationItem setRightBarButtonItem:favouritesButton];
	
	[self ratingViewLoad];
	
	self.title = @"Random quote";
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	delegate.tabBarController.tabBar.selectedItem.title = @"Quotes";
    
	[listButton release];
	[favouritesButton release];
	
	[self showInfoSetEntry:[arrayDB objectAtIndex:random] setIndex:random];
    [super viewDidLoad];
}

- (void)ratingViewLoad
{
	ratingView = [[SCRatingView alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
	
	[ratingView setStarImage:[UIImage imageNamed:@"star-halfselected.png"]	forState:kSCRatingViewHalfSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"star-highlighted.png"]	forState:kSCRatingViewHighlighted];
	[ratingView setStarImage:[UIImage imageNamed:@"star-hot.png"]			forState:kSCRatingViewHot];
	[ratingView setStarImage:[UIImage imageNamed:@"star-nonselected.png"]	forState:kSCRatingViewNonSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"star-selected.png"]		forState:kSCRatingViewSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"star-userselected.png"]	forState:kSCRatingViewUserSelected];
	
	[ratingView setDelegate:self];
	[ratingUIView addSubview:ratingView];
}

- (void)loadFromPlist
{	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *pathQuotesDocs = [documentsDirectory stringByAppendingPathComponent:@"Quotes.plist"];
	arrayDB = [[NSMutableArray alloc] initWithContentsOfFile:pathQuotesDocs];
	NSString *pathRatedDocs = [documentsDirectory stringByAppendingPathComponent:@"Rated.plist"];
	arrayDBRated = [[NSMutableArray alloc] initWithContentsOfFile:pathRatedDocs];
}

- (void)showInfoSetEntry:(NSDictionary *)_entry setIndex:(int)_ID
{
	//set fields
	entry = _entry;
	index = _ID;
			 
	//show infos
	txtDetails.text = [entry objectForKey:@"Citation"];
	sourceYear.text = [NSString stringWithFormat: @"%@\n(%@)", [entry objectForKey:@"Source"], [entry objectForKey:@"Year"]];
	ratingView.rating =  (CGFloat)[[entry objectForKey:@"Rating"] intValue];	
}

- (IBAction)randomChoice
{	
	int random = arc4random() % [self.arrayDB count];
	[self showInfoSetEntry:[self.arrayDB objectAtIndex:random] setIndex:random];
	[txtDetails setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)ratingView:(SCRatingView *)_ratingView didChangeUserRatingFrom:(int)_previousUserRating to:(int)_userRating
{	
	// update arrayDB with new rating value
	[[arrayDB objectAtIndex:index] setValue:[NSString stringWithFormat:@"%d", _userRating] forKey:@"Rating"]; 
	// update specific entry (class field) with new rating value
	[entry setValue:[NSString stringWithFormat:@"%d", _userRating] forKey:@"Rating"];
	
	// search in arrayDBRated for the entry that represents the quote just rated
	BOOL found = NO;
	for (int i = 0; (i < [self.arrayDBRated count]) && !found; i++) {
		if ([[[self.arrayDBRated objectAtIndex:i] objectForKey:@"Id"] intValue] == self->index) {
			found = YES;
		}
	}
	// or add a new entry (Dictionary) if it's not exists
	if (!found)
		[self.arrayDBRated addObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", self->index]
                                                                 forKey:@"Id"]];
	
	// store the new values in the plist files
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *pathQuotes = [documentsDirectory stringByAppendingPathComponent:@"Quotes.plist"];
	NSString *pathRated = [documentsDirectory stringByAppendingPathComponent:@"Rated.plist"];
	
	BOOL arrayDBsaved = [self.arrayDB writeToFile:pathQuotes atomically:YES];
    BOOL arrayDBRatedsaved = [self.arrayDBRated writeToFile:pathRated atomically:YES];	
    
    NSAssert(arrayDBsaved, @"arrayDB saving failed");
    NSAssert(arrayDBRatedsaved, @"arrayDBRated saving failed");
    
	[self showInfoSetEntry:entry setIndex:index];
	
	[ratingView removeFromSuperview];
	[ratingView release];
	[self ratingViewLoad];
		
	ratingView.rating =  (CGFloat)[[entry objectForKey:@"Rating"] intValue];
}

- (void)ratingView:(SCRatingView *)_ratingView didChangeRatingFrom:(float)_previousRating to:(float)_rating
{	
	[self showInfoSetEntry:entry setIndex:index];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *textQuote = [NSString stringWithFormat:@"\"%@\" -%@ (via %@ for iPhone)", txtDetails.text, kVIPname, kApplicationName];
	SHKItem *item;

	if (buttonIndex == 0) {
		item = [SHKItem text:textQuote];
		[SHKTwitter shareItem:item];
	}
	if (buttonIndex == 1) {
		item = [SHKItem text:textQuote];
		[SHKMail shareItem:item];
	}
	if (buttonIndex == 2) {
		UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = textQuote;
        
		NSString *testo = [NSString stringWithFormat:@"\"%@\" -%@ (via %@ for iPhone)", txtDetails.text, kVIPname, kApplicationName];
		NSURL *url = [NSURL URLWithString:kApplicationWebPage];
		SHKItem *item = [SHKItem URL:url title:testo];
		[SHKFacebook shareItem:item];
		
		UIAlertView *alert = [[UIAlertView alloc] 
		initWithTitle:@"Message" 
		message:@"The quote has been copied into your clipboard.\nPaste it into the Facebook message box."
		delegate:nil cancelButtonTitle:@"Ok!" 
		otherButtonTitles:nil];
		alert.delegate = self;
		[alert show];
		[alert release];
	}
	if (buttonIndex == 3) {
		item = [SHKItem text:textQuote];
		[SHKCopy shareItem:item];
	}
}

- (IBAction)share
{
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter",@"Mail", @"Facebook",@"Copy",nil];
	sheet.actionSheetStyle = UIActionSheetStyleDefault;
	
	iVIPAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[sheet showFromTabBar:delegate.tabBarController.tabBar];
	[sheet release];
}


- (IBAction)favouritesView
{
	QuotesRatedTVC *quotesFav = [[QuotesRatedTVC alloc] initWithNibName:@"QuotesRatedTVC" bundle:nil];
	quotesFav.parent = self;
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:quotesFav];
	[self presentModalViewController:navigation animated:YES];
	[quotesFav release];
	[navigation release];
	
}

- (IBAction)listView
{
	QuotesTVC *quotesList = [[QuotesTVC alloc] initWithNibName:@"QuotesTVC" bundle:nil];
	quotesList.parent = self;
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:quotesList];
	[self presentModalViewController:navigation animated:YES];
	[quotesList release];
	[navigation release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[entry release];
	[txtDetails release];
	[txtSubtitle release];
	[ratingUIView release];
	[ratingView release];
	[sourceYear release];
	[imgView release];
	[backgroundView release];
	[btnShare release];
	[btnPickRandom release];
	[arrayDB release];
	[arrayDBRated release];
    [super dealloc];
}


@end
