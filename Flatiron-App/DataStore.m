//
//  dataStore.m
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "DataStore.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface DataStore ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation DataStore

//Legacy methods from the Core Data architecture

//Shared data store method
+ (instancetype) sharedDataStore {
    static DataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[DataStore alloc] init];
    });
    return _sharedDataStore;
}

- (void) generateTestData {
    
    //Create Orr basic info
    PFUser *orrBibring = [PFUser user];
    orrBibring.username = @"orrBibring";
    orrBibring.password = @"1234";
    orrBibring.email = @"orrbibring@flatironschool.com";
    orrBibring[@"firstName"] = @"Orr";
    orrBibring[@"lastName"] = @"Bibring";
    orrBibring[@"role"] = @"Student";
    orrBibring[@"beforeBio"] = @"Developer at CrowdTwist";
    orrBibring[@"afterBio"] = @"Looking to start my own app company.";
    orrBibring[@"funFact"] = @"Big Rick Ross fan.";
    orrBibring[@"gitHubURL"] = @"https://github.com/obibring";
    
    //Add a profile picture and associate to Orr
    UIImage *orrBibringImage = [UIImage imageNamed:@"orrBibring.png"];
    NSData *data = UIImagePNGRepresentation(orrBibringImage);
    PFFile *image = [PFFile fileWithName:@"image.png" data:data];
    [image saveInBackground];
    orrBibring[@"profileImage"] = image;
    
    //Save to Parse
    [orrBibring saveInBackground];
    
}

//Generate test data

//    Person *orrBibring = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:self.managedObjectContext];
//    orrBibring.firstName = @"Orr";
//    orrBibring.lastName = @"Bibring";
//    orrBibring.role = @"Student";
//    orrBibring.program = ios003;
//    orrBibring.quote = @"Where's the beef?";
//    orrBibring.before = @"Developer at CrowdTwist";
//    orrBibring.after = @"Looking to start my own app company.";
//    orrBibring.fun = @"Big Rick Ross fan.";
//    Image *orrBibringImageData = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Image class]) inManagedObjectContext:self.managedObjectContext];
//    UIImage *orrBibringUIImage = [UIImage imageNamed:@"orrBibring.png"];
//    orrBibringImageData.image = UIImagePNGRepresentation(orrBibringUIImage);
//    orrBibringImageData.person = orrBibring;


//Methods to set user information

- (void) setFirstName:(NSString *)firstName ForUser:(PFUser *)user {
}

- (void) setLasttName:(NSString *)lastName ForUser:(PFUser *)user {
    
}

- (void) setRole:(NSString *)role ForUser:(PFUser *)user {
    
}

- (void) setBefore:(NSString *)before ForUser:(PFUser *)user {
    
}

- (void) setAfter:(NSString *)after ForUser:(PFUser *)user {
    
}

- (void) setGitHubURL:(NSString *)URL ForUser:(PFUser *)user {
    
}

- (void) setFacebookURL:(NSString *)URL ForUser:(PFUser *)user {
    
}

- (void) setLinkedInURL:(NSString *)URL ForUser:(PFUser *)user {
    
}

- (void) setTwitterURL:(NSString *)URL ForUser:(PFUser *)user {
    
}

- (void) setGooglePlusURL:(NSString *)URL ForUser:(PFUser *)user {
    
}

- (void) setYoutubeURL:(NSString *)URL ForUser:(PFUser *)user {
    
}




////Get and create data
//- (void) fetchData {
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Person class])];
//    self.persons = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    if ([self.persons count] == 0) {
//        [self generateTestData];
//    }
//}
//
//- (void) generateTestData {
//    
//    Program *ios003 = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Program class]) inManagedObjectContext:self.managedObjectContext];
//    ios003.name = @"ios-003 (Fall 2014)";
//    
//    Person *orrBibring = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:self.managedObjectContext];
//    orrBibring.firstName = @"Orr";
//    orrBibring.lastName = @"Bibring";
//    orrBibring.role = @"Student";
//    orrBibring.program = ios003;
//    orrBibring.quote = @"Where's the beef?";
//    orrBibring.before = @"Developer at CrowdTwist";
//    orrBibring.after = @"Looking to start my own app company.";
//    orrBibring.fun = @"Big Rick Ross fan.";
//    Image *orrBibringImageData = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Image class]) inManagedObjectContext:self.managedObjectContext];
//    UIImage *orrBibringUIImage = [UIImage imageNamed:@"orrBibring.png"];
//    orrBibringImageData.image = UIImagePNGRepresentation(orrBibringUIImage);
//    orrBibringImageData.person = orrBibring;
//    
//    Person *charlesCNadeau = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:self.managedObjectContext];
//    charlesCNadeau.firstName = @"Charles";
//    charlesCNadeau.lastName = @"Coutu-Nadeau";
//    charlesCNadeau.role = @"Student";
//    charlesCNadeau.program = ios003;
//    charlesCNadeau.quote = @"It is good to have an end to journey toward; but it is the journey that matters, in the end.";
//    charlesCNadeau.before = @"Graduate student in Health Informatics at Cornell University";
//    charlesCNadeau.after = @"Looking to start my career in product management";
//    charlesCNadeau.fun = @"Former professional bowling player.";
//    charlesCNadeau.gitHubURL = @"churroslab";
//    Image *charlesCNadeauImageData = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Image class]) inManagedObjectContext:self.managedObjectContext];
//    UIImage *charlesCNadeauUIImage = [UIImage imageNamed:@"charlesCNadeau.png"];
//    charlesCNadeauImageData.image = UIImagePNGRepresentation(charlesCNadeauUIImage);
//    charlesCNadeauImageData.person = charlesCNadeau;
//    
//    Person *joeBurgess = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:self.managedObjectContext];
//    joeBurgess.firstName = @"Joe";
//    joeBurgess.lastName = @"Burgess";
//    joeBurgess.role = @"Instructor";
//    joeBurgess.program = ios003;
//    joeBurgess.quote = @"Best thing ever.";
//    joeBurgess.before = @"Carnegie Mellon grad and IBM consultant.";
//    joeBurgess.after = @"iOS Instructor at The Flatiron School";
//    joeBurgess.fun = @"I share the same name as a rugby star.";
//    Image *joeBurgessImageData = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Image class]) inManagedObjectContext:self.managedObjectContext];
//    UIImage *joeBurgessUIImage = [UIImage imageNamed:@"joeBurgess.png"];
//    joeBurgessImageData.image = UIImagePNGRepresentation(joeBurgessUIImage);
//    joeBurgessImageData.person = joeBurgess;
//    
//    [self saveContext];
//    [self fetchData];
//}
//
//
////Core Data Boiler Plate
//- (void)saveContext
//{
//    NSError *error = nil;
//    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
//}
//
//#pragma mark - Core Data stack
//// Returns the managed object context for the application.
//// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
//- (NSManagedObjectContext *)managedObjectContext
//{
//    if (_managedObjectContext != nil) {
//        return _managedObjectContext;
//    }
//    
//    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
//    
//    NSError *error = nil;
//    
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
//    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
//    
//    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
//    if (coordinator != nil) {
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
//    return _managedObjectContext;
//}
//
//
//#pragma mark - Application's Documents directory
//
//// Returns the URL to the application's Documents directory.
//- (NSURL *)applicationDocumentsDirectory
//{
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//}


@end
