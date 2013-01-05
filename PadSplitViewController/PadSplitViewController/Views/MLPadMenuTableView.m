//
//  MLPadMenuTableView.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuTableView.h"

@interface MLPadMenuTableView ()

- (void)configureSelf;

@end

@implementation MLPadMenuTableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureSelf];
    }
    return self;
}

- (void)configureSelf
{
    self.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1.0];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
