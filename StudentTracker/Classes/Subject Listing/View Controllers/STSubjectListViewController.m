//
//  STSubjectListViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STSubjectListViewController.h"
#import "STSubjectListView.h"
#import "STSubject.h"

@interface STSubjectListViewController ()
@property (nonatomic, strong) NSArray *subjectArray;

- (void)addSubject:(id)sender;
@end

@implementation STSubjectListViewController

@synthesize managedObjectContext;
@synthesize subjectArray;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Subjects";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[[STSubjectListView alloc] initWithFrame:self.view.frame] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STSubjectListView *subjectView = (STSubjectListView *)self.view;
    
    subjectView.subjectTableView.delegate = self;
    subjectView.subjectTableView.dataSource = self;
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                                target:self 
                                                                                                action:@selector(addSubject:)] autorelease] animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STSubject"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    self.subjectArray = [context executeFetchRequest:fetchRequest error:&error];
    
    STSubjectListView *subjectView = (STSubjectListView *)self.view;
    [[subjectView subjectTableView] reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [subjectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    STSubject *subject = [subjectArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:subject.subjectName];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", subject.subjectID.intValue]];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AddSubjectViewController Delegate Methods
- (void)modalViewControllerShouldClose
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Private method
- (void)addSubject:(id)sender
{
    STAddSubjectViewController *addSubjectVC = [[STAddSubjectViewController alloc] initWithContext:managedObjectContext];
    [addSubjectVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [addSubjectVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [addSubjectVC setDelegate:self];
    
    [self presentModalViewController:addSubjectVC animated:YES];
    
    [addSubjectVC release];
}

- (void)dealloc
{
    [subjectArray release];
    [managedObjectContext release];
    [super dealloc];
}

@end
