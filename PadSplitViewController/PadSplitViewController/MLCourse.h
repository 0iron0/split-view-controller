//
//  MLCourse.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLCourse : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) int unreadItems;
@property (nonatomic, retain) NSArray *courseMap;

@end
