//
//  STAbstractSubjectEnrollementDataSource.h
//  StudentTracker
//
//  Created by Aron Bury on 28/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@interface STAbstractSubjectEnrollementDataSource : NSObject <CPTPlotDataSource>

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (float)getTotalSubjects;
+ (float)getMaxEnrolled;
+ (NSArray *)getSubjectTitlesAsArray;

@end
