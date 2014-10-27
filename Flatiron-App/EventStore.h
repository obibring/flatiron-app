//
//  EventStore.h
//  Flatiron-App
//
//  Created by Orr Bibring on 10/26/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventStore : NSObject

-(void)fetchAllEvents;
-(NSArray *)eventsForDate:(NSDate *)date;

@end
