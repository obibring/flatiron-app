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
@property (weak, nonatomic) IBOutlet UIButton *photo;

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
    
    // Download user's photo and save it
    [self downloadUserPhoto];
    
    self.firstName.text = self.me[@"firstName"];
    self.lastName.text = self.me[@"lastName"];
    self.email.text = self.me[@"email"];
    self.program.text = self.me[@"program"];
    self.mobile.text = self.me[@"mobile"];
    self.gitHubHandle.text = self.me[@"gitHubHandle"];
    self.facebookHandle.text = self.me[@"facebookHandle"];
    self.twitterHandle.text = self.me[@"twitterHandle"];
    self.linkedInURL.text = self.me[@"linkedInURL"];
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.program.delegate = self;
    self.mobile.delegate = self;
    self.gitHubHandle.delegate = self;
    self.facebookHandle.delegate = self;
    self.twitterHandle.delegate = self;
    self.linkedInURL.delegate = self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.firstName)
        self.me[@"firstName"] = self.firstName.text;
    else if (textField == self.lastName)
        self.me[@"lastName"] = self.lastName.text;
    else if (textField == self.email)
        self.me[@"email"] = self.email.text;
    else if (textField == self.program)
        self.me[@"program"] = self.program.text;
    else if (textField == self.mobile)
        self.me[@"mobile"] = self.mobile.text;
    else if (textField == self.gitHubHandle)
        self.me[@"gitHubHandle"] = self.gitHubHandle.text;
    else if (textField == self.facebookHandle)
        self.me[@"facebookHandle"] = self.facebookHandle.text;
    else if (textField == self.twitterHandle)
        self.me[@"twitterHandle"] = self.twitterHandle.text;
    else if (textField == self.linkedInURL)
        self.me[@"linkedInURL"] = self.linkedInURL.text;
    
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
            self.photo.imageView.image = img;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
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
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    [self uploadImage:imageData];
}

-(void)uploadImage:(NSData *)imageData {
    PFUser *user = [PFUser currentUser];
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    //HUD creation here (see example for code)
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"profilePic"];
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            [userPhoto setObject:user forKey:@"user"];
            
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
