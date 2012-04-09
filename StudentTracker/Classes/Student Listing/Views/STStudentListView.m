//
//  STStudentListView.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STStudentListView.h"

@implementation STStudentListView

@synthesize studentListTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setStudentListTableView:[[[UITableView alloc] initWithFrame:CGRectZero] autorelease]];
        
        [self addSubview:studentListTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[self studentListTableView] setFrame:CGRectMake(0.0, 
                                                     0.0, 
                                                     self.frame.size.width, 
                                                     self.frame.size.height)];
    
}

- (void)dealloc
{
    [studentListTableView release];
    [super dealloc];
}

@end
