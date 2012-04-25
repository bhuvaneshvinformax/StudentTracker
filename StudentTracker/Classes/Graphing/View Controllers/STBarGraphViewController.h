//
//  STBarGraphViewController.h
//  StudentTracker
//
//  Created by Aron Bury on 25/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@protocol STBarGraphViewControllerDelegate
@required
- (void)doneButtonWasTapped:(id)sender;

@end

@interface STBarGraphViewController : UIViewController <CPTBarPlotDelegate, CPTBarPlotDataSource>

@property (nonatomic, strong) CPTGraph *graph;
@property (nonatomic, assign) id<STBarGraphViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
