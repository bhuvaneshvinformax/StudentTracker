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
@synthesize managedObjectContext;

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Enrolement over Time"];
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
    
    CPTXYPlotSpace *studentPlotSpace = (CPTXYPlotSpace *)[graph defaultPlotSpace];
    [studentPlotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(6)]];
    [studentPlotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(10)]];    
    
    
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CPTScatterPlotDataSource Methods
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 7;
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSUInteger x = index;
    NSUInteger y = 0;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dayEnrolled == %d", index];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    y = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    
    
    switch (fieldEnum) 
    {
        case CPTScatterPlotFieldX:
            NSLog(@"x value for %d is %d", index, x);
            return [NSNumber numberWithInt:x];
            break;
        case CPTScatterPlotFieldY:
            NSLog(@"y value for %d is %d", index, y);            
            return [NSNumber numberWithInt:y];
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)dealloc
{
    [graph release];
    [managedObjectContext release];
    
    [super dealloc];
}

@end
