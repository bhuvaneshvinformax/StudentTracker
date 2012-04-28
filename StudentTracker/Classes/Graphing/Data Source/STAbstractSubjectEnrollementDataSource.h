//
//  STAbstractSubjectEnrollementDataSource.h
//  StudentTracker
//
//  Created by Aron Bury on 28/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@interface STAbstractSubjectEnrollementDataSource : NSObject <CPTPlotDataSource, CPTPieChartDataSource>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (float)getTotalSubjects;
- (float)getMaxEnrolled;
- (NSArray *)getSubjectTitlesAsArray;

@end
