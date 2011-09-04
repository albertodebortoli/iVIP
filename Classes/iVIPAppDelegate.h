//
//  iVIPAppDelegate.h
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iVIPAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UIImageView *splashView;
	
	UITabBarController *tabBarController;
	UINavigationController *bioNC;
	UINavigationController *picturesNC;
	UINavigationController *videosNC;
	UINavigationController *extrasNC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *bioNC;
@property (nonatomic, retain) IBOutlet UINavigationController *picturesNC;
@property (nonatomic, retain) IBOutlet UINavigationController *videosNC;
@property (nonatomic, retain) IBOutlet UINavigationController *extrasNC;

@end
