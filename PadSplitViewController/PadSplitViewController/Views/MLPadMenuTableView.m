//
//  MLPadMenuTableView.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuTableView.h"

#define MENU_TABLE_VIEW_BACKGROUND_COLOR [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0]

@interface MLPadMenuTableView ()

- (void)configureSelf;
- (void)configureHeaderView;

@end

@implementation MLPadMenuTableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureSelf];
        [self configureHeaderView];
    }
    return self;
}

- (void)configureSelf
{
    self.backgroundColor = MENU_TABLE_VIEW_BACKGROUND_COLOR;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configureHeaderView
{
    UIView *blankHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    blankHeaderView.backgroundColor = [UIColor clearColor];
    self.tableHeaderView = blankHeaderView;
    self.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    //NOTE: This is stupid, but it prevents the section headers from floating, which you can't turn off in a Plain TableView
}

@end
