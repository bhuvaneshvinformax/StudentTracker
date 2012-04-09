//
//  STAddSubjectView.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STAddSubjectView.h"

@interface STAddSubjectView()
- (UILabel *)getStyledLabel;
- (UITextField *)getStyledTextFieldWithTag:(int)tag;
@end

@implementation STAddSubjectView

@synthesize nameLabel;


@synthesize nameTextField;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
        
        [self setNameLabel:[self getStyledLabel]];
        
        [nameLabel setText:@"Subject Name:"];

        [self setNameTextField:[self getStyledTextFieldWithTag:1]];

        [self addSubview:nameLabel];
        [self addSubview:nameTextField];

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float vPadding = 5;
    
    [[self nameLabel] setFrame:CGRectMake(10., vPadding * 10, self.frame.size.width - 20., 30)];
    [[self nameTextField] setFrame:CGRectMake(10., 
                                              nameLabel.frame.origin.y + nameLabel.frame.size.height + vPadding, 
                                              self.frame.size.width - 20., 
                                              30)];
}

- (void)dealloc
{
    
    [nameLabel release];
    [nameTextField release];
    
    [super dealloc];
}

#pragma mark - private methods
- (UILabel *)getStyledLabel
{
    UILabel *returnlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [returnlabel setFont:[UIFont boldSystemFontOfSize:20]];
    [returnlabel setTextAlignment:UITextAlignmentLeft];
    [returnlabel setBackgroundColor:[UIColor clearColor]];
    
    return [returnlabel autorelease];    
}

- (UITextField *)getStyledTextFieldWithTag:(int)tag
{
    UITextField *returnTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [returnTextField setTag:tag];
    [returnTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [returnTextField setReturnKeyType:UIReturnKeyDone];    
    
    return [returnTextField autorelease];
}
@end
