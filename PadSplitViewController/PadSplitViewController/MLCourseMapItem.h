//
//  MLCourseMapItem.h
//  BBLearn
//
//  Created by Sean Yu on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCourse.h"

#define FOLDER_PIC @"FolderIcon.png"
#define TASKS_PIC @"TasksIcon.png"
#define BLOG_PIC @"BlogJournalsIcon.png"
#define BLOG_ENTRIES_PIC @"BlogJournalsIcon.png"
#define JOURNAL_PIC @"BlogJournalsIcon.png"
#define JOURNAL_ENTRIES_PIC @"BlogJournalsIcon.png"
#define CALENDAR_PIC @"CalendarIcon.png"
#define ROSTER_PIC @"RosterIcon.png"
#define FORUMS_PIC @"MLForumsIcon.png"
#define THREADS_PIC @"MLForumThreadsIcon.png"
#define ANNOUNCEMENTS_PIC @"AnnouncementsIcon.png"
#define GRADES_PIC @"GradesIcon.png"
#define GROUP_PIC @"GroupsIcon.png"
#define CONTENT_PIC @"GenericContentIcon.png"
#define DEFAULT_PIC @"GenericContentIcon.png"
#define ASSESSMENTS_PIC @"MLAssessmentsIcon.png"

typedef enum {
	MLCourseMapItemTypeDefault = -1,
	MLCourseMapItemTypeTasks,
	MLCourseMapItemTypeBlogs,
	MLCourseMapItemTypeBlogEntries,
	MLCourseMapItemTypeJournals,
	MLCourseMapItemTypeJournalEntries,
	MLCourseMapItemTypeCalendar,
	MLCourseMapItemTypeRoster,
	MLCourseMapItemTypeForums,
	MLCourseMapItemTypeThreads,
	MLCourseMapItemTypeAnnouncements,
	MLCourseMapItemTypeGrades,
	MLCourseMapItemTypeGroups,
	MLCourseMapItemTypeGroup,
	MLCourseMapItemTypeContent,
    MLCourseMapItemTypeAssessment,
    MLCourseMapItemTypeAssessmentNonMobile
} MLCourseMapItemType;

@class TCDate;

@interface MLCourseMapItem : NSObject
{
	NSString *__weak item_id;
	NSString *name;
	NSString *link_target;
	NSString *link_type;
	
	NSURL *view_url;
	
//	TCDate *date_modified;
	
	BOOL is_folder;
	BOOL selected;
    BOOL assessment_is_mobile_friendly;
	
	NSMutableArray *children;
	
	MLCourseMapItem *__weak parent_item;
}

@property(nonatomic, strong) NSString *name, *linkTarget, *linkType;
@property(weak, nonatomic, readonly) NSString *itemID;
@property(nonatomic, strong) NSURL *viewURL;
//@property(nonatomic, retain) TCDate *dateModified;
@property(nonatomic, assign) BOOL isFolder, selected, assessmentIsMobileFriendly;
@property(nonatomic, readonly) MLCourseMapItemType itemType;
@property(nonatomic, strong) NSMutableArray *children;
@property(nonatomic, weak) MLCourseMapItem *parentItem;
@property (nonatomic, assign) int unreadItems;
@property (nonatomic, weak) MLCourse *parentCourse;

+ (MLCourseMapItemType)itemTypeForLinkType:(NSString *)theLinkType;
+(NSString *)iPhoneImageNameForCourseMapItem:(MLCourseMapItem *)item;
+ (NSString *)iPhoneImageNameForCourseMapItemType:(MLCourseMapItemType)itemType;
+ (NSString *)iPadImageNameForCourseMapItem:(MLCourseMapItem *)item;

- (id)initWithBBID:(NSString *)theBBID name:(NSString *)theName viewURL:(NSURL *)theViewURL linkType:(NSString *)theLinkType linkTarget:(NSString *)theLinkTarget isFolder:(BOOL)theIsFolder andDateModified:(TCDate *)theDate;
- (UIColor *)color;

@end
