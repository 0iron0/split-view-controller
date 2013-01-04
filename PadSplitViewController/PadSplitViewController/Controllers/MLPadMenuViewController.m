//
//  MLPadMenuViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuViewController.h"
#import "MLMenuPinView.h"
#import "MLPadMenuTableView.h"

@interface MLPadMenuViewController () {
    MLMenuPinView *_pinView;
    MLPadMenuTableView *_tableView;
}

- (void)configurePinView;
- (void)configureNavigationBar;
- (void)configureTableView;

@end

@implementation MLPadMenuViewController

@synthesize menuNavigationController = _menuNavigationController;
@synthesize navigationBar = _navigationBar;

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

    self.view.backgroundColor = [UIColor redColor];
    [self configurePinView];
    [self configureNavigationBar];
    [self configureTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View Configuration

- (void)configurePinView
{
    
}

- (void)configureNavigationBar
{
    
}

- (void)configureTableView
{
    
}

@end
