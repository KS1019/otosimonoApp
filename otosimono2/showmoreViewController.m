//
//  showmoreViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/06/20.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "showmoreViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>


@interface showmoreViewController ()

@end

@implementation showmoreViewController

@synthesize showimage;
@synthesize CommentString;
@synthesize LatitudetoSMVC;
@synthesize LongitudetoSMVC;
@synthesize ObjectId;

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
    NSLog(@"ObjectId---->>>%@",ObjectId);
    
    [siv setImage:self.showimage];
    tv.text=CommentString;
    tv.editable = NO;
    NSLog(@"~~~~~~~~~~~~~~~~~~~ %@",CommentString);
    NSLog(@"showimage is %@", self.showimage);
    //siv=showimage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if ([segue.identifier isEqualToString:@"ToMap"]) {
         ShowMapViewController *SMVC = segue.destinationViewController;
         SMVC.LatitudeNum2 = LatitudetoSMVC;
         SMVC.LongitudeNum2 = LongitudetoSMVC;
     }
}

-(IBAction)HOUKOKU{
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:@"通報しますか？"
     message:@""
     delegate:self
     cancelButtonTitle:@"キャンセル"
     otherButtonTitles:@"OK", nil
     ];
    [alert show];
    

}
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    PFObject *Houkoku = [PFObject objectWithClassName:@"HOUKOKU"];

    switch (buttonIndex) {
        case 1:
            Houkoku[@"POST_ID"] = ObjectId;
            [Houkoku saveInBackground];
                break;
     
    }
    
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
