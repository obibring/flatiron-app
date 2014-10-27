//
//  AddEventDelegate.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class AddEventViewController;

@protocol AddEventDelegate
@required
-(void)addEventViewController:(AddEventViewController *)addEventViewController didSaveEvent:(PFObject *)event;
-(void)addEventViewControllerDidCancel:(AddEventViewController *)addEventViewController;
@end
