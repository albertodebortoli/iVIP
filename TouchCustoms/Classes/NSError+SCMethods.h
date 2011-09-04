//
//  NSError+SCMethods.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/14/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//	
//	Purpose
//	Extension methods for NSError.
//

#import <Foundation/Foundation.h>

@interface NSError (SCMethods)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code
				 description:(NSString *)description failureReason:(NSString *)failReason;

@end
