//
//  FirstViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "showmoreViewController.h"
#import "showmoreViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *table;
    IBOutlet UIImageView *lostPhotoView;
    IBOutlet UILabel *label;
    
    int segue;
    int cellcolor;
    
    UIImage *img;

    NSString * testr;
    NSString * str;
    NSString * comstr;
    NSString * boolString;
    
    NSNumber *CellColorNum;
    
    NSMutableArray *textarray;
    NSMutableArray *imagearray;
    NSMutableArray *CellColorArray;
    NSMutableArray *LatitudeArray;
    NSMutableArray *LongitudeArray;
    NSMutableArray *IdArray;
    
    UIImage *passImage;
    
    UIColor * backGroundColor;
    
    PFFile *testimage;
    
    double ShowLatitude;
    double ShowLongitude;
}
-(IBAction)refresh;
@end
