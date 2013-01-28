//
//  MLPadMenuCourseViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/8/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuCourseViewController.h"
#import "MLMenuCourseCell.h"
#import "MLCourse.h"
#import "MLPadMenuCourseMapItemViewController.h"
#import "MLCourseMapItem.h"
#import "MLMenuPinView.h"

@interface MLPadMenuCourseViewController () {
    MLMenuPinView *_pinView;
}

- (void)configurePinView;

@end

@implementation MLPadMenuCourseViewController

@synthesize courses = _courses;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = @"Menu";
        [self configurePinView];
    }
    return self;
}


#pragma mark - Configuration

- (void)configurePinView
{
    _pinView = [[MLMenuPinView alloc] init];
    _pinView.frame = CGRectZero;
    [self.view addSubview:_pinView];
}

#pragma mark - TableView DataSource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLMenuCourseCell *cell = [[MLMenuCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%i%i", indexPath.section, indexPath.row]];
    
    if (indexPath.section == 0) {
        cell.title = @"Activity Feed";
//        cell.unreadItems = 1;
        return cell;
    }
    
    MLCourse *course = [self.courses objectAtIndex:indexPath.row];
    
    cell.title = course.title;
    cell.color = course.color;
    cell.unreadItems = course.unreadItems;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.menuNavigationController popToViewController:self animated:NO];
    
    MLCourse *course = [self.courses objectAtIndex:indexPath.row];

    MLPadMenuCourseMapItemViewController *controller = [[MLPadMenuCourseMapItemViewController alloc] initWithNibName:nil bundle:nil];
    
    MLCourseMapItem *week3 = [[MLCourseMapItem alloc] initWithBBID:nil name:@"Week 3" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil];
    MLCourseMapItem *announcements = [[MLCourseMapItem alloc] initWithBBID:nil name:@"Announcements" viewURL:nil linkType:@"announcements" linkTarget:nil isFolder:NO andDateModified:nil];
    MLCourseMapItem *blogs = [[MLCourseMapItem alloc] initWithBBID:nil name:@"Blogs" viewURL:nil linkType:@"blogs" linkTarget:nil isFolder:NO andDateModified:nil];
    MLCourseMapItem *liveText = [[MLCourseMapItem alloc] initWithBBID:nil name:@"LiveText" viewURL:nil linkType:@"CONTENT" linkTarget:nil isFolder:NO andDateModified:nil];
    MLCourseMapItem *week1 = [[MLCourseMapItem alloc] initWithBBID:nil name:@"Week 1" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil];
    MLCourseMapItem *tools = [[MLCourseMapItem alloc] initWithBBID:nil name:@"Tools" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil];
    MLCourseMapItem *week4 = [[MLCourseMapItem alloc] initWithBBID:nil name:@"Week 4" viewURL:nil linkType:@"" linkTarget:nil isFolder:YES andDateModified:nil];
    
    week3.unreadItems = 2;
    announcements.unreadItems = 1;
    blogs.unreadItems = 3;
    week1.unreadItems = 2;
    
    controller.courseMap = [NSArray arrayWithObjects:blogs, liveText, week1, tools, week4, nil];
    controller.favorites = [NSArray arrayWithObjects:week3, announcements, nil];
    controller.course = course;
    controller.title = course.title;
    
    [self performSelector:@selector(pushController:) withObject:controller afterDelay:0.10];
}

#pragma mark - Frame Defines

- (CGRect)navigationBarFrame {
    return CGRectMake(0,
                      CGRectGetMaxY(_pinView.frame),
                      self.view.bounds.size.width,
                      [self navigationBarHeight]);
}

@end
