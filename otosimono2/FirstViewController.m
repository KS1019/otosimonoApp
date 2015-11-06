//
//  FirstViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "FirstViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "LoginViewController.h"
#import "CustomCell1.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    table.delegate = self;
    table.dataSource = self;
    backGroundColor = [UIColor new];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self refresh];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *bid = [bundle bundleIdentifier];
    NSLog(@"---------->>>>>%@",bid);
    
    
    // カスタムセルを使用
    UINib *nib = [UINib nibWithNibName:@"CustomCell1" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"Cell"];

    
    //ログインしていなかったら
    /*
     if ([self isLogin]) {
        LoginViewController * loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)refresh{
    NSLog(@"111111!!!!1");
    
    textarray=[[NSMutableArray alloc] init];
    imagearray=[[NSMutableArray alloc]init];
    CellColorArray = [[NSMutableArray alloc]init];
    LatitudeArray = [[NSMutableArray alloc]init];
    LongitudeArray = [[NSMutableArray alloc]init];
    IdArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    //query.skip = 0;
    //query.limit = 10; // limit to at most 10 results
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *testobject in objects) {
            // Do something with the returned PFObject in the gameScore variable.
            //NSLog(@"%@", testobject);
            NSLog(@"%@",str);
            str = [testobject objectForKey:@"foo"];
            
            CellColorNum = [testobject objectForKey:@"SegIndex"];
            [CellColorArray addObject:CellColorNum];
            
            
            NSLog(@"str->%@",str);
            [textarray addObject:str];
            NSLog(@"textarray->%@",textarray);
            //NSLog(@"%@",teststr);
            
            testimage = [testobject objectForKey:@"image"];
            [imagearray addObject:testimage];
          
            
            NSString *IdString = testobject.objectId;
            [IdArray addObject:IdString];
            NSLog(@"id---->>>%@",IdString);
            
            NSNumber *LatitudeNum = [testobject objectForKey:@"LatitudeNum"];
            NSNumber *LongitudeNum  = [testobject objectForKey:@"LongitudeNum"];
            [LatitudeArray addObject:LatitudeNum];
            [LongitudeArray addObject:LongitudeNum];
            
            
            
                      // ShowLatitude = [syy doubleValue];
            NSLog(@"ShowLatitude is %f",ShowLatitude);
            
            
            NSLog(@"========== imageArray is %@", imagearray);
            NSLog(@"%@",textarray[0]);
            
            textarray = [[textarray reverseObjectEnumerator]allObjects];
            imagearray = [[imagearray reverseObjectEnumerator]allObjects];
            CellColorArray = [[CellColorArray reverseObjectEnumerator]allObjects];
            LatitudeArray = [[LatitudeArray reverseObjectEnumerator]allObjects];
            LongitudeArray = [[LongitudeArray reverseObjectEnumerator]allObjects];
            IdArray = [[IdArray reverseObjectEnumerator]allObjects];
            
            [table reloadData];
        }
    }];
    
    
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //セルタップ時に呼び出される。
    NSLog(@"didSelect");
    segue++;
    //[self performSegueWithIdentifier:@"Segue" sender:[imagearray objectAtIndex:indexPath.row]];
    
    [self performSegueWithIdentifier:@"Segue" sender:indexPath];
    
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaul2 = [NSMutableDictionary dictionary];
    NSNumber *lalanumm = [LatitudeArray objectAtIndex:indexPath.row];
    [defaul2 setObject:lalanumm forKey:@"lalalala"];
    NSNumber *lolonumm = [LongitudeArray objectAtIndex:indexPath.row];
    [defaul2 setObject:lolonumm forKey:@"lolololo"];
    [defau registerDefaults:defaul2];
    [defau synchronize];
    
      /*-(void)prepareForSegue:(UIStoryboardSegue *)sg sender:(id)sender{
    if ([sg.identifier isEqualToString:@"Segue"])の後に呼ばれる*/
}


-(void)prepareForSegue:(UIStoryboardSegue *)sg sender:(id)sender {
    if ([sg.identifier isEqualToString:@"Segue"]) {
        /*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPathより先に呼ばれる。*/
        
        
        
        showmoreViewController *resultVC = sg.destinationViewController;
        //UIImage *image = [UIImage imageWithData:[sender getData]];
        NSIndexPath* indexPath = (NSIndexPath*)sender;
       // NSLog(@"length of ImageArray %d",[imagearray count]);
        
        UIImage *image = [UIImage imageWithData:[[imagearray objectAtIndex: indexPath.row] getData]];
        int cellColor;
        cellColor = [[CellColorArray objectAtIndex:indexPath.row]intValue];
        NSLog(@"cellColor : %d when prepare For Segue",cellColor);
        switch (cellColor) {
            case 0:
                //ブルー
                 resultVC.BackGroundColor = [UIColor colorWithRed:0.74 green:0.96 blue:0.96 alpha:1.0];
                break;
            case 1:
                //グリーン
                resultVC.BackGroundColor = [UIColor colorWithRed:0.71 green:0.92 blue:0.79 alpha:1.0];
                break;
            case 2:
                //イエロー
                resultVC.BackGroundColor = [UIColor colorWithRed:0.85 green:0.95 blue:0.71 alpha:1.0];
                break;
            case 3:
                //レッド
                resultVC.BackGroundColor = [UIColor colorWithRed:1.00 green:0.72 blue:0.76 alpha:1.0];
                break;
        }
        
        

       // comstr = [textarray objectAtIndex:indexPath.row];
        resultVC.showimage  = image;
        resultVC.CommentString = [textarray objectAtIndex:indexPath.row];
        resultVC.ObjectId = [IdArray objectAtIndex:indexPath.row];
        //resultVC.BackGroundColor = backGroundColor;
        NSLog(@"resultVC.showimage is %@", resultVC.showimage);
        NSLog(@"resultVC.CommentString is %@",resultVC.CommentString);
        NSLog(@"\nBackGroundColor : %@\ncellColor : %d",resultVC.BackGroundColor,cellColor);
        if ([sg.identifier isEqualToString:@"Segue"]) {
            /*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPathより先に呼ばれる。*/
            showmoreViewController *SMVC = sg.destinationViewController;
            NSIndexPath *indexPath = (NSIndexPath*)sender;
            SMVC.LatitudetoSMVC = [LatitudeArray objectAtIndex:indexPath.row];
            SMVC.LongitudetoSMVC = [LongitudeArray objectAtIndex:indexPath.row];
            NSLog(@"SMVC.LatitudeNum2 is %@",SMVC.LatitudetoSMVC);
        }
    }
}






#pragma mark- テーブルビュー
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [textarray count];
    //return 3;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier=@"Cell";
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    CustomCell1 * cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [[cell.commentLabel layer] setCornerRadius:5.0];
    [cell.commentLabel setClipsToBounds:YES];
    
        if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //cell.textLabel.text=[textarray objectAtIndex:indexPath.row];
    
    cell.commentLabel.text = [textarray objectAtIndex:indexPath.row];
    //cell.imageView.backgroundColor = [UIColor grayColor];
//    PFFile *pfImage = [imagearray objectAtIndex:indexPath.row];
//    [pfImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//        if (!error) {
//            cell.imageView.image = [UIImage imageWithData:imageData];
//            [table reloadData];
//        }
//    }];
    


    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"CellColor Method");
    
    int cellcolor;
    cellcolor = [[CellColorArray objectAtIndex:indexPath.row]intValue];
    switch (cellcolor) {
        case 0:
            //ブルー
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.74 green:0.96 blue:0.96 alpha:1.0];
            break;
        case 1:
            //グリーン
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.71 green:0.92 blue:0.79 alpha:1.0];
            break;
        case 2:
            //イエロー
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.85 green:0.95 blue:0.71 alpha:1.0];
            break;
        case 3:
            //レッド
            cell.contentView.backgroundColor = [UIColor colorWithRed:1.00 green:0.72 blue:0.76 alpha:1.0];
            break;
    }
    NSLog(@"\ncellcolor : %d \n backgroundColor : %@",cellcolor,cell.contentView.backgroundColor);
  }


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomCell1 rowHeight];
}

#pragma mark- isLogin

-(BOOL)isLogin
{
    boolString = [NSString new];
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            boolString = @"NO";
           
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
            boolString = @"YES";
           
        }
    }];
    
    if ([boolString  isEqual: @"NO"]) {
        return NO;
    }
    
    return YES;
}

@end
