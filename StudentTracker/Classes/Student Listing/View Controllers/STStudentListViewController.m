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
    
    studentView.studentListTableView.delegate = self;
    studentView.studentListTableView.dataSource = self;
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    self.studentArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (STStudent *info in studentArray) 
    {
        NSLog(@"Name: %@", info.studentName);
        NSLog(@"ID: %@", info.studentID);
        NSLog(@"Days: %@", info.dayEnrolled);
        NSLog(@"subjectID: %@", info.subjectID);
        NSLog(@" ");
    }
    
    [fetchRequest release];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    self.studentArray = [context executeFetchRequest:fetchRequest error:&error];
    
    STStudentListView *studentView = (STStudentListView *)self.view;
    
    [[studentView studentListTableView] reloadData];
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
    [[cell textLabel] setText:student.studentID];
    [[cell detailTextLabel] setText:student.studentName];
    
    return cell;
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

- (void)dealloc
{
    [studentArray release];
    [managedObjectContext release];
    [super dealloc];
}
@end
