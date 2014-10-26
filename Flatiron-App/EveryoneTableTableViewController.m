//
//  EveryoneTableTableViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "EveryoneTableTableViewController.h"
#import "ProfileViewController.h"
#import "DataStore.h"
#import "Person.h"
#import "Image.h"

@interface EveryoneTableTableViewController ()

@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation EveryoneTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [DataStore sharedDataStore];
    [self.dataStore fetchData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dataStore.persons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Person *person = self.dataStore.persons[indexPath.row];
    NSString *fullName = [self getFullNameOf:person];
    UIImage *profileImage = [self getImageOf:person];
    cell.imageView.image = profileImage;
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
    cell.imageView.clipsToBounds = YES;
    cell.textLabel.text = fullName;
    return cell;
}


- (NSString *) getFullNameOf:(Person *)person {
    NSString *fullName = [person.firstName stringByAppendingString:@" "];
    fullName = [fullName stringByAppendingString:person.lastName];
    return fullName;
}

- (UIImage *) getImageOf:(Person *)person {
    return [UIImage imageWithData:person.image.image];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ProfileViewController *profileVC = segue.destinationViewController;
    NSIndexPath *indexSelected = [self.tableView indexPathForSelectedRow];
    Person *person = self.dataStore.persons[indexSelected.row];
    profileVC.title = [self getFullNameOf:person];
    profileVC.person = person;
}


@end
