//
//  MLPadMenuContentItemViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/8/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuViewController.h"
#import "MLCourse.h"

@interface MLPadMenuCourseMapItemViewController : MLPadMenuViewController

@property (nonatomic, strong) NSArray *courseMap;
@property (nonatomic, strong) NSArray *favorites;
@property (nonatomic, strong) MLCourse *course;

@end
