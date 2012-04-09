//
//  STSubjectListView.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STSubjectListView.h"

@implementation STSubjectListView

@synthesize subjectTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setSubjectTableView:[[[UITableView alloc] initWithFrame:CGRectZero] autorelease]];
        
        [self addSubview:subjectTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[self subjectTableView] setFrame:CGRectMake(0.0, 
                                                 0.0, 
                                                 self.frame.size.width, 
                                                 self.frame.size.height)];
    
}

- (void)dealloc
{
    [subjectTableView release];
    [super dealloc];
}

@end
