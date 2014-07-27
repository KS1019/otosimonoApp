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

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
    if (segue==1) {
   segue=0;
    }else{
        [self refresh]; 
    }
    //NSLog(@"44444444444444444");
}

-(IBAction)refresh{
    NSLog(@"111111!!!!1");
    
    textarray=[[NSMutableArray alloc] init];
    imagearray=[[NSMutableArray alloc]init];
    CellColorArray = [[NSMutableArray alloc]init];
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
            //cellcolor = [CellColorNum intValue];
            [CellColorArray addObject:CellColorNum];
            
            
            NSLog(@"str->%@",str);
            [textarray addObject:str];
            NSLog(@"textarray->%@",textarray);
            //NSLog(@"%@",teststr);
            
            testimage=[testobject objectForKey:@"image"];
            [imagearray addObject:testimage];
            
            
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
        NSLog(@"length of ImageArray %ld",[imagearray count]);
        UIImage *image = [UIImage imageWithData:[[imagearray objectAtIndex: indexPath.row] getData]];
       // comstr = [textarray objectAtIndex:indexPath.row];
        resultVC.showimage  = image;
        resultVC.CommentString = [textarray objectAtIndex:indexPath.row];
        NSLog(@"resultVC.showimage is %@", resultVC.showimage);
        NSLog(@"resultVC.CommentString is %@",resultVC.CommentString);
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
    /*switch (cellcolor) {
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
    }*/
    //NSString *st = [CellColorArray objectAtIndex:indexPath.row];
    //cell.contentView.backgroundColor = [UIColor ];

    cell.textLabel.text=[textarray objectAtIndex:indexPath.row];
    
    cell.imageView.backgroundColor = [UIColor grayColor];
    PFFile *pfImage = [imagearray objectAtIndex:indexPath.row];
    [pfImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.imageView.image = [UIImage imageWithData:imageData];
            [table reloadData];
        }
    }];
    
//    cell.imageView.image =
    //cell.textLabel.text=@"あ";

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
   /* // For even
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    // For odd
    else {
        
        cell.backgroundColor = RGB(235, 204, 255);
    }*/
}


@end
