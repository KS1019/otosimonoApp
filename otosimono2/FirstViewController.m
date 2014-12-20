//
//  FirstViewController.m
//  otosimono2
//
//  Created by Kotaro Suto on 2014/05/04.
//  Copyright (c) 2014年 Kotaro Suto. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    
    
    table.delegate=self;
    table.dataSource=self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self refresh];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *bid = [bundle bundleIdentifier];
    NSLog(@"---------->>>>>%@",bid);
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
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    //query.skip = 0;
    //query.limit = 10; // limit to at most 10 results
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *testobject in objects) {
            NSLog(@"hbhbf");
            // Do something with the returned PFObject in the gameScore variable.
            //NSLog(@"%@", testobject);
            NSLog(@"%@",str);
            str = [testobject objectForKey:@"foo"];
            
            CellColorNum = [testobject objectForKey:@"SegIndex"];
            //cellcolor = [CellColorNum intValue];
            [CellColorArray addObject:CellColorNum];
            
            
            NSLog(@"str->%@",str);
            [textarray addObject:str];
            NSLog(@"textarray->%@",textarray);
            //NSLog(@"%@",teststr);
            
            testimage = [testobject objectForKey:@"image"];
            [imagearray addObject:testimage];
            
            NSNumber *LatitudeNum = [testobject objectForKey:@"LatitudeNum"];
            NSNumber *LongitudeNum  = [testobject objectForKey:@"LongitudeNum"];
            [LatitudeArray addObject:LatitudeNum];
            [LongitudeArray addObject:LongitudeNum];
            
            
            
                      // ShowLatitude = [syy doubleValue];
            NSLog(@"ShowLatitude is %f",ShowLatitude);
            
            
            NSLog(@"========== imageArray is %@", imagearray);
            NSLog(@"%@",textarray[0]);
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
    
   // NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %@ &&&&&&&&&&&&&&&&&&&&&",comstr);
    /*-(void)prepareForSegue:(UIStoryboardSegue *)sg sender:(id)sender{
    if ([sg.identifier isEqualToString:@"Segue"])の後に呼ばれる*/
}


-(void)prepareForSegue:(UIStoryboardSegue *)sg sender:(id)sender {
    if ([sg.identifier isEqualToString:@"Segue"]) {
        /*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPathより先に呼ばれる。*/
        
        showmoreViewController *resultVC = sg.destinationViewController;
        //UIImage *image = [UIImage imageWithData:[sender getData]];
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        NSLog(@"length of ImageArray %d",[imagearray count]);
        UIImage *image = [UIImage imageWithData:[[imagearray objectAtIndex: indexPath.row] getData]];
       // comstr = [textarray objectAtIndex:indexPath.row];
        resultVC.showimage  = image;
        resultVC.CommentString = [textarray objectAtIndex:indexPath.row];
        NSLog(@"resultVC.showimage is %@", resultVC.showimage);
        NSLog(@"resultVC.CommentString is %@",resultVC.CommentString);
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
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
        if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        cell.textLabel.text=[textarray objectAtIndex:indexPath.row];
    
    cell.imageView.backgroundColor = [UIColor grayColor];
    PFFile *pfImage = [imagearray objectAtIndex:indexPath.row];
    [pfImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.imageView.image = [UIImage imageWithData:imageData];
            [table reloadData];
        }
    }];
    


    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellcolor = [[CellColorArray objectAtIndex:indexPath.row]intValue];
    switch (cellcolor) {
        case 0:
            cell.contentView.backgroundColor = [UIColor blueColor];
            break;
        case 1:
            cell.contentView.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            cell.contentView.backgroundColor = [UIColor yellowColor];
            break;
        case 3:
            cell.contentView.backgroundColor = [UIColor redColor];
            break;
    }
  }


@end
