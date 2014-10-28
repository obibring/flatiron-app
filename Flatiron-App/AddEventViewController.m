//
//  AddEventViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "AddEventViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

#define leftPadding 5

@interface AddEventViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *isAllDayEventInput;
@property (weak, nonatomic) IBOutlet UITextField *startDateInput;
@property (weak, nonatomic) IBOutlet UISwitch *switchInput;
@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endTimePicker;
@property (weak, nonatomic) IBOutlet UISwitch *theSwitch;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;
@property (weak, nonatomic) IBOutlet UILabel *pushNotificationInput;
@property (weak, nonatomic) IBOutlet UITextField *descriptionInput;
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
    
    self.saveButton.tintColor = flatironBlueDark;
    self.cancelButton.tintColor = flatironBlueDark;
    
    // By default, disable the save button until the event has enough information.
    self.saveButton.enabled = NO;
    
    // Create date pickers as inputViews for the start end end textViews
    self.startDatePicker = [[UIDatePicker alloc] init];
    
    self.endTimePicker = [[UIDatePicker alloc] init];
    self.endTimePicker.datePickerMode = UIDatePickerModeTime;
    
    // Set the default starting date for the start date picker
    self.startDatePicker.date = self.defaultDatePickerDate;
    
//    self.startDateInput.inputView = self.startDatePicker;
    self.startDateInput.inputAccessoryView = self.startDatePicker;
    self.endTime.inputAccessoryView = self.endTimePicker;
    
    // Set delegates
    self.startDateInput.delegate = self;
    self.endTime.delegate = self;
    self.titleInput.delegate = self;
    
    // Add padding to text inputs
    [self addPaddingToTextInputs];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions

- (IBAction)isAllDayEventToggle:(id)sender {
    UISwitch *theSwitch = (UISwitch *)sender;
    
    if (theSwitch.on) {
        self.endTime.enabled = NO;
        self.endTime.hidden = YES;
        self.startDatePicker.datePickerMode = UIDatePickerModeDate;
        self.startDateInput.text = [self formatDate:self.startDatePicker.date];
    } else {
        self.startDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.endTime.hidden = NO;
        self.endTime.enabled = YES;
        self.startDateInput.text = [self formatDate:self.startDatePicker.date];
    }
}

- (IBAction)save:(id)sender {
    [self.view endEditing:YES];
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"startDate"] = self.startDatePicker.date;
    event[@"title"] = self.titleInput.text;
    [event saveInBackground];
    
    if (self.pushNotificationSwitch.on) {
        // Send push notification
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
        
        // Send push notification
        [PFPush sendPushMessageToQueryInBackground:pushQuery withMessage:[NSString stringWithFormat:@"New Flatiron Event: %@", event[@"title"]]];
    }
    
    [self.delegate addEventViewController:self didSaveEvent:event];
}

- (IBAction)cancel:(id)sender {
    [self.delegate addEventViewControllerDidCancel:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"TOUCHES BEGAN");
    [self.view endEditing:YES];
}

- (IBAction)toggleSendPushNotification:(id)sender {
    if (self.pushNotificationSwitch.on) {
        // Make sure the user understands the gravity of the situation
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoa." message:@"You are about to send a push notification to ALL THE USERS. You sure?" delegate:self cancelButtonTitle:@"Um, not sure." otherButtonTitles:@"Totally Sure.", nil];
        alert.delegate = self;
        [alert show];
    }
}


#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.pushNotificationSwitch setOn:NO animated:YES];
    }
}

#pragma mark - UITextViewDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.startDateInput) {
        self.startDateInput.text = [self formatDate:self.startDatePicker.date];
    }
    if (textField == self.endTime) {
        self.endTime.text = [self formatTime:self.endTimePicker.date];
    }
    [self checkIfNeedsEnablingAndEnableSaveButtonWithStartDate:self.startDatePicker.date
                                                         title:self.titleInput.text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self checkIfNeedsEnablingAndEnableSaveButtonWithStartDate:self.startDatePicker.date
                                                         title:string];
    return YES;
}

#pragma mark - utilities

-(NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (self.theSwitch.on) {
        // Show only the month, date and year
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
    } else {
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    return [formatter stringFromDate:date];
}

-(NSString *)formatTime:(NSDate *)date {
    NSDateComponents *components = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:(NSCalendarUnitMinute | NSCalendarUnitHour) fromDate:date];
    
    int hours = components.hour;
    int minutes = components.minute;
    
    id timeStr = [[NSMutableString alloc] initWithFormat: @"%02d:%02d", hours, minutes];
//    id dateTimeStr = [[NSString alloc] initWithFormat: @"%@ %@", dateStr, timeStr];
//    id dateTime = [dateWithTimeFormatter dateFromString:dateTimeStr];
    return timeStr;
}


// Checks whether the save button should be enabled, and if so, enables it.
-(void)checkIfNeedsEnablingAndEnableSaveButtonWithStartDate:(NSDate *)start title:(NSString *)title {
    self.saveButton.enabled = [self formIsValidWithStartDate:start title:title];
}

-(BOOL)formIsValidWithStartDate:(NSDate *)start title:(NSString *)title {
    if (!start) { // Must Exist
        return NO;
    } else if (!title || [title length] == 0) {
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
    self.isAllDayEventInput.leftView = [[self class] makePaddingView];
    self.endTime.leftView = [[self class] makePaddingView];
    self.endTime.leftViewMode = UITextFieldViewModeAlways;
    self.isAllDayEventInput.leftViewMode = UITextFieldViewModeAlways;
//    self.pushNotificationInput.leftView = [[self class] makePaddingView];
//    self.pushNotificationInput.leftViewMode = UITextFieldViewModeAlways;
    self.descriptionInput.leftView = [[self class] makePaddingView];
    self.descriptionInput.leftViewMode = UITextFieldViewModeAlways;
}

@end
