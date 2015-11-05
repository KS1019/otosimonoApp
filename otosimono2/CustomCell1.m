//
//  CustomCell1.m
//  LostChecker
//
//  Created by Kotaro Suto on 2015/10/23.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

#import "CustomCell1.h"

@implementation CustomCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight
{
    return 70.0f;
}

@end
