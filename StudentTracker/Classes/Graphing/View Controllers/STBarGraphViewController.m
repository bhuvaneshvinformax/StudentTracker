//
//  STBarGraphViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 25/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STBarGraphViewController.h"
#import "STBarGraphView.h"

@interface STBarGraphViewController ()

@end

@implementation STBarGraphViewController

@synthesize delegate;
@synthesize managedObjectContext;
@synthesize graph;

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Enrolment by subject"];
    [self setView:[[[STBarGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    [managedObjectContext release];
    [graph release];
    
    [super dealloc];
}

@end
