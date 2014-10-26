//
//  AddEventViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "AddEventViewController.h"
#define leftPadding 5

@interface AddEventViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *isAllDayEventInput;
@property (weak, nonatomic) IBOutlet UITextField *startDateInput;
@property (weak, nonatomic) IBOutlet UITextField *endDateInput;
@property (weak, nonatomic) IBOutlet UISwitch *switchInput;
@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endDatePicker;
-(void)addPaddingToTextInputs;
+(UIView *)makePaddingView;
-(BOOL)formIsValid;
@end

@interface PaddedLabel : UILabel
@end

@implementation PaddedLabel

-(void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, leftPadding, 0, 0))];
}

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // By default, disable the save button until the event has enough information.
    self.saveButton.enabled = NO;
    
    // Create date pickers as inputViews for the start end end textViews
    self.startDatePicker = [[UIDatePicker alloc] init];
    self.endDatePicker = [[UIDatePicker alloc] init];
    
    // Make sure the end date picker is never before the start date
    self.endDatePicker.minimumDate = self.startDatePicker.date;
    
//    self.startDatePicker.translatesAutoresizingMaskIntoConstraints = NO;
//    self.endDatePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.startDateInput.inputView = self.startDatePicker;
//    self.startDateInput.inputAccessoryView = self.startDatePicker;
    self.endDateInput.inputView = self.endDatePicker;
//    self.endDateInput.inputAccessoryView = self.endDatePicker;
    
    // Set delegates
    self.startDateInput.delegate = self;
    self.endDateInput.delegate = self;
    self.titleInput.delegate = self;
    
    // Add padding to text inputs
    [self addPaddingToTextInputs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (IBAction)save:(id)sender {
    [self.delegate addEventViewControllerDidSave:self];
}

- (IBAction)cancel:(id)sender {
    [self.delegate addEventViewControllerDidCancel:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.startDateInput) {
        self.startDateInput.text = [self formatDate:self.startDatePicker.date];
    } else if (textField == self.endDateInput) {
        self.endDateInput.text = [self formatDate:self.endDatePicker.date];
    }
    [self checkIfNeedsEnablingAndEnableSaveButton];
}

#pragma mark - utilities

-(NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    return [formatter stringFromDate:date];
}

// Checks whether the save button should be enabled, and if so, enables it.
-(void)checkIfNeedsEnablingAndEnableSaveButton {
    self.saveButton.enabled = [self formIsValid];
}

-(BOOL)formIsValid {
    NSDate *start = self.startDatePicker.date;
    NSDate *end = self.endDatePicker.date;
    NSString *title = self.titleInput.text;
    
    if (!start || !end) { // Must Exist
        return NO;
    } else if ([start compare:end] != NSOrderedAscending) { // Must be in order
        return NO;
    } else if (!title || [title length] < 1) {
        return NO;
    }
    
    return YES;
}

+(UIView *)makePaddingView {
   return [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, 20)];
}

-(void)addPaddingToTextInputs {
    self.titleInput.leftView = [[self class] makePaddingView];
    self.titleInput.leftViewMode = UITextFieldViewModeAlways;
    self.startDateInput.leftView = [[self class] makePaddingView];
    self.startDateInput.leftViewMode = UITextFieldViewModeAlways;
    self.endDateInput.leftView = [[self class] makePaddingView];
    self.endDateInput.leftViewMode = UITextFieldViewModeAlways;
    self.isAllDayEventInput.leftView = [[self class] makePaddingView];
    self.isAllDayEventInput.leftViewMode = UITextFieldViewModeAlways;
}

@end
