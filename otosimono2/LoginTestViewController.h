//
//  LoginTestViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/07/14.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginTestViewController : UIViewController<FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;


@end
