//
//  SCSegment.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 1/26/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import "SCGrfx.h"
#import "SCSegment.h"
#import "SCMemoryManagement.h"

@interface SCSegment (/* Private methods */) 

- (void)__initializeComponent:(SCSegmentStyle)style;

@end

@interface SCSegment (Drawing)

- (void)clipBackground:(CGContextRef)c;
- (void)clipForeground:(CGContextRef)c;
- (void)clipCore:(CGContextRef)c rect:(CGRect)rect;

@end

@implementation SCSegment

@synthesize colorScheme = _colorScheme;
@synthesize selected = _selected;
@synthesize style = _style;
@synthesize titleLabel = _titleLabel;

- (void)setSelected:(BOOL)value {
	
	if (_selected != value) {
		
		_selected = value;
		self.titleLabel.highlighted = _selected;
		[self setNeedsDisplay];
	}
}

- (void)setStyle:(SCSegmentStyle)value {
	
	if (_style != value) {
		
		_style = value;
		[self setNeedsDisplay];
	}
}

+ (SCSegment *)segmentWithStyle:(SCSegmentStyle)style {
	
	return [[[SCSegment alloc] initWithStyle:style] autorelease];
}

- (id)init {
	
	return [self initWithFrame:CGRectMake(0, 0, 100, 37)];
}

- (id)initWithStyle:(SCSegmentStyle)style {
	
	return [self initWithStyle:style frame:CGRectMake(0, 0, 100, 37)];
}

- (id)initWithFrame:(CGRect)frame {
	
	return [self initWithStyle:SCSegmentCenter frame:frame];
}

- (id)initWithStyle:(SCSegmentStyle)style frame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self __initializeComponent:style];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	
	if (self = [super initWithCoder:decoder]) {
		[self __initializeComponent:SCSegmentCenter];
	}
	return self;
}

- (void)dealloc {
	
	SC_RELEASE_SAFELY(_titleLabel);
	
	[super dealloc];
}

- (void)__initializeComponent:(SCSegmentStyle)style {
	
	_style = style;
	
	self.backgroundColor = [UIColor clearColor];
	
	_titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_titleLabel.backgroundColor = [UIColor clearColor];
	_titleLabel.textAlignment = UITextAlignmentCenter;
	_titleLabel.textColor = [UIColor blackColor];
	_titleLabel.highlightedTextColor = [UIColor whiteColor];
	
	[self addSubview:_titleLabel];
}

@end


#define kForeColorArraySize	16

static CGFloat _DefaultForeColor[kForeColorArraySize] = {
	/* Stop 1 */ .15, .36, .73, 1,
	/* Stop 2 */ .21, .49, .92, 1,
	/* Stop 3 */ .27, .53, .93, 1,
	/* Stop 4 */ .42, .65, .99, 1
};

static CGFloat _BlackOpaqueForeColor[kForeColorArraySize] = {	
	/* Stop 1 */ .01, .01, .01, 1,
	/* Stop 2 */ .11, .11, .11, 1,
	/* Stop 3 */ .16, .16, .16, 1,
	/* Stop 4 */ .29, .29, .29, 1
};

#define kBorderWidth			1.
#define kCornerRadius			10.
#define kBorderStates			2
#define kBorderComponentCount	kBorderStates * 4

static CGFloat _DefaultBorderComponents[kBorderStates][kBorderComponentCount] = {
	/* Default */ { /* Stop 1 */ .68, .68, .68, 1, /* Stop 2 */ .61, .61, .61, 1 },
	/* Selected */ { /* Stop 1 */ 0, .2, .53, 1, /* Stop 2 */ .3, .53, .88, 1 }
};

static CGFloat _BlackOpaqueBorderComponents[kBorderStates][kBorderComponentCount] = {
	/* Default */ { /* Stop 1 */ .68, .68, .68, 1, /* Stop 2 */ .61, .61, .61, 1 },
	/* Selected */ { /* Stop 1 */ .01, .01, .01, 1, /* Stop 2 */ .29, .29, .29, 1 }
};

static CGFloat _BorderLocations[2] = { 0, 1 };

@implementation SCSegment (Drawing)

- (void)drawRect:(CGRect)rect {
	
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat width = CGRectGetWidth(self.frame);
	CGFloat height = CGRectGetHeight(self.frame);
	
	CGColorSpaceRef gradientColorSpace = CGColorSpaceCreateDeviceRGB();
	CGPoint gradientStartPoint = CGPointMake(width / 2., 0);
	CGPoint gradientEndPoint = CGPointMake(width / 2., height);
	
	/* Border */
	
	[self clipBackground:context];
	
	CGFloat *borderComponents;
	
	if (SCSegmentColorSchemeBlackOpaque == self.colorScheme) {
		borderComponents = _BlackOpaqueBorderComponents[self.selected];
	} else {
		borderComponents = _DefaultBorderComponents[self.selected];
	}

	CGGradientRef borderGradient = CGGradientCreateWithColorComponents(gradientColorSpace
																	   , borderComponents
																	   , _BorderLocations
																	   , 2);
	CGContextDrawLinearGradient(context, borderGradient, gradientStartPoint
								, gradientEndPoint, kCGGradientDrawsBeforeStartLocation);
	
	CFRelease(borderGradient);
	
	/* Foreground */
	
	[self clipForeground:context];
	
	if (self.selected) {
		
		CGFloat *colorScheme;
		
		if (SCSegmentColorSchemeBlackOpaque == self.colorScheme) {
			colorScheme = _BlackOpaqueForeColor;
		} else {
			colorScheme = _DefaultForeColor;
		}
		
		CGFloat foreLocations[4] = { 0, .5, .5, 1 };
		CGGradientRef foreGradient = CGGradientCreateWithColorComponents(gradientColorSpace, colorScheme
																		 , foreLocations, 4);
		
		CGContextDrawLinearGradient(context, foreGradient, gradientStartPoint
									, gradientEndPoint, kCGGradientDrawsBeforeStartLocation);
		CFRelease(foreGradient);
		
	} else {
		
		CGFloat foreComponents[8] = {
			/* Stop 1 */ .97, .97, .97, 1,
			/* Stop 2 */ .78, .78, .78, 1
		};
		CGFloat foreLocations[2] = { 0, 1 };
		CGGradientRef foreGradient = CGGradientCreateWithColorComponents(gradientColorSpace, foreComponents
																		 , foreLocations, 2);
		CGContextDrawLinearGradient(context, foreGradient, gradientStartPoint
									, gradientEndPoint, kCGGradientDrawsBeforeStartLocation);
		CFRelease(foreGradient);
	}
	
	CFRelease(gradientColorSpace);
}

- (void)clipBackground:(CGContextRef)c {
	
	[self clipCore:c rect:self.bounds];
}

- (void)clipForeground:(CGContextRef)c {
	
	CGRect rect = self.bounds;
	
	CGFloat left = CGRectGetMinX(rect);
	CGFloat top = CGRectGetMinY(rect);
	CGFloat width = CGRectGetWidth(rect);
	CGFloat height = CGRectGetHeight(rect);
	
	CGRect foreRect;
	
	if (self.selected) {
		
		foreRect = CGRectMake(left + kBorderWidth, top + kBorderWidth, width - kBorderWidth, height - kBorderWidth * 2);
		
	} else {
		
		foreRect = CGRectMake(left, top + kBorderWidth, width - kBorderWidth, height - kBorderWidth * 2);
		
		switch (self.style) {
			case SCSegmentLeftRound:
			case SCSegmentLeftBottomRound:
			case SCSegmentLeftTopRound:
			case SCSegmentLeft:
				foreRect.origin.x += kBorderWidth;
				foreRect.size.width -= kBorderWidth;
				break;
		}
	}
	
	[self clipCore:c rect:foreRect];
}

- (void)clipCore:(CGContextRef)c rect:(CGRect)rect {
	
	switch (self.style) {
		case SCSegmentLeftRound:
			SCContextAddLeftRoundedRect(c, rect, kCornerRadius);
			break;
		case SCSegmentLeftBottomRound:
			SCContextAddLeftBottomRoundedRect(c, rect, kCornerRadius);
			break;
		case SCSegmentLeftTopRound:
			SCContextAddLeftTopRoundedRect(c, rect, kCornerRadius);
			break;
		case SCSegmentRightRound:
			SCContextAddRightRoundedRect(c, rect, kCornerRadius);
			break;
		case SCSegmentRightTopRound:
			SCContextAddRightTopRoundedRect(c, rect, kCornerRadius);
			break;
		case SCSegmentRightBottomRound:
			SCContextAddRightBottomRoundedRect(c, rect, kCornerRadius);
			break;
		default:
			SCContextAddRoundedRect(c, rect, 0);
			break;
	}
	
	CGContextClip(c);
}

@end
