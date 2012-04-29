//
//  STPieGraphViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 28/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STPieGraphViewController.h"
#import "STGraphView.h"
#import "STPieGraphSubjectEnrollementDataSource.h"

@interface STPieGraphViewController ()

@property (nonatomic, strong) STPieGraphSubjectEnrollementDataSource *pieChartDataSource;

@end

@implementation STPieGraphViewController

@synthesize managedObjectContext;
@synthesize delegate;
@synthesize graph;
@synthesize pieChartDataSource;

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Enrolment by subject"];
    [self setView:[[[STGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
    [graph setFrame:self.view.bounds];
    
    [self setPieChartDataSource:[[[STPieGraphSubjectEnrollementDataSource alloc] initWithManagedObjectContext:[self managedObjectContext]] autorelease]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STGraphView *graphView = (STGraphView *)[self view];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    CPTPieChart *pieChart = [[CPTPieChart alloc] initWithFrame:[graph bounds]];
    [pieChart setPieRadius:100.00];
    [pieChart setIdentifier:@"Subject"];
    [pieChart setStartAngle:M_PI_4];
    [pieChart setSliceDirection:CPTPieDirectionCounterClockwise];
    [pieChart setDataSource:pieChartDataSource];
    [pieChart setDelegate:self];
    [graph addPlot:pieChart];
    
    [graph setAxisSet:nil];
    [[graph plotAreaFrame] setBorderLineStyle:nil];
    
    CPTLegend *theLegend = [CPTLegend legendWithGraph:[self graph]];
    [theLegend setNumberOfColumns:2];
    [[self graph] setLegend:theLegend];
    [[self graph] setLegendAnchor:CPTRectAnchorBottom];
    [[self graph] setLegendDisplacement:CGPointMake(0.0, 30.0)];
    
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
    [graph release];
    [managedObjectContext release];
    [pieChartDataSource release];
    
    [super dealloc];
}

@end
