//
//  SecondViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "SecondViewController.h"
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize LatitudeDouble2;
@synthesize LongitudeDouble2;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //88888888888888888
    NSLog(@"Second VC viewDidLoad");
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
     */
    
	// Do any additional setup after loading the view, typically from a nib.
    
    WhereSeg.selectedSegmentIndex=3;
    colorSegNum =[NSNumber numberWithInt:3];
    WhereSeg.momentary = NO;
    [WhereSeg addTarget:self action:@selector(hoge)forControlEvents:UIControlEventValueChanged];
    
    Comment.delegate = self;
    Comment.placeholder = @"コメントを入力";
    Comment.keyboardType = UIKeyboardTypeDefault;
    Comment.borderStyle = UITextBorderStyleLine;
    i=1;
      //[LostPhoto setImage:[UIImage imageNamed:@"NOIMAGE.png"]];
    Sendimage=[UIImage imageNamed:@"NOIMAGE.png"];
    Showimage = [UIImage imageNamed:@"MOC-03.png"];
    [PhotoSelect setBackgroundImage:Showimage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)test{
   PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
   query.skip = 0;
    query.limit = 10; // limit to at most 10 results
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        for (PFObject *testobject in objects) {
        // Do something with the returned PFObject in the gameScore variable.
        //NSLog(@"%@", testobject);
        NSString *teststr =[testobject objectForKey:@"foo"];
        NSLog(@"%@",teststr);
        
        NSData *testimage=[[testobject objectForKey:@"image"]getData];
        UIImage *testimage2=[[UIImage alloc]initWithData:testimage];
        [testimageview setImage:testimage2];
        
        //NSString *testooooo=[testobject objectForKey:@"objectId"];
        //NSLog(@"objectId->%@",testooooo);
        }
    }];
    /*
    [query getObjectInBackgroundWithId:@"UsGDufbBdR" block:^(PFObject *testobject, NSError *error) {
        
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", testobject);
        teststr =[testobject objectForKey:@"foo"];
        NSLog(@"%@",teststr);
        
        NSData *testimage=[[testobject objectForKey:@"image"]getData];
        UIImage *testimage2=[[UIImage alloc]initWithData:testimage];
        [testimageview setImage:testimage2];
        
        NSString *testooooo=[testobject objectForKey:@"objectId"];
        NSLog(@"objectId->%@",testooooo);
    }];
   */ 
}
-(IBAction)Photo{
    UIActionSheet *as = [[UIActionSheet alloc] init];
    as.delegate = self;
    as.title = @"選択してください。";
    [as addButtonWithTitle:@"カメラから"];
    [as addButtonWithTitle:@"アルバムから"];
    [as addButtonWithTitle:@"キャンセル"];
    as.cancelButtonIndex = 2;
    as.destructiveButtonIndex = 0;
    [as showInView:self.view];
   }

-(IBAction)SEND{
        [SVProgressHUD show];
    [self performSelector:@selector(sv) withObject:nil afterDelay:2.0];
    
    NSLog(@"############ %f ###############",LatitudeDouble2);
    NSLog(@"############ %f ###############",LongitudeDouble2);

}

-(void)sv{
    NSLog(@"uuuuuuuuuuuuuuuuu");
    //ACLの設定をする。
    //
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] =Comment.text;
    
    testObject[@"SegIndex"] = colorSegNum;
    double Latidouble = [ud doubleForKey:@"latitude"];
    NSNumber *LatitudeNumber = [NSNumber numberWithDouble:Latidouble];
    NSLog(@"77777777777777777777777777------->>>>>%f",Latidouble);
    testObject[@"LatitudeNum"] =LatitudeNumber;
    //NSNumber *LongitudeNumber = [NSNumber numberWithDouble:LongitudeDouble2];
    double Longdouble = [ud doubleForKey:@"longitude"];
    NSNumber *LongitudeNumber = [NSNumber numberWithDouble:Longdouble];
    NSLog(@"888888888888888888888%f",Longdouble);
    testObject[@"LongitudeNum"] = LongitudeNumber;
    //[testObject saveInBackground];
    //UIImage *image= [UIImage imageNamed:@"Sendimage"];
    //NSData *imageData = UIImagePNGRepresentation(Sendimage);
    NSData *imageData = UIImageJPEGRepresentation(Sendimage,0.8f);
    PFFile *imageFile = [PFFile fileWithName:@"image.jpg" data:imageData];
    //[imageFile save];
    NSLog(@"Hi");
    //testObject[@"imageFile"] = imageFile;
    [testObject setObject:imageFile forKey:@"image"];
    [testObject saveInBackground];
    //[testObject save];
    
    //[LostPhoto setImage:[UIImage imageNamed:@"NOIMAGE.png"]];
    [PhotoSelect setBackgroundImage:Showimage forState:UIControlStateNormal];

    
    //Sendimage=[UIImage imageNamed:@"NOIMAGE.png"];
    Comment.text=@"";
    
    
    
    /* PFObject *jobApplication = [PFObject objectWithClassName:@"JobApplication"];
     jobApplication[@"applicantName"] = @"Joe Smith";
     jobApplication[@"applicantResumeFile"] = imageFile;
     [jobApplication saveInBackground];
     */
    [SVProgressHUD dismiss];
}
-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            // １番目のボタンが押されたときの処理を記述する
            if([UIImagePickerController
                isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *ipc =
                [[UIImagePickerController alloc] init];  // 生成
                ipc.delegate = self;  // デリゲートを自分自身に設定
                ipc.sourceType =
                UIImagePickerControllerSourceTypeCamera;  // 画像の取得先をカメラに設定
                ipc.allowsEditing = YES;  // 画像取得後編集する
                [self presentViewController:ipc animated:YES completion:nil];
                // モーダルビューとしてカメラ画面を呼び出す
            }
            break;
        case 1:
            // ２番目のボタンが押されたときの処理を記述する
            NSLog(@"uuuuuuuuuuuuu");
            UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
            [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [ipc setDelegate:self];
            [ipc setAllowsEditing:YES];
            [self presentViewController:ipc animated:YES completion:nil];
            break;
            }
    
}
-(void)imagePickerController:(UIImagePickerController*)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"yeeeeeehhhhshs");
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    NSURL* imageurl = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSDictionary *metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
    
    if (imageurl) {
        // ライブラリ内の写真を選択
        NSLog(@"9999999999999");
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
            ALAssetRepresentation *representation;
            representation = [asset defaultRepresentation];
            NSDictionary *repMetadata = [representation metadata];
            NSLog(@"metadata:%@",repMetadata);
            NSDictionary *GPSData = [repMetadata objectForKey:@"{GPS}"];
            LatitudeNum = [GPSData objectForKey:@"Latitude"];
            LongitudeNum = [GPSData objectForKey:@"Longitude"];
            NSLog(@"Latitude is %@",LatitudeNum);
            NSLog(@"Longitude is %@",LongitudeNum);
            LatitudeDouble2 = [LatitudeNum doubleValue];
            LongitudeDouble2 = [LongitudeNum doubleValue];
            
        };
        
        [library assetForURL:imageurl
                 resultBlock:resultBlock
                failureBlock:^(NSError *error){ NSLog(@"error:%@",error); }];
    } else if (metadata) {
        // カメラで撮影
        NSLog(@"metadata:%@", metadata);
    } else {
        NSLog(@"error");
    }

    //[LostPhoto setImage:image];
    [PhotoSelect setBackgroundImage:image forState:UIControlStateNormal];
    Sendimage=image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(BOOL)textViewShouldBeginEditing:(UITextView*)textView{
    if (i==1) {
       Comment.text=@"";
        i=2;
    }
    

    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"jcncdndnksd");
    // ここにtextデータの処理
    comstr=Comment.text;
    NSLog(@"タッチビギンメソッドー＞%@",comstr);

    // キーボードを閉じる
    [self->Comment resignFirstResponder];
}

-(void)hoge{
    NSLog(@"seg");
    switch (WhereSeg.selectedSegmentIndex) {
        case 0:
            
            colorSegNum =[NSNumber numberWithInt:0];
            break;
            
        case 1:
            colorSegNum =[NSNumber numberWithInt:1];
            break;
            
        case 2:
            colorSegNum =[NSNumber numberWithInt:2];
            break;
            
        case 3:
            colorSegNum =[NSNumber numberWithInt:3];
            break;
    }
}
-(IBAction)MapTest{
    UIAlertView*alert = [[UIAlertView alloc]init];
    alert.title = @"位置情報";
    alert.message = @"どのように取得しますか？";
    alert.delegate = self;
    [alert addButtonWithTitle:@"写真情報から"];
    [alert addButtonWithTitle:@"マップにピンをうつ"];
    [alert addButtonWithTitle:@"現在位置情報から"];
    [alert addButtonWithTitle:@"キャンセル"];
    [alert show];
                       
}

-(void)alertView:(UIAlertView*)alert
clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"-(void)alertView is faster");
    switch (buttonIndex) {
        case 0:{
            NSLog(@"case is 0");
            //１番目のボタンが押されたときの処理を記述する
            AlertNum2 = 0;
            [self performSelector:@selector(Segue) withObject:nil afterDelay:1.0];
                        break;
        }
        case 1:{
            NSLog(@"case is 1");
            //２番目のボタンが押されたときの処理を記述する
            AlertNum2 = 1;
            [self performSelector:@selector(Segue) withObject:nil afterDelay:1.0];
                       break;
        }
        case 2:{
            NSLog(@"case is 2");
            //３番目
            AlertNum2 = 2;
            [self performSelector:@selector(Segue) withObject:nil afterDelay:3.0];
            break;
        }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapViewController *MVVC = segue.destinationViewController;
    NSLog(@"%d",AlertNum2);
    NSLog(@"prepareForSegue is faster");
        if ([segue.identifier isEqualToString:@"MapSegue"]) {
            NSLog(@"OK");
            if (AlertNum2 == 0) {
                NSLog(@"AlertNum2 = 0");
        MVVC.LatitudeNum2 = LatitudeNum;
        MVVC.LongitudeNum2 = LongitudeNum;
        MVVC.AlertNum = 0;
        }else if (AlertNum2 == 1){
            NSLog(@"AlertNum2 = 1");
            MVVC.LatitudeNum2 = 0;
            MVVC.LongitudeNum2 = 0;
            MVVC.AlertNum = 1;
        }else if(AlertNum2 == 2){
            NSLog(@"AlertNum2 = 2");
            MVVC.LatitudeNum2 = 0;
            MVVC.LongitudeNum2 = 0;
            MVVC.AlertNum = 2;
        }
    }
    
}

-(void)Segue{
   /* SecondViewController *SVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Map View Controller"];
    [self presentViewController:SVC animated:YES completion:nil];
*/
    [self performSegueWithIdentifier:@"MapSegue" sender:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [Comment resignFirstResponder];
    return YES;
}

@end
