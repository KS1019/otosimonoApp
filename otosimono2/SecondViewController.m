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

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
     */
    
	// Do any additional setup after loading the view, typically from a nib.
    
    WhereSeg.selectedSegmentIndex=3;
    WhereSeg.momentary = NO;
    [WhereSeg addTarget:self action:@selector(hoge)forControlEvents:UIControlEventValueChanged];
    
    Comment.delegate = self;
    Comment.text=@"(例)三鷹駅北口で拾いました。\n(例)三鷹駅の北口の交番に届けました。";
    Comment.keyboardType=UIKeyboardTypeDefault;
    i=1;
      [LostPhoto setImage:[UIImage imageNamed:@"NOIMAGE.png"]];
    Sendimage=[UIImage imageNamed:@"NOIMAGE.png"];
    

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
}

-(void)sv{

    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] =Comment.text;
    
    testObject[@"SegIndex"] = colorSegNum;
    //[testObject saveInBackground];
    //UIImage *image= [UIImage imageNamed:@"Sendimage"];
    NSData *imageData = UIImagePNGRepresentation(Sendimage);
    
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    [imageFile save];
    NSLog(@"Hi");
    //testObject[@"imageFile"] = imageFile;
    [testObject setObject:imageFile forKey:@"image"];
    [testObject saveInBackground];
    
    
    [LostPhoto setImage:[UIImage imageNamed:@"NOIMAGE.png"]];
    Sendimage=[UIImage imageNamed:@"NOIMAGE.png"];
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
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
            ALAssetRepresentation *representation;
            representation = [asset defaultRepresentation];
            NSDictionary *repMetadata = [representation metadata];
            NSLog(@"metadata:%@",repMetadata);
            NSString *str = [[NSString alloc]init];
            str = [repMetadata objectForKey:@"{GPS}"];
            NSLog(@"%@",str);
            //NSString *str2 = [[NSString alloc]init];
            //str2 = [str stringByReplacingOccurrencesOfString:@";" withString:@","];
            //NSArray *exifArray = str2;
            //int cnt = [exifArray count];
            //NSLog(@"%@", cnt);
            //NSRange range = [str rangeOfString:str];
            //int AllLenth = range.length;
            
           /*
           // 分割した結果を保持する変数
            NSMutableDictionary *LongitudeandlatitudeDic = [[NSMutableDictionary alloc] init];
            
            // 分割対象の文字列
            //NSString *params = @"name=Bob&age=26&sex=man";
            
            // 「」で分割する
            NSArray *phrase = [str componentsSeparatedByString:@" "];
            
            // 続いて、一つずつ「=」で分割する
            for (int i = 0; i < phrase.count; i++) {
                NSString *param = [phrase objectAtIndex:i];
                NSArray *items = [param componentsSeparatedByString:@"="];
                NSString *key = [items objectAtIndex:0];
                NSString *val = [items objectAtIndex:1];
                [LongitudeandlatitudeDic setValue:val forKey:key];
            }
            NSString *Longitude = [LongitudeandlatitudeDic objectForKey:Longitude ];
            NSString *Latitude = [LongitudeandlatitudeDic objectForKey:Latitude ];
            
            NSLog(@"%@",Longitude);
            NSLog(@"%@",Latitude);
           */
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

//    CGImageSourceRef source =image.image;
//    NSData *photodata=image;
//    CGImageSourceRef cgImage = CGImageSourceCreateWithData((__bridge CFDataRef)photodata, nil);
//    NSDictionary *metadata = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(cgImage, 0, nil);
//    if (metadata) {
//        NSLog(@"%@", [metadata description]);
//    } else {
//        NSLog(@"no metadata");
//    }

    [LostPhoto setImage:image];
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

@end
