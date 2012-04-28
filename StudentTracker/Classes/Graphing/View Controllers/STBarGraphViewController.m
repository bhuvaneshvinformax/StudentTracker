//
//  STBarGraphViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 25/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STBarGraphViewController.h"
#import "STGraphView.h"
#import "STBarGraphSubjectEnrollementDataSource.h"

@interface STBarGraphViewController ()

@property (nonatomic, retain) STBarGraphSubjectEnrollementDataSource *barGraphDataSource;

@end

@implementation STBarGraphViewController

@synthesize delegate;
@synthesize managedObjectContext;
@synthesize graph;
@synthesize barGraphDataSource;

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Enrolment by subject"];
    [self setView:[[[STGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
    
    [self setBarGraphDataSource:[[[STBarGraphSubjectEnrollementDataSource alloc] initWithManagedObjectContext:[self managedObjectContext]] autorelease]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STGraphView *graphView = (STGraphView *)[self view];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    CPTBarPlot *subjectBarPlot = [[CPTBarPlot alloc] initWithFrame:[graph bounds]];
    [subjectBarPlot setIdentifier:@"subjectEnrollement"];
    [subjectBarPlot setDelegate:self];
    [subjectBarPlot setDataSource:[self barGraphDataSource]];
    
    [[self graph] addPlot:subjectBarPlot];
    
    CPTXYPlotSpace *studentPlotSpace = (CPTXYPlotSpace *)[graph defaultPlotSpace];
    [studentPlotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt([[self barGraphDataSource] getTotalSubjects] + 1)]];
    [studentPlotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt([[self barGraphDataSource] getMaxEnrolled] + 1)]];
    
    [[graph plotAreaFrame] setPaddingLeft:40.0f];
    [[graph plotAreaFrame] setPaddingTop:10.0f];
    [[graph plotAreaFrame] setPaddingBottom:120.0f];
    [[graph plotAreaFrame] setPaddingRight:0.0f];
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
    
    NSArray *subjectsArray = [[self barGraphDataSource] getSubjectTitlesAsArray];
    
    [xAxis setAxisLabels:[NSSet setWithArray:subjectsArray]];
    
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

- (void)dealloc
{
    [managedObjectContext release];
    [graph release];
    [barGraphDataSource release];
    
    [super dealloc];
}

@end
