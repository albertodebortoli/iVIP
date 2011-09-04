//
//  main.m
//  iVIP
//
//  Created by Alberto De Bortoli, Andrea Giavatto, Silvio Daminato on July 2010.
//  Copyright 2010 Alberto De Bortoli, Andrea Giavatto, Silvio Daminato. All rights reserved.
//

#import <UIKit/UIKit.h>

void copyNeededFilesFromBundleToDocumentsDirectory() {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	NSString *pathRated = [documentsDirectory stringByAppendingPathComponent:@"Rated.plist"];
	NSMutableArray *plist = [NSMutableArray array];
	
	BOOL ratedExists = [[NSFileManager defaultManager] fileExistsAtPath:pathRated];
	
    // if Rated.plist does not exist in the documents directory, neither Quotes.plist is there
    // we need to copy Quotes.plist and create an empty Rated.plist to allow quote rating 
	if (!ratedExists){
		[[NSFileManager defaultManager] createFileAtPath:pathRated contents:nil attributes:nil];
		[plist writeToFile:pathRated atomically:YES];
		
		NSString *pathQuotesBundle = [[NSBundle mainBundle] pathForResource:@"Quotes" ofType:@"plist"];
		NSString *pathQuotesDocs = [documentsDirectory stringByAppendingPathComponent:@"Quotes.plist"];
		plist = [NSMutableArray arrayWithContentsOfFile:pathQuotesBundle];
		
		[[NSFileManager defaultManager] createFileAtPath:pathQuotesDocs contents:nil attributes:nil];
		[plist writeToFile:pathQuotesDocs atomically:YES];
    }
}

int main(int argc, char *argv[]) {

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    copyNeededFilesFromBundleToDocumentsDirectory();
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}

