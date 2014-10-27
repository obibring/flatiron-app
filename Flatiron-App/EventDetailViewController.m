//
//  EventDetailViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/27/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Constants.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backButton.tintColor = flatironBlueDark;
    self.navBar.title = self.event[@"]title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
