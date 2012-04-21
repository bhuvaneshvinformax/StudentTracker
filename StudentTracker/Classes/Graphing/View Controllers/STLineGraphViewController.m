//
//  STLineGraphViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 18/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STLineGraphViewController.h"
#import "STLineGraphView.h"

@interface STLineGraphViewController ()

@end

@implementation STLineGraphViewController

@synthesize graph;
@synthesize delegate;

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Enrollement over Time"];
    [self setView:[[[STLineGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    STLineGraphView *graphView = (STLineGraphView *)[self view];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    CPTScatterPlot *studentScatterPlot = [[CPTScatterPlot alloc] initWithFrame:[graph bounds]];
    [studentScatterPlot setTitle:@"studentEnrollment"];
    [studentScatterPlot setDelegate:self];
    [studentScatterPlot setDataSource:self];
    
    [[self graph] addPlot:studentScatterPlot];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navigationItem setHidesBackButton:YES];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone 
                                                                    target:[self delegate] 
                                                                           action:@selector(doneButtonWasTapped:)] autorelease] animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CPTScatterPlotDataSource Methods
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 0;
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    return nil;
}

- (void)dealloc
{
    
    [graph release];
    
    [super dealloc];
}

@end
