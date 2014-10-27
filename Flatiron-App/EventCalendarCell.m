//
//  EventCalendarCell.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/26/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "EventCalendarCell.h"

@implementation EventCalendarCell

-(UIView *)drawDotWithOriginX:(NSInteger)originX originY:(NSInteger)originY color:(UIColor *)color {
    NSInteger length = 4;
    UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(originX - (length / 2), originY, length, length)];
    dotView.layer.cornerRadius = length / 2;
    dotView.backgroundColor = [UIColor blackColor];
    return dotView;
}

@end
