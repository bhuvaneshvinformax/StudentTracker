//
//  STStudentListViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAddStudentViewController.h"

@interface STStudentListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddStudentViewControllerDelegate, UIActionSheetDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
