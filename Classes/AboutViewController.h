//
//  AboutViewController.h
//  Utility
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewControllerDelegate;


@interface AboutViewController : UIViewController {
    
	id <AboutViewControllerDelegate> delegate;
    IBOutlet UILabel *lblTitle, *lblDescription, *lblDevelopers, *lblVersion;
}

@property (nonatomic, assign) id <AboutViewControllerDelegate> delegate;

- (IBAction) done;

@end


@protocol AboutViewControllerDelegate
- (void)AboutViewControllerDidFinish:(AboutViewController *)controller;
@end

