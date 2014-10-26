//
//  OnboardingViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/26/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "OnboardingViewController.h"
#import <Parse/Parse.h>

@interface OnboardingViewController () 

@end

@implementation OnboardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    PFLogInViewController *loginVc = [[PFLogInViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
    loginVc.delegate = self;
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
