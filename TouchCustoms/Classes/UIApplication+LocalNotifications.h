//
//  UIApplication+LocalNotifications.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 6/11/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//	
//	Purpose
//	Contains helper methods to work easily with Local notifications.
//

#import <Foundation/Foundation.h>

@interface UIApplication (LocalNotifications)

+ (void)showLocalNotification:(NSString *)text;
+ (void)showLocalNotification:(NSString *)text actionButton:(NSString *)buttonText;

@end
