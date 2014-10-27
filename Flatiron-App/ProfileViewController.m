//
//  ProfileViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
//Basic info
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *program;
//Contact info
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *cellNumber;
@property (weak, nonatomic) IBOutlet UIButton *gitHubButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *linkedInButton;
//Bio
@property (weak, nonatomic) IBOutlet UILabel *before;
@property (weak, nonatomic) IBOutlet UILabel *after;
@property (weak, nonatomic) IBOutlet UILabel *fun;
//Social buttons tapped
- (IBAction)gitHubButtonTapped:(id)sender;
- (IBAction)facebookButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)linkedInButtonTapped:(id)sender;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillProfileInformation];
    [self resetSocialIcons];
    [self activateSocialIcons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fillProfileInformation {
    [self getProfileImageRounded:YES border:YES];
    self.name.text = self.title; //The title of the view was set to the full name;
    self.program.text = self.user[@"program"];
    self.before.text = self.user[@"beforeBio"];
    self.after.text = self.user[@"afterBio"];
    self.fun.text = self.user[@"funFact"];
    self.email.text = self.user.email;
    
}

- (void) resetSocialIcons {
    self.gitHubButton.enabled = NO;
    self.facebookButton.enabled = NO;
    self.twitterButton.enabled = NO;
    self.linkedInButton.enabled = NO;
}

- (void) activateSocialIcons {
    if (self.user[@"gitHubURL"]) {
        UIImage *gitHubIcon = [UIImage imageNamed:@"github.png"];
        [self.gitHubButton setImage:gitHubIcon forState:UIControlStateNormal];
        self.gitHubButton.enabled = YES;
    }
    
    if (self.user[@"facebookURL"]) {
        UIImage *facebookIcon = [UIImage imageNamed:@"facebook.png"];
        [self.facebookButton setImage:facebookIcon forState:UIControlStateNormal];
        self.facebookButton.enabled = YES;
    }
    
    if (self.user[@"twitterURL"]) {
        UIImage *twitterIcon = [UIImage imageNamed:@"twitter.png"];
        [self.twitterButton setImage:twitterIcon forState:UIControlStateNormal];
        self.twitterButton.enabled = YES;
    }
    
    if (self.user[@"linkedInURL"]) {
        UIImage *linkedInIcon = [UIImage imageNamed:@"linkedin.png"];
        [self.linkedInButton setImage:linkedInIcon forState:UIControlStateNormal];
        self.linkedInButton.enabled = YES;
    }
}


- (void) getProfileImageRounded:(BOOL)isRounded border:(BOOL)isBorder {
    PFFile *profileImageFile = self.user[@"profileImage"];
    [profileImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *profileImage = [UIImage imageWithData:imageData];
            //Rounded settings. BOOL activates/deactivates.
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 15;
            self.profileImage.clipsToBounds = isRounded;
            //Border settings. BOOL activates/deactivates.
            if (isBorder) {
                [self.profileImage.layer setBorderColor:[[UIColor whiteColor] CGColor]];
                [self.profileImage.layer setBorderWidth:5.0];
            }
            //Assign image
            self.profileImage.image = profileImage;
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)gitHubButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user[@"gitHubURL"]]];
}

- (IBAction)facebookButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user[@"facebookURL"]]];
}

- (IBAction)twitterButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user[@"twitterURL"]]];
}

- (IBAction)linkedInButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user[@"linkedInURL"]]];
}
@end
