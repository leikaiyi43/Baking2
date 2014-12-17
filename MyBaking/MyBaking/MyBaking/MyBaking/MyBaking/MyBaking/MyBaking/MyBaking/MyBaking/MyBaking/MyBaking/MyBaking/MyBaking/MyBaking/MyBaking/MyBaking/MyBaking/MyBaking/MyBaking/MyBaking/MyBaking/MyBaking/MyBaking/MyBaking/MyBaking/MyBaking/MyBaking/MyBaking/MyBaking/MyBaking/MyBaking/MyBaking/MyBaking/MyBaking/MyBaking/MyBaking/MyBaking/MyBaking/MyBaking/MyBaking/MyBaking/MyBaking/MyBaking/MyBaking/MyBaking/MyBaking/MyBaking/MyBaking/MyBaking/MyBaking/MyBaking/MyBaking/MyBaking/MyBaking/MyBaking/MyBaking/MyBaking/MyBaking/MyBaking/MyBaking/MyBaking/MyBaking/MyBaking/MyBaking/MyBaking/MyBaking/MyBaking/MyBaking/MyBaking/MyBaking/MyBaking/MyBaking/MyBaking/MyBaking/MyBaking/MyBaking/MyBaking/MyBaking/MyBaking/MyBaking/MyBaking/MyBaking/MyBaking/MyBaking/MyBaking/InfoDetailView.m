//
//  InfoDetailView.m
//  MyBaking
//
//  Created by lei on 11/16/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "InfoDetailView.h"

@implementation InfoDetailView

-(void)drawRect:(CGRect)rect {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    view.backgroundColor = [UIColor blueColor];
    [self addSubview:view];
    
    
}

@end
