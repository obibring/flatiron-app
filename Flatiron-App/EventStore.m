//
//  EventStore.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/26/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "EventStore.h"
#import

@interface EventStore ()
@property NSMutableDictionary *events;
@end

@implementation EventStore

-init {
    self = [super init];
    if (self) {
        _events = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSArray *)eventsForDate:(NSDate *)date {
    
}


@end
