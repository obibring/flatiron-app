//
//  EveryoneTableTableViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "EveryoneTableTableViewController.h"
#import "ProfileViewController.h"
#import "EveryoneTableViewCell.h"
#import <Parse/Parse.h>

@interface EveryoneTableTableViewController ()

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation EveryoneTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.users = [[NSMutableArray alloc] init];
    self.users = [[self getAllUsers] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Search methods
//
//- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    self.users = [[self filterWith:searchText] mutableCopy];
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EveryoneTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    PFUser *user = self.users[indexPath.row];
    cell.fullName.text = [self getFullNameOf:user];
    cell.profileThumbnail.image = [self getProfileImageOfUser:user];
    cell.profileThumbnail.layer.cornerRadius = cell.profileThumbnail.frame.size.width / 2;
    cell.profileThumbnail.clipsToBounds = YES;
    return cell;
}

- (UIImage *) getProfileImageOfUser:(PFUser *)user {
    PFFile *profileImageFile = user[@"profileImage"];
    NSData *imageData = [profileImageFile getData];
    UIImage *profileImage = [UIImage imageWithData:imageData];
    return profileImage;
}

- (NSString *) getFullNameOf:(PFUser *)user {
    NSString *fullName;
    NSString *firstName = user[@"firstName"];
    NSString *lastName = user[@"lastName"];
    if (firstName && lastName)
        fullName = [fullName stringByAppendingString:user[@"lastName"]];
    else if (firstName)
        fullName = firstName;
    else if (lastName)
        fullName = lastName;
    else
        fullName = @"";
    return fullName;
}

- (NSArray *) getAllUsers {
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"lastName"]; //We are getting the query in alphabetical order (last name)
    return [query findObjects];
}
//- (NSArray *) filterWith:(NSString *)keyword {
//    PFQuery *first = [PFUser query];
//    [first whereKey:@"firstName" containsString:keyword];
//    
//    PFQuery *last = [PFUser query];
//    [last whereKey:@"lastName" containsString:keyword];
//    
//    PFQuery *combined = [PFQuery orQueryWithSubqueries:@[first, last]];
//    
//    NSLog(@"%@",[combined findObjects]);
//
//    return [combined findObjects];
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ProfileViewController *profileVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PFUser *user = self.users[indexPath.row];
    profileVC.title = [self getFullNameOf:user];
    profileVC.user = user;
}


@end
