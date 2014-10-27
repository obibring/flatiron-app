//
//  EveryoneTableTableViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "EveryoneTableTableViewController.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface EveryoneTableTableViewController ()

@property (strong, nonatomic) NSArray *users;

@end

@implementation EveryoneTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.users = [self getAllUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    PFUser *user = self.users[indexPath.row];
    cell.textLabel.text = [self getFullNameOf:user];
    return cell;
}

- (NSString *) getFullNameOf:(PFUser *)user {
    NSString *fullName = [user[@"firstName"] stringByAppendingString:@" "];
    fullName = [fullName stringByAppendingString:user[@"lastName"]];
    return fullName;
}

- (NSArray *) getAllUsers {
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"lastName"]; //We are getting the query in alphabetical order (last name)
    return [query findObjects];
}
- (NSArray *) getUsersOfType:(NSString *)type {
    PFQuery *query = [PFUser query];
    [query whereKey:@"program" containsString:type];
    return [query findObjects];
}


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
