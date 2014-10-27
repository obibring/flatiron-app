//
//  Person.h
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Program;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * after;//
@property (nonatomic, retain) NSString * before;//
@property (nonatomic, retain) NSString * facebookURL;//
@property (nonatomic, retain) NSString * firstName;//
@property (nonatomic, retain) NSString * fun;
@property (nonatomic, retain) NSString * gitHubURL;//
@property (nonatomic, retain) NSString * lastName;//
@property (nonatomic, retain) NSString * linkedInURL;//
@property (nonatomic, retain) NSString * quote;
@property (nonatomic, retain) NSString * role;//
@property (nonatomic, retain) NSString * twitterURL;
@property (nonatomic, retain) Image *image;
@property (nonatomic, retain) Program *program;

@end
