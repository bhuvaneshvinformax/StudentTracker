//
//  STLineGraphView.m
//  StudentTracker
//
//  Created by Aron Bury on 21/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STLineGraphView.h"

@implementation STLineGraphView

@synthesize chartHostingView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        
        [self setChartHostingView:[[[CPTGraphHostingView alloc] initWithFrame:CGRectZero] autorelease]];
        [chartHostingView setBackgroundColor:[UIColor purpleColor]];
        
        [self addSubview:chartHostingView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float chartHeight = self.frame.size.height - 40;
    float chartWidth = self.frame.size.width;    
    
    [[self chartHostingView] setFrame:CGRectMake(0, 0, chartWidth, chartHeight)];
    [[self chartHostingView] setCenter:[self center]];
    
    
}

- (void)dealloc
{
    [chartHostingView release];
    
    [super dealloc];
}



@end
