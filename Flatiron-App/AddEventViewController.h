//
//  AddEventViewController.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventDelegate.h"


@interface AddEventViewController : UIViewController

@property (strong, nonatomic) NSDate *dateOfEvent;
@property (weak, nonatomic) id <AddEventDelegate> delegate;

@end
