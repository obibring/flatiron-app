//
//  Program.h
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Program : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSSet *persons;
@end

@interface Program (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;

@end
