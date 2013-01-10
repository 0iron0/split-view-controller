//
//  MLMenuContentItemCell.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/8/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLMenuCourseMapItemCell.h"

#define COURSE_MAP_ITEM_CELL_PICTURE_TEXT_BUFFER 10

@interface MLMenuCourseMapItemCell () {
    UIImageView *_imageView;
}

- (void)configureImageView;

- (CGRect)imageViewFrame;

@end

@implementation MLMenuCourseMapItemCell

@synthesize image = _image;

#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self configureImageView];
    }
    return self;
}

- (void)dealloc
{
    [_imageView release];
    [_image release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = [self imageViewFrame];
}

#pragma mark - Configuration

- (void)configureImageView
{
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image {
    [_image release];
    _image = [image retain];
    
    _imageView.image = _image;
}

#pragma mark - Frame Defines

- (CGRect)textLabelFrame {
    CGRect defaultFrame = [super textLabelFrame];
    int offset = (_image) ? _image.size.width + COURSE_MAP_ITEM_CELL_PICTURE_TEXT_BUFFER : 0;
    
    defaultFrame.origin.x += offset;
    defaultFrame.size.width -= offset;
    
    return defaultFrame;
}

- (CGRect)imageViewFrame {
    return CGRectMake([super textLabelFrame].origin.x,
                      CGRectGetMidY(self.bounds) - _image.size.height/2,
                      _image.size.width,
                      _image.size.height);
}

#pragma mark - View Overrides

- (float)textLeftBuffer {
    return COURSE_MAP_ITEM_CELL_PICTURE_TEXT_BUFFER;
}

@end
