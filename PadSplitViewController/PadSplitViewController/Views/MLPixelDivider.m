//
//  MLPixelDivider.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/11/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPixelDivider.h"

#define PIXEL_DIVIDER_POINT_COLOR [UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1.0]

@interface MLPixelDivider ()

- (void)plotPoint:(CGPoint)point givenContext:(CGContextRef)context;

@end

@implementation MLPixelDivider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [PIXEL_DIVIDER_POINT_COLOR CGColor]);

    for (int x = 0; x < rect.size.width; x++)
    {
        for (int y = 0; y < rect.size.height; y++)
        {
            BOOL shouldPlot = NO;
            if (x % 5 == 0) {
                shouldPlot = (y % 5 == 0);
            }
            else if (x % 5 == 1) {
                shouldPlot = (y % 5 == 4);
            }
            else if (x % 5 == 2) {
                shouldPlot = (y % 5 == 3);
            }
            else if (x % 5 == 3) {
                shouldPlot = (y % 5 == 2);
            }
            else if (x % 5 == 4) {
                shouldPlot = (y % 5 == 1);
            }
            if (shouldPlot)
                [self plotPoint:CGPointMake(x, y) givenContext:context];
        }
    }
}

- (void)plotPoint:(CGPoint)point givenContext:(CGContextRef)context
{
    CGContextStrokeRectWithWidth(context, CGRectMake(point.x, point.y, 1, 1), 0.5);
}

@end
