//
//  loginViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/06/27.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "loginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface loginViewController ()

@end

@implementation loginViewController

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
    [super viewDidLoad ];
    self.loginView.delegate = self;
    // Do any additional setup after loading the view.
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    /*FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
     NSLog(@"====1");
    self.profilePictureView.profileID = [user objectID];
    NSLog(@"====2");
    self.nameLabel.text = user.name;
    //self.nameLabel.text = [user objectForKey:@"name"];
     NSLog(@"====3");
//    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!%@!!!!!!!!!!!!!!!!!!!!",profilePictureView.profileID);
//    NSLog(@"$$$$$$$$$$$$$$%@$$$$$$$$",nameLabel.text);
//    NSLog(@"=======================================================");
}



- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
   
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
}

/*- (IBAction)facebookButtonTapped:(id)sender {
    // パーミッション
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    // Facebook アカウントを使ってログイン
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Facebook ログインをユーザーがキャンセル");
            } else {
                NSLog(@"Facebook ログイン中にエラーが発生: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"Facebook サインアップ & ログイン完了!");
        } else {
            NSLog(@"Facebook ログイン完了!");
        }
    }];
}*/

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
