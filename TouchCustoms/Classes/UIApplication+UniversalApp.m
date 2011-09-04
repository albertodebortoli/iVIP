//
//  UIApplication+SCMethods.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 6/11/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import "UIApplication+UniversalApp.h"

@implementation UIApplication (UniversalApp)

+ (void)setStatusBarHidden:(BOOL)value {

	UIApplication *app = [UIApplication sharedApplication];
	
#ifdef __IPHONE_3_2
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		
		[app setStatusBarHidden:value withAnimation:UIStatusBarAnimationSlide];
		
	} else {
		
		if ([app respondsToSelector:@selector(setStatusBarHidden:withAnimation:)]) {
			
			[app setStatusBarHidden:value withAnimation:UIStatusBarAnimationSlide];
			
		} else {
			
			BOOL animated = YES;
			
			SEL theSelector = @selector(setStatusBarHidden:animated:);
			NSMethodSignature *aSignature = [UIApplication instanceMethodSignatureForSelector:theSelector];
			NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
			
			[anInvocation setSelector:theSelector];
			[anInvocation setTarget:app];
			
			[anInvocation setArgument:&value atIndex:2];
			[anInvocation setArgument:&animated atIndex:3];
			
			[anInvocation invoke];
		}
	}
	
#else
	
	[app setStatusBarHidden:value animated:YES];
	
#endif
}

@end
