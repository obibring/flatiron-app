//
//  AddEventViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController () 
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *isAllDayEventInput;
@property (weak, nonatomic) IBOutlet UITextField *startDateInput;
@property (weak, nonatomic) IBOutlet UITextField *endDateInput;
@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endDatePicker;
@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // By default, disable the save button until the event has enough information.
    self.saveButton.enabled = NO;
   
    
    // Create date pickers as inputViews for the start end end textViews
    self.startDatePicker = [[UIDatePicker alloc] init];
    self.endDatePicker = [[UIDatePicker alloc] init];
    
    self.startDateInput.inputView = self.startDatePicker;
    self.endDateInput.inputView = self.endDatePicker;
    
    
    // Set delegates
    self.startDateInput.delegate = self;
    self.endDateInput.delegate = self;
    
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

-(void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"DID END EDITING");
}

#pragma mark - utilities

+(UIView *)makePaddingView {
   return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
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
