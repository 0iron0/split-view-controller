//
//  MLPadContentViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/16/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadContentViewController.h"

@interface MLPadContentViewController () {
    
}

- (void)configureSelf;
- (void)configureImageView;

@end

@implementation MLPadContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self configureSelf];
        [self configureImageView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)configureSelf
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)configureImageView
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.2-Comment.png"]];
    image.frame = self.view.bounds;
    image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:image];
    [image release];}

@end
