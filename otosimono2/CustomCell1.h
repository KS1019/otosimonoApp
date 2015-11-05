//
//  CustomCell1.h
//  LostChecker
//
//  Created by Kotaro Suto on 2015/10/23.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell1 : UITableViewCell
  @property (weak, nonatomic)  IBOutlet UIImageView * iconImageView;
  @property (weak, nonatomic)  IBOutlet UIImageView * statusImageView;
  @property (weak, nonatomic)  IBOutlet UILabel * commentLabel;

  + (CGFloat)rowHeight;


@end
