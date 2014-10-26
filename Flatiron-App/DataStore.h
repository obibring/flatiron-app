//
//  dataStore.h
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSArray *persons;

+ (instancetype) sharedDataStore;
- (void) fetchData;

@end
