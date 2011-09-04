//
//  iVIPAppDelegate.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import "iVIPAppDelegate.h"
#include <unistd.h>
#import "SHK.h"

@implementation iVIPAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize bioNC, extrasNC, picturesNC, videosNC;


#pragma mark - Application lifecycle

- (void)splashScreenAnimation
{
    [UIView animateWithDuration:kStartUpSplashFadeOut animations:^{
        splashView.alpha = 0.0;
        splashView.frame = CGRectMake(-60, -60, 440, 600);
    } completion:^(BOOL finished){
        [splashView removeFromSuperview];
        [splashView release];
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	splashView.image = [UIImage imageNamed:@"Default.png"];
	[window addSubview:splashView];
	[window bringSubviewToFront:splashView];
	

	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSString * notFirstRun = [defaults stringForKey:@"NotFirstRun"];

	if (notFirstRun == nil) {
		[defaults setValue:@"This is the first time you run this app!" forKey:@"NotFirstRun"];
		[defaults synchronize];
		
        NSString *msgText = kApplicationDescription;
		UIAlertView *copyrightAlertView = [[UIAlertView alloc] initWithTitle:@"Disclaimer"
                                                                     message:msgText 
                                                                    delegate:self
                                                           cancelButtonTitle:@"Ok!"
                                                           otherButtonTitles:nil];
		copyrightAlertView.delegate = self;
		[copyrightAlertView show];
		[copyrightAlertView release];
		
	} else {
		usleep(kSleepDuration);
		[self splashScreenAnimation];		
	}

	[SHK flushOfflineQueue];
	
    return YES;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{	
	[self splashScreenAnimation];		
}


#pragma mark - Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc
{
	[splashView release];
	[bioNC release];
	[extrasNC release];
	[picturesNC release];
	[videosNC release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

