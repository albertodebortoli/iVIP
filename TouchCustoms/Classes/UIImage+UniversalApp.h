//
//  UIImage+UniversalApp.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 6/17/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (UniversalApp)

/*
 
 Use this when you have different images for a large-scale display and a normal one.
 While iPhone OS 4 is capable of selecting such an image itself based on image name
 without extension, earlier OS versions require extension to load an image.
 
 Suppose you have Button.png and Button@2x.png and need to launch the app starting
 from iPhone OS 3.1.2. In this case load image in this way:
 
 UIImage *buttonImage = [UIImage imageNamedFallbackToPng:@"Button"];
 
 And the code will do all the rest for you.
 
 */
+ (UIImage *)imageNamedFallbackToPng:(NSString *)path;
+ (UIImage *)imageNamed:(NSString *)path fallbackToExtension:(NSString *)extension;

@end
