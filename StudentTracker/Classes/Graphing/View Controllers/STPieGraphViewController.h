//
//  STPieGraphViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 28/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@protocol STPieGraphViewControllerDelegate
@required
- (void)doneButtonWasTapped:(id)sender;

@end

@interface STPieGraphViewController : UIViewController <CPTPieChartDelegate>

@property (nonatomic, strong) CPTGraph *graph;
@property (nonatomic, assign) id<STPieGraphViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
