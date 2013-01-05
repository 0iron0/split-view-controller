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
#import "MLMenuFooterView.h"

#define MENU_NAVIGATION_BAR_HEIGHT 44

@interface MLPadMenuViewController () {
    MLMenuPinView *_pinView;
    MLPadMenuTableView *_tableView;
    MLMenuFooterView *_footerView;
}

- (void)configureSelf;
- (void)configurePinView;
- (void)configureNavigationBar;
- (void)configureTableView;
- (void)configureFooterView;

- (CGRect)navigationBarFrame;
- (CGRect)tableViewFrame;

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

- (void)dealloc
{
    [_pinView release];
    [_navigationBar release];
    [_tableView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureSelf];
    [self configurePinView];
    [self configureNavigationBar];
    [self configureFooterView];
    [self configureTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View Configuration

- (void)configureSelf
{
    self.view.backgroundColor = [UIColor redColor];
}

- (void)configurePinView
{
    _pinView = [[MLMenuPinView alloc] init];
    _pinView.frame = CGRectZero;
    [self.view addSubview:_pinView];
}

- (void)configureNavigationBar
{
    _navigationBar = [[MLPadMenuNavigationBar alloc] init];
    _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _navigationBar.frame = [self navigationBarFrame];
    [self.view addSubview:_navigationBar];
    _navigationBar.title = @"Menu";
}

- (void)configureTableView
{
    _tableView = [[MLPadMenuTableView alloc] init];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.frame = [self tableViewFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)configureFooterView
{
    _footerView = [[MLMenuFooterView alloc] init];
    _footerView.frame = CGRectZero;
    [self.view addSubview:_footerView];
}

#pragma mark - Frames

- (CGRect)navigationBarFrame {
    return CGRectMake(0,
                      CGRectGetMaxY(_pinView.frame),
                      self.view.bounds.size.width,
                      [self navigationBarHeight]);
}

- (CGRect)tableViewFrame {
    return CGRectMake(0,
                      CGRectGetMaxY(_navigationBar.frame),
                      self.view.bounds.size.width,
                      self.view.bounds.size.height - _navigationBar.bounds.size.height - _pinView.bounds.size.height - _footerView.bounds.size.height);
}

#pragma mark - View Defines

- (float)navigationBarHeight {
    return MENU_NAVIGATION_BAR_HEIGHT;
}

#pragma mark - TableView DataSource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return [cell autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
