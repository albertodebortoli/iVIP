//
//  UIApplication+LocalNotifications.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 6/11/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import "UIApplication+LocalNotifications.h"

@implementation UIApplication (LocalNotifications)

+ (void)showLocalNotification:(NSString *)text {
	
	[UIApplication showLocalNotification:text actionButton:nil];
}

+ (void)showLocalNotification:(NSString *)text actionButton:(NSString *)buttonText {

#ifdef __IPHONE_4_0	
	
	Class notificationClass = NSClassFromString(@"UILocalNotification");
	
	if (notificationClass) {
		
		id notification = [[notificationClass alloc] init];
		
		if (notification) {
			
			[notification setAlertBody:text];
			[notification setAlertAction:buttonText];
			[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
			[notification release];
		}
	}
	
#endif		
}

@end
