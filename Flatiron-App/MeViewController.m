//
//  MeViewController.m
//  Flatiron-App
//
//  Created by Charles Coutu-Nadeau on 10/27/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "MeViewController.h"
#import <Parse/Parse.h>
#define beforeFlatironDefaultText @"What were you doing before this?"
#define afterFlatironDefaultText @"Plans after?"

@interface MeViewController ()

@property (strong, nonatomic) PFUser *me;
@property (strong, nonatomic) PFUser *user;
//Contact info
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *cohortNumber;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UIButton *photo;
@property (weak, nonatomic) IBOutlet UITextView *beforeFlatiron;
@property (weak, nonatomic) IBOutlet UITextView *afterFlatiron;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isStudentSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *studentTypeSegment;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    [self resetSocialIcons];
    self.me = [PFUser currentUser];
    
    // Download user's photo and save it
    [self downloadUserPhoto];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.scrollView.contentSize = [UIScreen mainScreen].bounds.size;
    
    self.firstName.text = self.me[@"firstName"];
    self.lastName.text = self.me[@"lastName"];
    self.email.text = self.me.email;
    self.cohortNumber.text = self.me[@"cohortNumber"];
    self.mobile.text = self.me[@"mobile"];
    self.gitHubHandle.text = self.me[@"gitHubHandle"];
    self.facebookHandle.text = self.me[@"facebookHandle"];
    self.twitterHandle.text = self.me[@"twitterHandle"];
    self.linkedInURL.text = self.me[@"linkedInURL"];
    self.beforeFlatiron.text = self.me[@"beforeFlatiron"];
    self.afterFlatiron.text = self.me[@"afterFlatiron"];
    
    if ([self.me[@"isStudent"] isEqualToNumber:@1]) {
        self.isStudentSegment.selectedSegmentIndex = 0;
        if ([self.me[@"studentType"] isEqualToString:@"iOS"]) {
            self.studentTypeSegment.selectedSegmentIndex = 0;
        } else if ([self.me[@"studentType"] isEqualToString:@"Ruby"]) {
            self.studentTypeSegment.selectedSegmentIndex = 1;
        }
    } else if ([self.me[@"isStudent"] isEqualToNumber:@0]) {
        self.isStudentSegment.selectedSegmentIndex = 1;
        self.studentTypeSegment.enabled = NO;
    }
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.cohortNumber.delegate = self;
    self.mobile.delegate = self;
    self.gitHubHandle.delegate = self;
    self.facebookHandle.delegate = self;
    self.twitterHandle.delegate = self;
    self.linkedInURL.delegate = self;
    self.beforeFlatiron.delegate = self;
    self.afterFlatiron.delegate = self;
   
    if (!self.me[@"beforeFlatiron"]) {
        self.beforeFlatiron.text = beforeFlatironDefaultText;
        self.beforeFlatiron.textColor = [UIColor grayColor];
    }
    
    if (!self.me[@"afterFlatiron"]) {
        self.afterFlatiron.text = afterFlatironDefaultText;
        self.afterFlatiron.textColor = [UIColor grayColor];
    }
    
    [self activateSocialIcons];
}

- (IBAction)selectUserType:(id)sender {
    [self.view endEditing:YES];
    if (self.isStudentSegment.selectedSegmentIndex == 0) {
       // User is student
        self.me[@"isStudent"] = @1;
        self.studentTypeSegment.enabled = YES;
        self.studentTypeSegment.selectedSegmentIndex = -1;
        self.cohortNumber.enabled = YES;
    } else if (self.isStudentSegment.selectedSegmentIndex == 1) {
        self.me[@"isStudent"] = @0;
        self.studentTypeSegment.enabled = NO;
        self.studentTypeSegment.selectedSegmentIndex = -1;
        self.cohortNumber.enabled = NO;
        self.cohortNumber.text = @"";
        [self.me removeObjectForKey:@"studentType"];
        [self.me removeObjectForKey:@"cohortNumber"];
    }
    [self.me saveInBackground];
}

- (IBAction)selectStudentType:(id)sender {
    [self.view endEditing:YES];
    NSInteger iosIndex = 0;
    if (self.studentTypeSegment.selectedSegmentIndex == iosIndex) {
       self.me[@"studentType"] = @"iOS";
    } else if (self.studentTypeSegment.selectedSegmentIndex == iosIndex + 1){
       self.me[@"studentType"] = @"Ruby";
    } else {
        [self.me removeObjectForKey:@"studentType"];
    }
    [self.me saveInBackground];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    if (textView == self.beforeFlatiron && [textView.text isEqualToString: beforeFlatironDefaultText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    if (textView == self.afterFlatiron && [textView.text isEqualToString:afterFlatironDefaultText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    NSString *value = textView.text;
    
    if (value.length) {
        if (textView == self.beforeFlatiron) {
            if ([value length] > 0 && ![value isEqualToString:beforeFlatironDefaultText])
                self.me[@"beforeFlatiron"] = self.beforeFlatiron.text;
            else
                [self.me removeObjectForKey:@"beforeFlatiron"];
            
        } else if (textView == self.afterFlatiron) {
            if ([value length] > 0 && ![value isEqualToString:afterFlatironDefaultText])
                self.me[@"afterFlatiron"] = self.afterFlatiron.text;
            else
                [self.me removeObjectForKey:@"afterFlatiron"];
        }
        
        [self.me saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"USER SAVED SUCCESSFULLY");
            }
        }];
    } else {
        textView.textColor = [UIColor lightGrayColor];
        if (textView == self.beforeFlatiron) {
            textView.text = beforeFlatironDefaultText;
        } else if (textView == self.afterFlatiron) {
            textView.text = afterFlatironDefaultText;
        }
    }
}

- (void) resetSocialIcons {
    self.gitHubButton.enabled = NO;
    self.facebookButton.enabled = NO;
    self.twitterButton.enabled = NO;
    self.linkedInButton.enabled = NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *value = textField.text;
    
    if (textField == self.firstName) {
        if ([value length] > 0)
            self.me[@"firstName"] = self.firstName.text;
        else
            [self.me removeObjectForKey:@"firstName"];
    } else if (textField == self.lastName) {
        if ([value length] > 0)
            self.me[@"lastName"] = self.lastName.text;
        else
            [self.me removeObjectForKey:@"lastName"];
    } else if (textField == self.cohortNumber) {
        if ([value length] > 0) {
            NSInteger year = [value integerValue];
            if (year > -1) {
                NSString *displayNumber = [NSString stringWithFormat:@"%.3li",(long)year];
                self.me[@"cohortNumber"] = displayNumber;
                self.cohortNumber.text = displayNumber;
            }
        }
        else
            [self.me removeObjectForKey:@"cohortNumber"];
    } else if (textField == self.mobile) {
        if ([value length] > 0)
            self.me[@"mobile"] = self.mobile.text;
        else
            [self.me removeObjectForKey:@"email"];
    } else if (textField == self.gitHubHandle) {
        if ([value length] > 0)
            self.me[@"gitHubHandle"] = self.gitHubHandle.text;
        else
            [self.me removeObjectForKey:@"gitHubHandle"];
    } else if (textField == self.facebookHandle) {
        if ([value length] > 0)
            self.me[@"facebookHandle"] = self.facebookHandle.text;
        else
            [self.me removeObjectForKey:@"facebookHandle"];
    } else if (textField == self.twitterHandle) {
        if ([value length] > 0)
            self.me[@"twitterHandle"] = self.twitterHandle.text;
        else
            [self.me removeObjectForKey:@"twitterHandle"];
    } else if (textField == self.linkedInURL) {
        if ([value length] > 0)
            self.me[@"linkedInURL"] = self.linkedInURL.text;
        else
            [self.me removeObjectForKey:@"linkedInURL"];
    }
    
    [self activateSocialIcons];
    [self.me saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"USER SAVED SUCCESSFULLY");
        }
    }];
}

-(void)downloadUserPhoto {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            // There should be only one user photo, so grab it.
            PFObject *userPhotoObject = [objects lastObject];
            PFFile *theImage = [userPhotoObject objectForKey:@"profilePic"];
            NSData * imageData = [theImage getData];
            UIImage *img = [UIImage imageWithData:imageData];
            [self.photo setBackgroundImage:img forState:UIControlStateNormal];
            //Rounded settings. BOOL activates/deactivates.
            self.photo.layer.cornerRadius = self.photo.frame.size.width / 15;
            self.photo.clipsToBounds = YES;
            self.photo.imageView.image = img;
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) activateSocialIcons {
    if (self.me[@"gitHubHandle"]) {
        UIImage *gitHubIcon = [UIImage imageNamed:@"github.png"];
        [self.gitHubButton setImage:gitHubIcon forState:UIControlStateNormal];
        self.gitHubButton.enabled = YES;
    } else {
        [self.gitHubButton setBackgroundImage:[UIImage imageNamed:@"githubGray"] forState:UIControlStateNormal];
        self.gitHubButton.enabled = NO;
    }
    
    if (self.me[@"facebookHandle"]) {
        UIImage *facebookIcon = [UIImage imageNamed:@"facebook.png"];
        [self.facebookButton setImage:facebookIcon forState:UIControlStateNormal];
        self.facebookButton.enabled = YES;
    } else {
        [self.facebookButton setBackgroundImage:[UIImage imageNamed:@"facebookGray"] forState:UIControlStateNormal];
        self.facebookButton.enabled = NO;
    }
    
    if (self.me[@"twitterHandle"]) {
        UIImage *twitterIcon = [UIImage imageNamed:@"twitter.png"];
        [self.twitterButton setImage:twitterIcon forState:UIControlStateNormal];
        self.twitterButton.enabled = YES;
    } else {
        [self.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitterGray"] forState:UIControlStateNormal];
        self.twitterButton.enabled = NO;
    }
    
    if (self.me[@"linkedInURL"]) {
        UIImage *linkedInIcon = [UIImage imageNamed:@"linkedin.png"];
        [self.linkedInButton setImage:linkedInIcon forState:UIControlStateNormal];
        self.linkedInButton.enabled = YES;
    } else {
        [self.linkedInButton setBackgroundImage:[UIImage imageNamed:@"linkedinGray"] forState:UIControlStateNormal];
        self.linkedInButton.enabled = NO;
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    //Contact info
    if (textField == self.firstName) {
        self.me[@"firstName"] = self.firstName.text;
    } else if (textField == self.lastName) {
        self.me[@"lastName"] = self.lastName.text;
    } else if (textField == self.cohortNumber) {
        self.me[@"cohortNumber"] = self.cohortNumber.text;
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

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *profileImage = info[@"UIImagePickerControllerOriginalImage"];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    // Resize the image
    UIGraphicsBeginImageContext(CGSizeMake(120, 120));
    [profileImage drawInRect:CGRectMake(0, 0, 120, 120)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    [self.photo setBackgroundImage:smallImage forState:UIControlStateNormal];
    
    UIGraphicsEndImageContext();
    
    // Upload the image to parse
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 1.00f);
    [self uploadImage:imageData];
}

-(void)uploadImage:(NSData *)imageData {
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"profilePic"];
            self.me[@"profileImage"] = imageFile;
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            [userPhoto setObject:self.me forKey:@"user"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
//                    [self refresh:nil];
                    NSLog(@"SAVED USER PHOTO");
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
//            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
//        HUD.progress = (float)percentDone/100;
    }];
}



- (IBAction)photoButtonTap:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
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
