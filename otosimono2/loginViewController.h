//
//  loginViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/06/27.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
@interface loginViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;


@end
