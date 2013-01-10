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
    if (section == 0 && [self.favorites count] > 0)
        return [self.favorites count];
    return [self.courseMap count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLMenuCourseMapItemCell *cell = [[MLMenuCourseMapItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%i%i", indexPath.section, indexPath.row]];
    
    MLCourseMapItem *courseMapItem = (indexPath.section == 0) ? [self.favorites objectAtIndex:indexPath.row] : [self.courseMap objectAtIndex:indexPath.row];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.menuNavigationController popToViewController:self animated:NO];
        
    MLCourseMapItem *courseMapItem = (indexPath.section == 0) ? [self.favorites objectAtIndex:indexPath.row] : [self.courseMap objectAtIndex:indexPath.row];
    
    MLPadMenuCourseMapItemViewController *controller = [[[MLPadMenuCourseMapItemViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    
    MLCourseMapItem *week3 = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Week 3" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil] autorelease];
    MLCourseMapItem *announcements = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Announcements" viewURL:nil linkType:@"announcements" linkTarget:nil isFolder:NO andDateModified:nil] autorelease];
    MLCourseMapItem *blogs = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Blogs" viewURL:nil linkType:@"blogs" linkTarget:nil isFolder:NO andDateModified:nil] autorelease];
    MLCourseMapItem *liveText = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"LiveText" viewURL:nil linkType:@"CONTENT" linkTarget:nil isFolder:NO andDateModified:nil] autorelease];
    MLCourseMapItem *week1 = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Week 1" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil] autorelease];
    MLCourseMapItem *tools = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Tools" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil] autorelease];
    MLCourseMapItem *week4 = [[[MLCourseMapItem alloc] initWithBBID:nil name:@"Week 4" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil] autorelease];
    
    week3.unreadItems = 2;
    announcements.unreadItems = 1;
    blogs.unreadItems = 3;
    week1.unreadItems = 2;
    
    controller.courseMap = [NSArray arrayWithObjects:blogs, liveText, week1, tools, week4, nil];
    controller.favorites = [NSArray arrayWithObjects:week3, announcements, nil];
    controller.course = self.course;
    controller.title = courseMapItem.name;
    
    [self.menuNavigationController pushViewController:controller animated:YES];
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

@end
