//
//  VideosInCategory.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideosCategories : UITableViewController {
    
	NSArray * categories;
	NSArray * keynotes;
	NSArray * interviews;
	NSArray * funny;
	NSArray * miscellaneous;
	
	NSMutableArray * thumbnails;
}

@end
