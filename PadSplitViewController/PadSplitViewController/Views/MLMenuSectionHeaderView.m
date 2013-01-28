//
//  MLMenuSectionHeaderView.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLMenuSectionHeaderView.h"
#import "MLPixelDivider.h"

#define MENU_HEADER_PIXEL_DIVIDER_BUFFER 20
#define MENU_HEADER_PIXEL_DIVIDER_HEIGHT 10

@interface MLMenuSectionHeaderView () {
    UIView *_pixelDivider;
}

- (void)configureSelf;
- (void)configurePixelDivider;

- (CGRect)pixelDividerFrame;

@end

@implementation MLMenuSectionHeaderView

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureSelf];
        [self configurePixelDivider];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _pixelDivider.frame = [self pixelDividerFrame];
}    

#pragma mark - Configuration

- (void)configureSelf
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)configurePixelDivider
{
    _pixelDivider = [[MLPixelDivider alloc] init];
    [self addSubview:_pixelDivider];
}

#pragma mark - Frames

- (CGRect)pixelDividerFrame {
    return CGRectMake(MENU_HEADER_PIXEL_DIVIDER_BUFFER,
                      CGRectGetMidY(self.bounds) - MENU_HEADER_PIXEL_DIVIDER_HEIGHT/2,
                      self.bounds.size.width - MENU_HEADER_PIXEL_DIVIDER_BUFFER*2,
                      MENU_HEADER_PIXEL_DIVIDER_HEIGHT);
}

@end
