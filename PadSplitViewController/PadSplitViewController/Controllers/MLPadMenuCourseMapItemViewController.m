//
//  MLPadMenuContentItemViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/8/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuCourseMapItemViewController.h"
#import "MLMenuCourseMapItemCell.h"
#import "MLCourseMapItem.h"

#define COURSE_MAP_ITEM_CELL_HEIGHT 58

@interface MLPadMenuCourseMapItemViewController ()

- (BOOL)sectionIsFavorites:(int)section;

@end

@implementation MLPadMenuCourseMapItemViewController

@synthesize courseMap = _courseMap;
@synthesize favorites = _favorites;
@synthesize course = _course;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        // Custom initialization
    }
    return self;
}

#pragma mark - TableView DataSource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self sectionIsFavorites:section])
        return [self.favorites count];
    return [self.courseMap count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.favorites count] > 0)
        return 2;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLMenuCourseMapItemCell *cell = [[MLMenuCourseMapItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%i%i", indexPath.section, indexPath.row]];
    
    MLCourseMapItem *courseMapItem = ([self sectionIsFavorites:indexPath.section]) ? [self.favorites objectAtIndex:indexPath.row] : [self.courseMap objectAtIndex:indexPath.row];
    
    cell.title = courseMapItem.name;
    cell.color = _course.color;
    cell.unreadItems = courseMapItem.unreadItems;
    cell.image = [UIImage imageNamed:[MLCourseMapItem iPhoneImageNameForCourseMapItem:courseMapItem]];
    
    return [cell autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.menuNavigationController popToViewController:self animated:NO];
    
    MLCourseMapItem *courseMapItem = ([self sectionIsFavorites:indexPath.section]) ? [self.favorites objectAtIndex:indexPath.row] : [self.courseMap objectAtIndex:indexPath.row];
    
    if (courseMapItem.isFolder)
    {
        MLPadMenuCourseMapItemViewController *controller = [[[MLPadMenuCourseMapItemViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        
        MLCourseMapItem *announcements = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Announcements" viewURL:nil linkType:@"announcements" linkTarget:nil isFolder:NO andDateModified:nil] autorelease];
        MLCourseMapItem *blogs = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Blogs" viewURL:nil linkType:@"blogs" linkTarget:nil isFolder:NO andDateModified:nil] autorelease];
        MLCourseMapItem *liveText = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"LiveText" viewURL:nil linkType:@"CONTENT" linkTarget:nil isFolder:NO andDateModified:nil] autorelease];
        
        announcements.unreadItems = 1;
        blogs.unreadItems = 3;
        
        controller.courseMap = [NSArray arrayWithObjects:announcements, blogs, liveText, nil];
        controller.course = self.course;
        controller.title = courseMapItem.name;
        
        [self performSelector:@selector(pushController:) withObject:controller afterDelay:0.1];
    }
    else
    {
        [self.menuNavigationController presentContentControllerForItem:courseMapItem animated:YES];
    }
}

#pragma mark - Frame Defines

- (CGRect)navigationBarFrame {
    return CGRectMake(0,
                      0,
                      self.view.bounds.size.width,
                      [self navigationBarHeight]);
}

#pragma mark - View Overrides

- (float)cellHeight {
    return COURSE_MAP_ITEM_CELL_HEIGHT;
}

#pragma mark - Utility

- (BOOL)sectionIsFavorites:(int)section {
    return (section == 0 && [self.favorites count] > 0);
}

@end
