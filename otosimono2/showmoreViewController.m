//
//  showmoreViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/06/20.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "showmoreViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UIViewController+MJPopupViewController.h"

@interface showmoreViewController ()

@end

@implementation showmoreViewController
@synthesize showimage;

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
    // Do any additional setup after loading the view.
       //[self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];
    siv=showimage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)facebookButtonTapped:(id)sender {
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
}
@end
