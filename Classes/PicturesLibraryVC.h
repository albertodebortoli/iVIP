//
//  PicturesLibraryVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturesLibraryVC : UIViewController {

	NSDictionary *details;
	IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) NSDictionary *details;

@end
