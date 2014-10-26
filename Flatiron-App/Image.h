//
//  Image.h
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) Person *person;

@end
