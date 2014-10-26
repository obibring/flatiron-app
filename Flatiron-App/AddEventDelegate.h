//
//  AddEventDelegate.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddEventViewController;

@protocol AddEventDelegate
@required
-(void)addEventViewControllerDidSave:(AddEventViewController *)addEventViewController;
-(void)addEventViewControllerDidCancel:(AddEventViewController *)addEventViewController;
@end
