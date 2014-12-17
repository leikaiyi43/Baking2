//
//  CraphItemViewTableViewCell.m
//  MyBaking
//
//  Created by lei on 12/4/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "GraphItemViewCell.h"
#import "GraphView.h"

@implementation GraphItemViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)drawRect:(CGRect)rect {
    
    if (!_graphView) {
        _graphView = [[GraphView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10)];
        [_graphView setBackgroundColor:[UIColor yellowColor]];
        [_graphView setSpacing:10];
        [_graphView setFill:NO];
        [_graphView setStrokeColor:[UIColor redColor]];
        [_graphView setZeroLineStrokeColor:[UIColor greenColor]];
        [_graphView setFillColor:[UIColor orangeColor]];
        [_graphView setLineWidth:2];
        [_graphView setCurvedLines:YES];
        
        [self addSubview:_graphView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
