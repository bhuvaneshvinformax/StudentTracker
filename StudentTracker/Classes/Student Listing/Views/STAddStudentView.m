//
//  STAddStudentView.m
//  StudentTracker
//
//  Created by Aron Bury on 9/04/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STAddStudentView.h"

@interface STAddStudentView()
- (UILabel *)getStyledLabel;
- (UITextField *)getStyledTextFieldWithTag:(int)tag;
@end

@implementation STAddStudentView

@synthesize nameLabel;
@synthesize subjectLabel;
@synthesize dayEnrolledLabel;

@synthesize nameTextField;
@synthesize subjectTextField;
@synthesize dayEnrolledTextField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
        
        [self setNameLabel:[self getStyledLabel]];
        [self setSubjectLabel:[self getStyledLabel]];
        [self setDayEnrolledLabel:[self getStyledLabel]];
        
        [nameLabel setText:@"Student Name:"];
        [subjectLabel setText:@"Subject Enrolled:"];
        [dayEnrolledLabel setText:@"Day enrolled"];
        
        [self setNameTextField:[self getStyledTextFieldWithTag:1]];
        [self setSubjectTextField:[self getStyledTextFieldWithTag:2]];
        [self setDayEnrolledTextField:[self getStyledTextFieldWithTag:3]];
        
        [self addSubview:nameLabel];
        [self addSubview:subjectLabel];
        [self addSubview:dayEnrolledLabel];
        
        [self addSubview:nameTextField];
        [self addSubview:subjectTextField];
        [self addSubview:dayEnrolledTextField];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float vPadding = 5;
    float vSectionPadding = 10;
    
    [[self nameLabel] setFrame:CGRectMake(10., vPadding * 10, self.frame.size.width - 20., 30)];
    [[self nameTextField] setFrame:CGRectMake(10., 
                                              nameLabel.frame.origin.y + nameLabel.frame.size.height + vPadding, 
                                              self.frame.size.width - 20., 
                                              30)];
    
    [[self subjectLabel] setFrame:CGRectMake(10., nameTextField.frame.origin.y + nameTextField.frame.size.height + vSectionPadding
                                             ,self.frame.size.width - 20.
                                             ,30)];  
    
    [[self subjectTextField] setFrame:CGRectMake(10., 
                                              subjectLabel.frame.origin.y + subjectLabel.frame.size.height + vPadding, 
                                              self.frame.size.width - 20, 
                                              30)];
    
    [[self dayEnrolledLabel] setFrame:CGRectMake(10., subjectTextField.frame.origin.y + subjectTextField.frame.size.height + vSectionPadding
                                             ,self.frame.size.width - 20.
                                             ,30)];
    
    [[self dayEnrolledTextField] setFrame:CGRectMake(10., 
                                                 dayEnrolledLabel.frame.origin.y + dayEnrolledLabel.frame.size.height + vPadding, 
                                                 self.frame.size.width - 20., 
                                                 30)];
}

- (void)dealloc
{
    [nameLabel release];
    [subjectLabel release];
    [dayEnrolledLabel release];
    
    [nameTextField release];
    [subjectTextField release];
    [dayEnrolledTextField release];
    
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
