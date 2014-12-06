//
//  SecondViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "SVProgressHUD.h"
#import "MapViewController.h"


@interface SecondViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate,MKMapViewDelegate>{
    IBOutlet UIImageView *LostPhoto;
    //IBOutlet UITextView *Comment;
    IBOutlet UITextField *Comment;
    IBOutlet UIImageView  *testimageview;
    IBOutlet UISegmentedControl *WhereSeg;
    IBOutlet UIButton *PhotoSelect;

    
    UIImage *Sendimage;
    UIImage *Showimage;
    
    
    NSString *comstr;
    
    NSArray *phrase;
    
    NSNumber *colorSegNum;
    NSNumber *LatitudeNum;
    NSNumber *LongitudeNum;

    //CLLocationManager *PhotoLoc;
    
    //MKMapView *mv;
    
    int i;
    int AlertNum2;
    
    double LatitudeDouble2;
    double LongitudeDouble2;

    //int Seg;
    
    MKPointAnnotation* pin;
}
-(IBAction)Photo;
-(IBAction)SEND;
-(IBAction)test;

@property(nonatomic)double LatitudeDouble2;
@property(nonatomic)double LongitudeDouble2;
@end
