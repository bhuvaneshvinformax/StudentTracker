//
//  STLineGraphViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 18/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@protocol STLineGraphViewControllerDelegate
@required
- (void)doneButtonWasTapped:(id)sender;

@end

@interface STLineGraphViewController : UIViewController <CPTScatterPlotDataSource, CPTScatterPlotDelegate>

@property (nonatomic, strong) CPTGraph *graph;
@property (nonatomic, assign) id<STLineGraphViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

