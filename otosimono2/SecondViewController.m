//
//  SecondViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "SecondViewController.h"
#import <ImageIO/ImageIO.h>

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
    //[testObject saveInBackground];
    //UIImage *image= [UIImage imageNamed:@"Sendimage"];
    NSData *imageData = UIImagePNGRepresentation(Sendimage);
    
    NSLog(@"Hey");
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    [imageFile save];
    NSLog(@"Hi");
    //testObject[@"imageFile"] = imageFile;
    [testObject setObject:imageFile forKey:@"image"];
    [testObject saveInBackground];
    
    
    [LostPhoto setImage:[UIImage imageNamed:@"NOIMAGE.png"]];
    Sendimage=[UIImage imageNamed:@"NOIMAGE.png"];
    Comment.text=@"";
    NSLog(@"っこここここk");
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
    
    NSLog(@"っふうううう");
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

@end
