//
//  showmoreViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/06/20.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIViewController+MJPopupViewController.h"

@interface showmoreViewController : UIViewController{
    UIImage *showimage;
        
    IBOutlet UIImageView *siv;
    
}
@property(nonatomic)UIImage *showimage;
@end
