//
//  QuotesDetailsVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SCRatingView.h>

@interface QuotesDetailsVC : UIViewController <SCRatingDelegate, UIActionSheetDelegate> {

	// array containing the content of the plist file associated to the class
	NSMutableArray *arrayDB;
	NSMutableArray *arrayDBRated;
	int index; //keep track of the ID (the position of the quote in the array/plist)
	NSDictionary *entry;
	
	IBOutlet UITextView *txtDetails;
	IBOutlet UILabel *txtSubtitle;
	IBOutlet UIView *ratingUIView;
	IBOutlet UILabel *sourceYear;
	IBOutlet UIImageView *imgView;
	IBOutlet UIImageView *backgroundView;
	IBOutlet UIButton *btnShare;
	IBOutlet UIButton *btnPickRandom;
	IBOutlet SCRatingView *ratingView;
}

- (void) ratingViewLoad;
- (void) loadFromPlist;
- (void) showInfoSetEntry:(NSDictionary *)dictionary setIndex:(int)index;


@property (nonatomic, retain) NSMutableArray *arrayDB;
@property (nonatomic, retain) NSMutableArray *arrayDBRated;

- (IBAction) share;
- (IBAction) randomChoice;
- (IBAction) favouritesView;
- (IBAction) listView;

@end
