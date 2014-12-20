//
//  ShowMapViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/08/31.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "ShowMapViewController.h"

@interface ShowMapViewController ()

@end

@implementation ShowMapViewController
@synthesize LatitudeNum2;
@synthesize LongitudeNum2;

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
//    double LatitudeDouble = [LatitudeNum2 doubleValue];
//    double LongitudeDouble = [LongitudeNum2 doubleValue];
//    NSLog(@"%f,%f",LatitudeDouble,LongitudeDouble);
    NSUserDefaults *defo = [NSUserDefaults standardUserDefaults];
    double laladou = [defo doubleForKey:@"lalalala"];
    CLLocationDegrees LatitudeDeg = laladou;
    NSLog(@"laladou---->>>>%f",laladou);
    double lolodou = [defo doubleForKey:@"lolololo"];
    CLLocationDegrees LongitudeDeg = lolodou;
    CLLocationCoordinate2D co;
    co.latitude = LatitudeDeg; // 経度
    co.longitude = LongitudeDeg; // 緯度
    
    // 生成
    mv = [[MKMapView alloc] init];
    mv.delegate = self;
    mv.frame = CGRectMake(0, 0, 320, 524);
    mv.mapType = MKMapTypeHybrid;
    //    mv.frame = 	[[UIScreen mainScreen]applicationFrame];;
    float labelh = self.view.frame.size.height;
    NSLog(@"Height of mv is %f",labelh);
    [mv setCenterCoordinate:co animated:NO];
    
    // 縮尺を指定
    MKCoordinateRegion cr = mv.region;
    cr.center = co;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mv setRegion:cr animated:NO];
    
    
    // addSubview
    [self.view addSubview:mv];
    
    pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = co;
    [mv addAnnotation:pin];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(MKAnnotationView*)mapView:(MKMapView*)mapView
          viewForAnnotation:(id)annotation{
    
    static NSString *PinIdentifier = @"Pin";
    MKPinAnnotationView *pinnn =
    (MKPinAnnotationView*)
    [mv dequeueReusableAnnotationViewWithIdentifier:PinIdentifier];
    if(pinnn == nil){
        pinnn = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:PinIdentifier];
        pinnn.animatesDrop = YES;  // アニメーションをする
        pinnn.pinColor=MKPinAnnotationColorPurple;  // ピンの色を紫にする
        pinnn.canShowCallout = YES;  // ピンタップ時にコールアウトを表示する
    }
    return pinnn;
    
}

-(IBAction)Back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
