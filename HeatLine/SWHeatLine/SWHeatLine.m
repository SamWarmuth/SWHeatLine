//
//  SWHeatLine.m
//  HeatLine
//
//  Created by Samuel Warmuth on 3/20/13.
//  Copyright (c) 2013 Sam Warmuth. All rights reserved.
//

#import "SWHeatLine.h"
@interface SWHeatLine ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation SWHeatLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.type = SWHeatLineTypeGrades;
        self.values = @[@0,@100];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.values = @[@0,@10,@20,@70,@40,@50,@60,@70,@80,@90,@100,@100,@80,@60,@40,@60,@80,@80,@80,@100,@100];
        self.type = SWHeatLineTypeGrades;
    }
    return self;
}

- (void)setType:(SWHeatLineType)type
{
    _type = type;
    self.colors = nil;
    [self setNeedsDisplay];
}

- (NSArray *)colors
{
    if (_colors) return _colors;
    NSMutableArray *colors = [NSMutableArray new];
    for (NSNumber *number in self.values) {
        if (![number isKindOfClass:[NSNumber class]]) continue;
        UIColor *color = [self colorForValue:[number floatValue]];
        if (color) [colors addObject:(id)color.CGColor];
    }
    _colors = colors;
    return _colors;
}

- (void)drawRect:(CGRect)rect
{
    if (!self.colors || self.colors.count == 0) return;
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *strokeColor = [UIColor colorWithRed:0.725 green:0.725 blue:0.725 alpha:1];
    //// Color Declarations
    
    //// Gradient Declarations
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.colors, NULL);
    
    //// Rectangle Drawing
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:rect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    
    CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    [strokeColor setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (UIColor *)colorForValue:(CGFloat)value
{
    value = MIN(value, 100.0);
    //Value 0 - 100 maps to hue 0 - .277, e.g. 40 is .125
    CGFloat hueValue;

    switch (self.type) {
        case SWHeatLineTypeFull:
            hueValue = value/360;
            break;
        case SWHeatLineTypeGrades:
            hueValue = value/250 - .14;
            break;
        case SWHeatLineTypeHue:
        default:
            hueValue = value/100;
            break;
    }
    
    if (hueValue < 0.1) hueValue = 0;
    UIColor *color = [UIColor colorWithHue:hueValue saturation:1.0 brightness:1.0 alpha:1.0];
    return color;
}

@end
