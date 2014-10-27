//
//  AddEventViewController.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventDelegate.h"


@interface AddEventViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSDate *defaultDatePickerDate;
@property (weak, nonatomic) id <AddEventDelegate> delegate;

@end
