//
//  EventDetailViewController.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/27/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EventDetailViewController : UIViewController
@property (strong, nonatomic) PFObject *event;
@end
