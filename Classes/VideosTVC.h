//
//  VideosTVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VideosTVC : UITableViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate> {
	
	// array containing the content of the plist file associated to the class
	NSArray * arrayDB;
	NSMutableArray * webViews;
	NSMutableArray * activityIndicators;
}

@end
