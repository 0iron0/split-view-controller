//
//  MLCourse.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLCourse : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) int unreadItems;
@property (nonatomic, strong) NSArray *courseMap;

@end
