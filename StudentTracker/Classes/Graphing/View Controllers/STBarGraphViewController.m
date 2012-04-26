//
//  STBarGraphViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 25/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STBarGraphViewController.h"
#import "STGraphView.h"

@interface STBarGraphViewController ()
- (float)getTotalSubjects;
- (float)getMaxEnrolled;
- (NSArray *)getSubjectTitlesAsArray;
@end

@implementation STBarGraphViewController

@synthesize delegate;
@synthesize managedObjectContext;
@synthesize graph;

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Enrolment by subject"];
    [self setView:[[[STGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STGraphView *graphView = (STGraphView *)[self view];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    CPTBarPlot *subjectBarPlot = [[CPTBarPlot alloc] initWithFrame:[graph bounds]];
    [subjectBarPlot setIdentifier:@"subjectEnrollement"];
    [subjectBarPlot setDelegate:self];
    [subjectBarPlot setDataSource:self];   
    
    [[self graph] addPlot:subjectBarPlot];
    
    CPTXYPlotSpace *studentPlotSpace = (CPTXYPlotSpace *)[graph defaultPlotSpace];
    [studentPlotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt([self getTotalSubjects] + 1)]];
    [studentPlotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt([self getMaxEnrolled] + 1)]];
    
    [[graph plotAreaFrame] setPaddingLeft:30.0f];
    [[graph plotAreaFrame] setPaddingTop:10.0f];
    [[graph plotAreaFrame] setPaddingBottom:20.0f];
    [[graph plotAreaFrame] setPaddingRight:10.0f];
    [[graph plotAreaFrame] setBorderLineStyle:nil];
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:12.0f];
    [textStyle setColor:[CPTColor colorWithCGColor:[[UIColor grayColor] CGColor]]];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)[graph axisSet];
    
    CPTXYAxis *xAxis = [axisSet xAxis];
    [xAxis setMajorIntervalLength:CPTDecimalFromInt(1)];
    [xAxis setMinorTickLineStyle:nil];
    [xAxis setLabelingPolicy:CPTAxisLabelingPolicyNone];
    [xAxis setLabelTextStyle:textStyle];
    [xAxis setLabelRotation:M_PI/4];
    [xAxis setAxisLabels:[NSSet setWithArray:[self getSubjectTitlesAsArray]]];
    
    CPTXYAxis *yAxis = [axisSet yAxis];
    [yAxis setMajorIntervalLength:CPTDecimalFromInt(1)];
    [yAxis setMinorTickLineStyle:nil];
    [yAxis setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
    [yAxis setLabelTextStyle:textStyle];
    
    //Allow user to go back
    UINavigationItem *navigationItem = [[[UINavigationItem alloc] initWithTitle:self.title] autorelease];
    [navigationItem setHidesBackButton:YES];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                            style:UIBarButtonItemStyleDone 
                                                                           target:[self delegate] 
                                                                           action:@selector(doneButtonWasTapped:)] autorelease] animated:NO];
    
    
}

#pragma mark - Private Methods
- (float)getTotalSubjects
{
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STSubject" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    return [managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

- (float)getMaxEnrolled
{
    float maxEnrolled = 0;
    
    NSError *error = nil;
    
    for (int i = 0; i < [self getTotalSubjects]; i++) 
    {   
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent" inManagedObjectContext:managedObjectContext];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subjectID == %d", i];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        
        float subjectMax = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
        [fetchRequest release];
        
        if (subjectMax > maxEnrolled) 
        {
            maxEnrolled = subjectMax;
        }
    }
    
    return maxEnrolled;
}

-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
 	CPTColor *areaColor = nil;
    
    switch (index) 
    {
        case 0:
            areaColor = [CPTColor redColor];
            break;
            
        case 1:
            areaColor = [CPTColor blueColor];
            break;
        
        case 2:
            areaColor = [CPTColor orangeColor];
            break;
            
        case 3:
            areaColor = [CPTColor greenColor];
            break;
            
        default:
            areaColor = [CPTColor purpleColor];
            break;
    }
    
    
	CPTFill *barFill = [CPTFill fillWithColor:areaColor];
    
    return barFill;

}

- (NSArray *)getSubjectTitlesAsArray
{
    NSError *error = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"subjectID" ascending:YES];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STSubject" inManagedObjectContext:managedObjectContext];    
    [request setEntity:entity];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:NO];
    [request setPropertiesToFetch :[NSArray arrayWithObject:@"subjectName"]];
    
    return [managedObjectContext executeFetchRequest:request error:&error];
}

#pragma mark - CPTBarPlotDataSourceMethods
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self getTotalSubjects];
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    int x = index + 1;
    int y = 0;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent" inManagedObjectContext:managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subjectID == %d", index];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    y = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    
    switch (fieldEnum) 
    {
        case CPTScatterPlotFieldX:
            return [NSNumber numberWithInt:x];
            break;
        case CPTScatterPlotFieldY:
            return [NSNumber numberWithInt:y];
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)dealloc
{
    [managedObjectContext release];
    [graph release];
    
    [super dealloc];
}

@end
