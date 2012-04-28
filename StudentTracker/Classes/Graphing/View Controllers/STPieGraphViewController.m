//
//  STPieGraphViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 28/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STPieGraphViewController.h"
#import "STGraphView.h"
#import "STAbstractSubjectEnrollementDataSource.h"

@interface STPieGraphViewController ()

@end

@implementation STPieGraphViewController

@synthesize managedObjectContext;
@synthesize delegate;
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
    
    CPTPieChart *pieChart = [[CPTPieChart alloc] initWithFrame:[graph bounds]];
    [pieChart setDataSource:[[STAbstractSubjectEnrollementDataSource alloc] initWithManagedObjectContext:[self managedObjectContext]]];
    [graph addPlot:pieChart];
    
    
    
    
    
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [graph release];
    [managedObjectContext release];
    
    [super dealloc];
}

@end
