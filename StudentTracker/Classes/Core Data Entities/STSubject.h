//
//  STSubject.h
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STSubject : NSManagedObject

@property (nonatomic, retain) NSNumber * subjectID;
@property (nonatomic, retain) NSString * subjectName;

@end
