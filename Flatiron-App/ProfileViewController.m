//
//  ProfileViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "ProfileViewController.h"
#import <PFUser.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *program;
@property (weak, nonatomic) IBOutlet UILabel *before;
@property (weak, nonatomic) IBOutlet UILabel *after;
@property (weak, nonatomic) IBOutlet UILabel *fun;
@property (weak, nonatomic) IBOutlet UIButton *gitHubButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillProfileInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fillProfileInformation {
    //[self setImageOfPerson:person rounded:YES border:YES];
    self.name.text = [self.title capitalizedString]; //The title of the view was set to the full name;
    //self.program.text = self.user[@"program"];
    self.before.text = self.user[@"beforeBio"];
    self.after.text = self.user[@"afterBio"];
    self.fun.text = self.user[@"funFact"];
    
}

//- (void) setSocialIcons:(Person *)person {
//    UIImage *gitHubIcon = [UIImage imageNamed:@"github.png"];
//    [self.gitHubButton setImage:gitHubIcon forState:UIControlStateNormal];
//}
//
//
//- (void) setImageOfPerson:(Person *)person rounded:(BOOL)isRounded border:(BOOL)isBorder {
//    //Fetch image
//    UIImage *profileImage = [UIImage imageWithData:person.image.image];
//    //Rounded settings. BOOL activates/deactivates.
//    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 15;
//    self.profileImage.clipsToBounds = isRounded;
//    //Border settings. BOOL activates/deactivates.
//    if (isBorder) {
//        [self.profileImage.layer setBorderColor:[[UIColor whiteColor] CGColor]];
//        [self.profileImage.layer setBorderWidth:5.0];
//    }
//    //Assign image
//    self.profileImage.image = profileImage;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
