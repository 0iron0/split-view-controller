//
//  MLMenuCell.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MLMenuCell : UITableViewCell

@property (nonatomic, assign) NSString *title;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) int unreadItems;

- (CGRect)textLabelFrame;
- (float)textLeftBuffer;
- (UIColor *)textLabelColor;

@end
