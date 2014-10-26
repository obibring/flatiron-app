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
@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // By default, disable the save button until the event has enough information.
    self.saveButton.enabled = NO;
    
    // Add padding to text inputs
    [self addPaddingToTextInputs];
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

+(UIView *)makePaddingView {
   return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)save:(id)sender {
    [self.delegate addEventViewControllerDidSave:self];
}

- (IBAction)cancel:(id)sender {
    [self.delegate addEventViewControllerDidCancel:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
