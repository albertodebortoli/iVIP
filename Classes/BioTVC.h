//
//  BioTVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

@interface BioTVC : UITableViewController <UITableViewDelegate, UITableViewDataSource, AboutViewControllerDelegate> {

	// array containing the content of the plist file associated to the class
	NSArray *arrayDB;
}

- (IBAction)showInfo;

@end
