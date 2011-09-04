//
//  PicturesFullVC.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PicturesFullVC : UIViewController <UIActionSheetDelegate> {
	
	int numberOfImages;
	int numberOfCurrentImage;
	NSString *abbreviation;
	IBOutlet UIImage *imageFull;
	IBOutlet UIImageView *imageView;
	IBOutlet UIBarButtonItem *buttonPrev;
	IBOutlet UIBarButtonItem *buttonNext;
}

- (IBAction) photoPrev;
- (IBAction) photoNext;
- (IBAction) sharePic;

@property (nonatomic, retain) NSString *abbreviation;
@property (nonatomic) int numberOfImages;
@property (nonatomic) int numberOfCurrentImage;
@property (nonatomic, retain) IBOutlet UIImage *imageFull;

@end
