//
//  MLCourseMapItem.m
//  BBLearn
//
//  Created by Sean Yu on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MLCourseMapItem.h"
#import "MLCourse.h"

@interface MLCourseMapItem (PRIVATE)
+ (NSString *)iPhoneImageNameForCourseMapItemType:(MLCourseMapItemType)itemType;
+ (BOOL)needsFolderForItem:(MLCourseMapItem *)item;
@end

@implementation MLCourseMapItem

@synthesize name, itemID = item_id, linkTarget = link_target, linkType = link_type;
@synthesize viewURL = view_url;
@synthesize dateModified = date_modified;
@synthesize isFolder = is_folder, selected;
@synthesize itemType;
@synthesize children;
@synthesize parentItem = parent_item;
@synthesize assessmentIsMobileFriendly = assessment_is_mobile_friendly;
@synthesize unreadItems;
@synthesize parentCourse;

- (void)dealloc
{
	[name release];
	[item_id release];
	[link_target release];
	[link_type release];
	[view_url release];
	[date_modified release];
	[children release];
	
	[super dealloc];
}

#define IFEL(a) if([theLinkType isEqualToString:a])
#define EIFEL(a) else if([theLinkType isEqualToString:a])
+ (MLCourseMapItemType)itemTypeForLinkType:(NSString *)theLinkType
{
	MLCourseMapItemType type = MLCourseMapItemTypeDefault;
	
	IFEL(@"tasks")
		type = MLCourseMapItemTypeTasks;
	EIFEL(@"blogs")
		type = MLCourseMapItemTypeBlogs;
	EIFEL(@"BBM_BLOG")
		type = MLCourseMapItemTypeBlogEntries;
	EIFEL(@"journal")
		type = MLCourseMapItemTypeJournals;
	EIFEL(@"BBM_JOURNAL")
		type = MLCourseMapItemTypeJournalEntries;
	EIFEL(@"calendar")
		type = MLCourseMapItemTypeCalendar;
	EIFEL(@"course_roster")
		type = MLCourseMapItemTypeRoster;
	EIFEL(@"discussion_board")
		type = MLCourseMapItemTypeForums;
	EIFEL(@"FORUM")
		type = MLCourseMapItemTypeThreads;
	EIFEL(@"announcements")
		type = MLCourseMapItemTypeAnnouncements;	
	EIFEL(@"student_gradebook")
		type = MLCourseMapItemTypeGrades;
	EIFEL(@"groups")
		type = MLCourseMapItemTypeGroups;
	EIFEL(@"GROUP")
		type = MLCourseMapItemTypeGroup;
	EIFEL(@"CONTENT")
		type = MLCourseMapItemTypeContent;
	EIFEL(@"BBM_BLOG")
		type = MLCourseMapItemTypeBlogEntries;
    EIFEL(@"COURSE_ASSESSMENT")
        type = MLCourseMapItemTypeAssessment;
	
	return type;
}

+ (BOOL)needsFolderForItem:(MLCourseMapItem *)item
{
	if ( item.itemType != MLCourseMapItemTypeForums && item.itemType != MLCourseMapItemTypeGroups )
    {
        if ( [item.children count] > 0 || item.isFolder )
        {
            return YES;
        }
    }
    
    return NO;
}


+(NSString *)iPhoneImageNameForCourseMapItem:(MLCourseMapItem *)item
{
    if ( [MLCourseMapItem needsFolderForItem:item] ) { return FOLDER_PIC; }
    
    return [MLCourseMapItem iPhoneImageNameForCourseMapItemType:item.itemType];
}

+ (NSString *)iPhoneImageNameForCourseMapItemType:(MLCourseMapItemType)itemType
{
	switch (itemType) {
		case MLCourseMapItemTypeTasks:
			return TASKS_PIC;
			break;
		case MLCourseMapItemTypeBlogs:
			return BLOG_PIC;
			break;
		case MLCourseMapItemTypeBlogEntries:
			return BLOG_ENTRIES_PIC;
			break;
		case MLCourseMapItemTypeJournals:
			return JOURNAL_PIC;
			break;
		case MLCourseMapItemTypeJournalEntries:
			return JOURNAL_ENTRIES_PIC;
			break;
		case MLCourseMapItemTypeCalendar:
			return CALENDAR_PIC;
			break;
		case MLCourseMapItemTypeRoster:
			return ROSTER_PIC;
			break;
		case MLCourseMapItemTypeForums:
			return FORUMS_PIC;
			break;
		case MLCourseMapItemTypeThreads:
			return THREADS_PIC;
			break;
		case MLCourseMapItemTypeAnnouncements:
			return ANNOUNCEMENTS_PIC;
			break;
		case MLCourseMapItemTypeGrades:
			return GRADES_PIC;
			break;
		case MLCourseMapItemTypeGroups:
			return GROUP_PIC;
			break;
		case MLCourseMapItemTypeGroup:
			return GROUP_PIC;
			break;
		case MLCourseMapItemTypeContent:
			return CONTENT_PIC;
			break;
        case MLCourseMapItemTypeAssessment:
            return ASSESSMENTS_PIC;
            break;
		default:
			return DEFAULT_PIC;
			break;
	}
}

+(NSString *)iPadImageNameForCourseMapItem:(MLCourseMapItem *)item
{
    if ( [MLCourseMapItem needsFolderForItem:item] ) { return @"MLCourseMapIconFolder.png"; }
    
	switch (item.itemType) {
		case MLCourseMapItemTypeTasks:
			return  @"MLCourseMapIconTasks.png";
			break;
		case MLCourseMapItemTypeBlogs:
			return  @"MLCourseMapIconBlogEntries.png";
			break;
		case MLCourseMapItemTypeBlogEntries:
			return  @"MLCourseMapIconStudentBlogs.png";
			break;
		case MLCourseMapItemTypeJournals:
			return  @"MLCourseMapIconJournals.png";
			break;
		case MLCourseMapItemTypeJournalEntries:
			return @"MLCourseMapIconJournals.png";
			break;
		case MLCourseMapItemTypeCalendar:
			return @"MLCourseMapIconCalendar.png";
			break;
		case MLCourseMapItemTypeRoster:
			return @"MLCourseMapIconRoster.png";
			break;
		case MLCourseMapItemTypeForums:
			return @"MLCourseMapIconForum.png";
			break;
		case MLCourseMapItemTypeThreads:
			return  @"MLCourseMapIconThreads.png";
			break;
		case MLCourseMapItemTypeAnnouncements:
			return @"MLPadCourseMapIconAnnouncement.png";
			break;
		case MLCourseMapItemTypeGrades:
			return  @"MLCourseMapIconGrades.png";
			break;
		case MLCourseMapItemTypeGroups:
			return  @"MLCourseMapIconWorkingGroup.png";
			break;
		case MLCourseMapItemTypeGroup:
			return  @"MLCourseMapIconWorkingGroup.png";
			break;
		case MLCourseMapItemTypeContent:
			return @"MLCourseMapIconContent.png";
			break;
        case MLCourseMapItemTypeAssessment:
            return @"MLPadCourseMapIconAssessment.png";
            break;
		default:
			return @"MLCourseMapIconLinks.png";
			break;
	}
}

-(id)init
{
	if(self = [super init])
	{
		children = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (id)initWithBBID:(NSString *)theBBID name:(NSString *)theName viewURL:(NSURL *)theViewURL linkType:(NSString *)theLinkType linkTarget:(NSString *)theLinkTarget isFolder:(BOOL)theIsFolder andDateModified:(TCDate *)theDate
{
	if (self = [self init])
	{
		self.name = theName;
		self.viewURL = theViewURL;
		self.linkType = theLinkType;
		self.linkTarget = theLinkTarget;
		self.isFolder = theIsFolder;
		self.dateModified = theDate;
	}
	return self;
}

#pragma mark Property Overrides

- (NSString *)name
{
	if (name == nil)
		return @" ";
	else 
		return name;
}

- (NSString *)itemID
{
	NSString *theID =  [NSString stringWithFormat:@"%@-%@-%@", self.name, self.linkTarget, self.linkType];
	return theID;
}

- (MLCourseMapItemType)itemType
{
	MLCourseMapItemType type = [MLCourseMapItem itemTypeForLinkType:self.linkType];
    if (type == MLCourseMapItemTypeAssessment && !self.assessmentIsMobileFriendly)
        return MLCourseMapItemTypeAssessmentNonMobile;
    else
        return type;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@", name];
}

- (UIColor *)color {
    return parentCourse.color;
}

@end
