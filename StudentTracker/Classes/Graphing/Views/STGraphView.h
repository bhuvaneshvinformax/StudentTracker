//
//  STGraphView.h
//  StudentTracker
//
//  Created by Aron Bury on 26/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface STGraphView : UIView

@property (nonatomic, strong) CPTGraphHostingView *chartHostingView;

@end
