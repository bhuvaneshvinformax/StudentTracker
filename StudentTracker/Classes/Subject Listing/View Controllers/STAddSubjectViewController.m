//
//  STAddSubjectViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STAddSubjectViewController.h"
#import "STAddSubjectView.h"
#import "STSubject.h"

@interface STAddSubjectViewController ()
@property (nonatomic, strong) UINavigationItem *navItem;

- (void)addSubject:(id)sender;

@end

@implementation STAddSubjectViewController

@synthesize navItem;
@synthesize managedObjectContext;
@synthesize delegate;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Add A Student";
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[STAddSubjectView alloc] initWithFrame:self.view.frame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STAddSubjectView *addSubjectView = (STAddSubjectView *)self.view;    
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navigationItem setHidesBackButton:YES];
    [self setNavItem:navigationItem];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone 
                                                                    target:self 
                                                                    action:@selector(addSubject:)] autorelease] animated:NO];
    [navItem setTitle:self.title];
    
    [[addSubjectView nameTextField] setDelegate:self];
}

- (void)addSubject:(id)sender
{
    STAddSubjectView *addSubjectView = (STAddSubjectView *)self.view;
    NSError *error;
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"subjectID" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sorter, nil];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STSubject"
                                              inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    [sorter release];
    
    STSubject *subjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"STSubject" inManagedObjectContext:managedObjectContext];
    [subjectToAdd setSubjectID:[NSNumber numberWithInt:[fetchedObjects count]]];
    [subjectToAdd setSubjectName:addSubjectView.nameTextField.text];
    
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [delegate modalViewControllerShouldClose];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)dealloc
{
    [managedObjectContext release];
    [navItem release];
    
    [super dealloc];
}

@end
