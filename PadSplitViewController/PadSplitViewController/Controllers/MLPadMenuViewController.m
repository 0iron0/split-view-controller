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
#import "MLCourse.h"
#import "MLMenuCourseCell.h"
#import "MLMenuSectionHeaderView.h"

#define MENU_NAVIGATION_BAR_HEIGHT 44
#define MENU_CONTROLLER_CELL_HEIGHT 68

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
@synthesize courses = _courses;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        MLCourse *course1 = [[[MLCourse alloc] init] autorelease];
        course1.title = @"English 402";
        course1.color = [UIColor colorWithRed:213.0/255 green:20.0/255 blue:37.0/255 alpha:1.0];
        course1.unreadItems = 8;
        
        MLCourse *course2 = [[[MLCourse alloc] init] autorelease];
        course2.title = @"Effective Literacy";
        course2.color = [UIColor colorWithRed:63.0/255 green:117.0/255 blue:205.0/255 alpha:1.0];
        course2.unreadItems = 4;
        
        MLCourse *course3 = [[[MLCourse alloc] init] autorelease];
        course3.title = @"Theories-Meth";
        course3.color = [UIColor colorWithRed:42.0/255 green:203.0/255 blue:133.0/255 alpha:1.0];
        course3.unreadItems = 0;
        
        MLCourse *course4 = [[[MLCourse alloc] init] autorelease];
        course4.title = @"Greek Philosophy";
        course4.color = [UIColor colorWithRed:189.0/255 green:65.0/255 blue:200.0/255 alpha:1.0];
        course4.unreadItems = 6;
        
        self.courses = [NSArray arrayWithObjects:course1, course2, course3, course4, nil];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLMenuCourseCell *cell = [[MLMenuCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%i%i", indexPath.section, indexPath.row]];
    
    if (indexPath.section == 0) {
        cell.title = @"Activity Feed";
        return [cell autorelease];
    }
    
    MLCourse *course = [self.courses objectAtIndex:indexPath.row];
    
    cell.title = course.title;
    cell.color = course.color;
    cell.unreadItems = course.unreadItems;
    
    return [cell autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_CONTROLLER_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;
    return [[[MLMenuSectionHeaderView alloc] init] autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    return 50;
}

@end
