//
//  MLPadSplitViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadSplitViewController.h"

@interface MLPadSplitViewController ()

- (void)configureLeftViewController;
- (void)configureRightViewController;

@end

@implementation MLPadSplitViewController

@synthesize leftViewController = _leftViewController, rightViewController = _rightViewController;

#pragma mark - Controller Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self configureLeftViewController];
    [self configureRightViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Configuration

- (void)configureLeftViewController
{
    
}

- (void)configureRightViewController
{
    
}

@end
