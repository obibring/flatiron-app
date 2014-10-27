//
//  MeViewController.m
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/27/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "MeViewController.h"
#import <Parse/Parse.h>

@interface MeViewController ()

@property (strong, nonatomic) PFUser *me;
//Contact info
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *program;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
//Social
@property (weak, nonatomic) IBOutlet UITextField *gitHubHandle;
@property (weak, nonatomic) IBOutlet UIButton *gitHubButton;
@property (weak, nonatomic) IBOutlet UITextField *facebookHandle;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UITextField *twitterHandle;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UITextField *linkedInURL;
@property (weak, nonatomic) IBOutlet UIButton *linkedInButton;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.me = [PFUser currentUser];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
#warning work to be done to prevent bad input
    //Contact info
    if (textField == self.firstName) {
        self.me[@"firstName"] = self.firstName.text;
    } else if (textField == self.lastName) {
        self.me[@"lastName"] = self.lastName.text;
    } else if (textField == self.program) {
        self.me[@"program"] = self.program.text;
    } else if (textField == self.mobile) {
        self.me[@"mobileNumber"] = self.mobile.text;
    }
    
    //Social URLs
    else if (textField == self.gitHubHandle) {
        NSString *gitHubURL = [@"https://github.com/" stringByAppendingString:self.gitHubHandle.text];
        self.me[@"gitHubURL"] = gitHubURL;
    } else if (textField == self.facebookHandle) {
        NSString *facebookURL = [@"https://www.facebook.com/" stringByAppendingString:self.facebookHandle.text];
        self.me[@"facebookURL"] = facebookURL;
    } else if (textField == self.twitterHandle) {
        NSString *twitterURL = [@"https://twitter.com/" stringByAppendingString:self.twitterHandle.text];
        self.me[@"twitterURL"] = twitterURL;
    } else if (textField == self.linkedInURL) {
        self.me[@"linkedInURL"] = self.linkedInURL;
    }
    return YES;
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
