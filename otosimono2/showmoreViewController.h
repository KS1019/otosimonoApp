//
//  showmoreViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/06/20.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface showmoreViewController : UIViewController<UITextViewDelegate>{
        
    IBOutlet UIImageView *siv;
    IBOutlet UITextView *tv;
    
    NSString *CommentString;
    
}
@property(nonatomic)NSString *CommentString;



@property(nonatomic)UIImage *showimage;
@end
