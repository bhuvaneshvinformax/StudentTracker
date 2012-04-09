//
//  STAddStudentViewController.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STAddStudentViewController.h"
#import "STAddStudentView.h"
#import "STStudent.h"
#import "STSubject.h"

@interface STAddStudentViewController ()
@property (nonatomic, strong) NSArray *daysArray;
@property (nonatomic, strong) NSArray *subjectsArray;
@property (nonatomic) STPickerState pickerState;

@property (nonatomic, strong) UINavigationItem *navItem;

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIActionSheet *actionSheet;

- (void)dismissPickerView:(id)sender;
- (void)addStudent:(id)sender;

@end

@implementation STAddStudentViewController

@synthesize managedObjectContext;
@synthesize daysArray;
@synthesize subjectsArray;
@synthesize pickerState;

@synthesize delegate;

@synthesize navItem;

@synthesize picker;
@synthesize actionSheet;

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
    
    self.view = [[STAddStudentView alloc] initWithFrame:self.view.frame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navigationItem setHidesBackButton:YES];
    [self setNavItem:navigationItem];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone 
                                                                    target:self 
                                                                    action:@selector(addStudent:)] autorelease] animated:NO];
    [navItem setTitle:self.title];
    
    UIActionSheet *_actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [_actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent]; 
    [self setActionSheet:_actionSheet];
    
    UIPickerView *_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.delegate = self;
    [self setPicker:_pickerView];
    
    [actionSheet addSubview:picker];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES; 
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissPickerView:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    [_pickerView release];
    [_actionSheet release];
    
    STAddStudentView *addStudentView = (STAddStudentView *)self.view;
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STSubject" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    self.subjectsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.daysArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    
    [[addStudentView nameTextField] setDelegate:self];
    [[addStudentView subjectTextField] setDelegate:self];
    [[addStudentView dayEnrolledTextField] setDelegate:self];
    
    [navigationItem release];
}

#pragma mark - UIPickerDelegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    
    if (pickerState == STPickerStateSubjects) 
    {
        STSubject *subject = [subjectsArray objectAtIndex:row];
        title = [NSString stringWithFormat:@"%@ - %d", subject.subjectName, [subject.subjectID intValue]];        
    }
    else if (pickerState == STPickerStateDays)
    {
        title = [daysArray objectAtIndex:row];        
    }
    
    return title;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerState == STPickerStateSubjects) 
    {
        return [subjectsArray count];
    }
    else if (pickerState == STPickerStateDays)
    {
        return [daysArray count];
    }
    
    return 0;
}

#pragma mark - UITextFieldDelgate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) 
    {
        return YES;

    }
    else 
    {
        if (textField.tag == 2) 
        {
            pickerState = STPickerStateSubjects;
        }
        else if (textField.tag == 3)
        {
            pickerState = STPickerStateDays;            
        }
        
        [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        
        [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
        
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:0 animated:NO];
        
        return NO;
    }
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
         
#pragma mark - Private Methods
- (void)dismissPickerView:(id)sender
{
    STAddStudentView *addStudentView = (STAddStudentView *)self.view;
    
    int selectedRow = [picker selectedRowInComponent:0];
    
    if (pickerState == STPickerStateSubjects) 
    {
        STSubject *subject = [subjectsArray objectAtIndex:selectedRow];
        
        [addStudentView.subjectTextField setText:[NSString stringWithFormat:@"%d", [[subject subjectID] intValue]]];
    }
    else if (pickerState == STPickerStateDays)
    {
        [addStudentView.dayEnrolledTextField setText:[daysArray objectAtIndex:selectedRow]];      
    }
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)addStudent:(id)sender
{
    STAddStudentView *addStudentView = (STAddStudentView *)self.view;
    NSError *error;
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"studentID" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sorter, nil];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"STStudent"
                                              inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    [sorter release];
    
    STStudent *studentToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"STStudent" inManagedObjectContext:managedObjectContext];
    [studentToAdd setStudentID:[NSString stringWithFormat:@"s%d", [fetchedObjects count]]];
    [studentToAdd setStudentName:addStudentView.nameTextField.text];
    [studentToAdd setDayEnrolled:[NSNumber numberWithInt:[addStudentView.dayEnrolledTextField.text intValue]]];
    [studentToAdd setSubjectID:[NSNumber numberWithInt:[addStudentView.subjectTextField.text intValue]]];
    
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [delegate modalViewControllerShouldClose];
}

- (void)dealloc
{
    [daysArray release];
    [subjectsArray release];
    [managedObjectContext release];
    [navItem release];
    
    [super dealloc];
}

@end
