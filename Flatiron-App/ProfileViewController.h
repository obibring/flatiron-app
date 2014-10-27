//
//  ProfileViewController.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFUser;

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFUser *user;

@end
