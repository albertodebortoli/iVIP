//
//  QuotesTVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuotesDetailsVC.h"

@interface QuotesTVC : UITableViewController {
	
	QuotesDetailsVC *parent;
}

@property (nonatomic, assign) QuotesDetailsVC *parent;

@end
