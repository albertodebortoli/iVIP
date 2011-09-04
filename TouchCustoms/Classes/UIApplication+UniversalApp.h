//
//  UIApplication+SCMethods.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 6/11/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//	
//	Purpose
//	Contains helper methods that help building universal apps for iPhone 3.1.2+ and iPad 3.2
//	that don't produce warnings during compile-time starting from iPhone SDK 3.1.2 and work
//	correctly on Apple devices starting from iPhone 2G with iPhone OS 3.1.2 installed and more
//	mordern devices.
//

#import <Foundation/Foundation.h>

@interface UIApplication (UniversalApp)

+ (void)setStatusBarHidden:(BOOL)value;

@end
