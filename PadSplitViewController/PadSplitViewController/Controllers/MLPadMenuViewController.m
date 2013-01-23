//
//  MLPadMenuViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuViewController.h"
#import "MLPadMenuTableView.h"
#import "MLMenuFooterView.h"
#import "MLMenuCourseCell.h"
#import "MLMenuSectionHeaderView.h"

#define MENU_NAVIGATION_BAR_HEIGHT 44
#define PAD_MENU_NAV_BAR_COLOR [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0]

#define MENU_CONTROLLER_CELL_HEIGHT 68
#define MENU_RIGHT_DIVIDER_WIDTH 1
#define MENU_RIGHT_DIVIDER_COLOR [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1.0]

#define MENU_SECTION_HEADER_HEIGHT 32

@interface MLPadMenuViewController () {
    MLPadMenuTableView *_tableView;
    MLMenuFooterView *_footerView;
    UIView *_rightDivider;
}

- (void)configureSelf;
- (void)configureNavigationBar;
- (void)configureTableView;
- (void)configureFooterView;
- (void)configureRightDivider;

- (CGRect)tableViewFrame;
- (CGRect)rightDividerFrame;

@end

@implementation MLPadMenuViewController

@synthesize menuNavigationController = _menuNavigationController;
@synthesize navigationBar = _navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self configureSelf];
        [self configureNavigationBar];
        [self configureFooterView];
        [self configureTableView];
        [self configureRightDivider];
    }
    return self;
}

- (void)dealloc
{
    [_navigationBar release];
    [_tableView release];
    [_rightDivider release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)configureNavigationBar
{
    _navigationBar = [[MLPadMenuNavigationBar alloc] init];
    _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _navigationBar.frame = [self navigationBarFrame];
    _navigationBar.parent = self;
    _navigationBar.backgroundColor = PAD_MENU_NAV_BAR_COLOR;
    [self.view addSubview:_navigationBar];
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

- (void)configureRightDivider
{
    _rightDivider = [[UIView alloc] init];
    _rightDivider.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    _rightDivider.frame = [self rightDividerFrame];
    _rightDivider.backgroundColor = MENU_RIGHT_DIVIDER_COLOR;
    [self.view addSubview:_rightDivider];
}

#pragma mark - Button Handling

- (void)backButtonPressed
{
    [self.menuNavigationController slideForwards]; //NOTE: should not pop for final version, just slide over
    [_navigationBar setBackButtonEnabled:NO animated:YES];
}

#pragma mark - Frames

- (CGRect)navigationBarFrame {
    return CGRectZero;
}

- (CGRect)tableViewFrame {
    return CGRectMake(0,
                      CGRectGetMaxY(_navigationBar.frame),
                      self.view.bounds.size.width,
                      self.view.bounds.size.height - CGRectGetMaxY(_navigationBar.frame) - _footerView.bounds.size.height);
}

- (CGRect)rightDividerFrame {
    return CGRectMake(self.view.bounds.size.width - MENU_RIGHT_DIVIDER_WIDTH,
                      CGRectGetMaxY(_navigationBar.frame),
                      MENU_RIGHT_DIVIDER_WIDTH,
                      self.view.bounds.size.height - _navigationBar.bounds.size.height);
}

#pragma mark - View Defines

- (float)navigationBarHeight {
    return MENU_NAVIGATION_BAR_HEIGHT;
}

- (float)cellHeight {
    return MENU_CONTROLLER_CELL_HEIGHT;
}

#pragma mark - TableView DataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0; //implement in subclasses
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    return MENU_SECTION_HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;
    return [[[MLMenuSectionHeaderView alloc] init] autorelease];
}

- (void)pushController:(UIViewController <MenuViewController>*)controller
{
    if (![[NSThread currentThread] isMainThread])
    {
        [self performSelectorOnMainThread:@selector(pushController:) withObject:controller waitUntilDone:YES];
        return;
    }
    [self.menuNavigationController pushViewController:controller animated:YES];
}

#pragma mark - Overrides

- (void)setTitle:(NSString *)title {
    _navigationBar.title = title;
}

- (NSString *)title {
    return _navigationBar.title;
}

@end
