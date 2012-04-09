//
//  STStudent.h
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STStudent : NSManagedObject

@property (nonatomic, retain) NSString * studentID;
@property (nonatomic, retain) NSString * studentName;
@property (nonatomic, retain) NSNumber * subjectID;
@property (nonatomic, retain) NSNumber * dayEnrolled;

@end
