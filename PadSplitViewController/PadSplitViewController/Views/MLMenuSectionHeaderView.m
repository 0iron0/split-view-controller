//
//  MLMenuSectionHeaderView.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLMenuSectionHeaderView.h"

#define MENU_HEADER_IMAGE_BUFFER 14

@interface MLMenuSectionHeaderView () {
    UIImageView *_imageView;
}

- (void)configureSelf;
- (void)configureImageView;

- (CGRect)imageViewFrame;

@end

@implementation MLMenuSectionHeaderView

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureSelf];
        [self configureImageView];
    }
    return self;
}

- (void)dealloc
{
    [_imageView release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = [self imageViewFrame];
}

#pragma mark - Configuration

- (void)configureSelf
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)configureImageView
{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalRule.png"]];
    [self addSubview:_imageView];
}

#pragma mark - Frames

- (CGRect)imageViewFrame {
    return CGRectMake(MENU_HEADER_IMAGE_BUFFER,
                      CGRectGetMidY(self.bounds) - [UIImage imageNamed:@"horizontalRule.png"].size.height/2,
                      self.bounds.size.width - MENU_HEADER_IMAGE_BUFFER*2,
                      [UIImage imageNamed:@"horizontalRule.png"].size.height);
}

@end
