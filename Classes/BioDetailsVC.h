//
//  BioDetailsVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BioDetailsVC : UIViewController {

	NSDictionary *details;
	IBOutlet UITextView *txtDetails;
	IBOutlet UILabel *txtSubtitle;
	IBOutlet UIImageView *imgView;
	IBOutlet UIImageView *backgroundView;
}
	
@property (nonatomic, retain) NSDictionary *details;

@end
