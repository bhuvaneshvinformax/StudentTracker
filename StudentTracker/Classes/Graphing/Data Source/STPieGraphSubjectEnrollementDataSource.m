//
//  STPieGraphSubjectEnrollementDataSource.m
//  StudentTracker
//
//  Created by Aron Bury on 29/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STPieGraphSubjectEnrollementDataSource.h"

@implementation STPieGraphSubjectEnrollementDataSource

#pragma mark - CPTPieChartDataSource
-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index
{
    NSError *error = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STSubject" inManagedObjectContext:[self managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subjectID == %d", index];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setPredicate:predicate];
    [request setReturnsDistinctResults:NO];
    [request setPropertiesToFetch:[NSArray arrayWithObject:@"subjectName"]];
    
    NSArray *titleStrings = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    NSDictionary *fetchedSubject = [titleStrings objectAtIndex:0];
    
    return [fetchedSubject objectForKey:@"subjectName"];
}

@end
