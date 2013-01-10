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

@property (nonatomic, retain) NSArray *courseMap;
@property (nonatomic, retain) NSArray *favorites;
@property (nonatomic, retain) MLCourse *course;

@end
