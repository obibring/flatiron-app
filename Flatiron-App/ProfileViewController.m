//
//  ProfileViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "ProfileViewController.h"
#import "DataStore.h"
#import "Person.h"
#import "Program.h"
#import "Image.h"

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
    // Do any additional setup after loading the view.
    [self fillProfileInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fillProfileInformation {
    Person *person = self.person;
    [self setImageOfPerson:person rounded:YES border:YES];
    self.name.text = [self getFullNameOf:person capitalized:YES];
    self.program.text = person.program.name;
    self.before.text = person.before;
    self.after.text = person.after;
    self.fun.text = person.fun;
    
}

- (void) setSocialIcons:(Person *)person {
    UIImage *gitHubIcon = [UIImage imageNamed:@"github.png"];
    [self.gitHubButton setImage:gitHubIcon forState:UIControlStateNormal];
}


- (void) setImageOfPerson:(Person *)person rounded:(BOOL)isRounded border:(BOOL)isBorder {
    //Fetch image
    UIImage *profileImage = [UIImage imageWithData:person.image.image];
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

//Duplicate method from EveryoneTableViewController
- (NSString *) getFullNameOf:(Person *)person capitalized:(BOOL)isCapitalized {
    NSString *firstName = person.firstName;
    NSString *lastName = person.lastName;
    if (isCapitalized) {
        firstName = [firstName capitalizedString];
        lastName = [lastName capitalizedString];
    }
    NSString *fullName = [firstName stringByAppendingString:@" "];
    fullName = [fullName stringByAppendingString:lastName];
    return fullName;
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
