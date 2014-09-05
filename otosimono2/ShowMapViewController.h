//
//  ShowMapViewController.h
//  otosimono2
//
//  Created by Kotaro Suto on 2014/08/31.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ShowMapViewController : UIViewController{
    NSNumber *LatitudeNum2;
    NSNumber *LongitudeNum2;
    
    
    MKMapView *mv;
    
    MKPointAnnotation* pin;

}
@property(nonatomic)NSNumber *LatitudeNum2;
@property(nonatomic)NSNumber *LongitudeNum2;
@end
