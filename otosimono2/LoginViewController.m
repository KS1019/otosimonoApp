//
//  LoginViewController.m
//  LostChecker
//
//  Created by Kotaro Suto on 2015/10/30.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            // Callback for login success or failure. The TWTRSession
            // is also available on the [Twitter sharedInstance]
            // singleton.
            //
            // Here we pop an alert just to give an example of how
            // to read Twitter user info out of a TWTRSession.
            //
            // TODO: Remove alert and use the TWTRSession's userID
            // with your app's user model
            NSString *message = [NSString stringWithFormat:@"@%@ logged in! (%@)",
                                 [session userName], [session userID]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in!"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            //NSUserDefaults *
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"Login error: %@", [error localizedDescription]);
        }
    }];
    
    // TODO: Change where the log in button is positioned in your view
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];

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
