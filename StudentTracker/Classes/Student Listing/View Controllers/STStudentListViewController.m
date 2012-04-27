//
//  STStudentListViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STStudentListViewController.h"

#import "STStudentListView.h"
#import "STStudent.h"

@interface STStudentListViewController ()
@property (nonatomic, strong) NSArray *studentArray;

- (void)addStudent:(id)sender;
- (void)graphButtonWasSelected:(id)sender;
@end

@implementation STStudentListViewController

@synthesize managedObjectContext;
@synthesize studentArray;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Students";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[[STStudentListView alloc] initWithFrame:self.view.frame] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STStudentListView *studentView = (STStudentListView *)self.view;
    
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStudent:)] autorelease] animated:NO];
    
    [[self navigationItem] setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Graphs" style:UIBarButtonItemStylePlain target:self action:@selector(graphButtonWasSelected:)] autorelease] animated:NO];
    
    studentView.studentListTableView.delegate = self;
    studentView.studentListTableView.dataSource = self;
    
    NSError *error;
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"studentID" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sorter, nil];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    self.studentArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    [sorter release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"studentID" ascending:YES];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sorter]];
    
    self.studentArray = [context executeFetchRequest:fetchRequest error:&error];
    
    STStudentListView *studentView = (STStudentListView *)self.view;
    
    [[studentView studentListTableView] reloadData];
    [fetchRequest release];
    [sorter release];
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
    return [studentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    STStudent *student = [studentArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:student.studentName];
    [[cell detailTextLabel] setText:student.studentID];
    
    return cell;
}

#pragma mark - UIActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) 
    {
        STLineGraphViewController *graphVC = [[STLineGraphViewController alloc] init];
        [graphVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [graphVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [graphVC setDelegate:self];
        [graphVC setManagedObjectContext:[self managedObjectContext]];
        
        [self presentModalViewController:graphVC animated:YES];
        
        [graphVC release];

    }
    else if (buttonIndex == 1)
    {
        STBarGraphViewController *graphVC = [[STBarGraphViewController alloc] init];
        [graphVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [graphVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [graphVC setDelegate:self];
        [graphVC setManagedObjectContext:[self managedObjectContext]];
        
        [self presentModalViewController:graphVC animated:YES];
        
        [graphVC release];
    }
    else if (buttonIndex == 2) 
    {
        STPieGraphViewController *graphVC = [[STPieGraphViewController alloc] init];
        [graphVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [graphVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [graphVC setDelegate:self];
        [graphVC setManagedObjectContext:[self managedObjectContext]];
        
        [self presentModalViewController:graphVC animated:YES];
        
        [graphVC release];
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AddStudentViewController Delegate Methods
- (void)modalViewControllerShouldClose
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Private Methods
- (void)addStudent:(id)sender
{
    STAddStudentViewController *addStudentVC = [[STAddStudentViewController alloc] initWithContext:managedObjectContext];
    [addStudentVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [addStudentVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [addStudentVC setDelegate:self];
    
    [self presentModalViewController:addStudentVC animated:YES];
    
    [addStudentVC release];
}

- (void)graphButtonWasSelected:(id)sender
{
    UIActionSheet *graphSelectionActionSheet = [[[UIActionSheet alloc] initWithTitle:@"Choose a graph" 
                                                                           delegate:self 
                                                                  cancelButtonTitle:@"Cancel" 
                                                             destructiveButtonTitle:nil 
                                                                  otherButtonTitles:@"Enrolment over time", @"Subject totals - Bar", @"Subject totals - pie", nil] autorelease];
    
    [graphSelectionActionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - STLineGraphViewControllerDelegate Methods
- (void)doneButtonWasTapped:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [studentArray release];
    [managedObjectContext release];
    [super dealloc];
}
@end
