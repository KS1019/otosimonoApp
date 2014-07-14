//
//  LoginTestViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/07/14.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "LoginTestViewController.h"

@interface LoginTestViewController ()

@end

@implementation LoginTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginView.delegate = self;
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    self.profilePictureView.profileID = [user objectID];
    self.nameLabel.text = user.name;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    self.statusLabel.text = @"You're logged in as";
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.statusLabel.text = @"You're not logged in!";
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
