//
//  STSubjectListViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAddSubjectViewController.h"

@interface STSubjectListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddSubjectViewControllerDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
