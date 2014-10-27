//
//  LoginViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/26/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flatiron-logo-resized"]];
    self.logInView.signUpButton.backgroundColor = [UIColor colorWithRed:41 green:184 blue:255 alpha:1.0];
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
