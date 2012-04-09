//
//  STAddStudentViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    STPickerStateDays = 0,
    STPickerStateSubjects = 1
}STPickerState;

@protocol AddStudentViewControllerDelegate
@required
- (void)modalViewControllerShouldClose;

@end

@interface STAddStudentViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id<AddStudentViewControllerDelegate> delegate;

@end
