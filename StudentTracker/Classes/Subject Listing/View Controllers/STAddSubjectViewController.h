//
//  STAddSubjectViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddSubjectViewControllerDelegate
@required
- (void)modalViewControllerShouldClose;

@end

@interface STAddSubjectViewController : UIViewController <UITextFieldDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id<AddSubjectViewControllerDelegate> delegate;

@end
