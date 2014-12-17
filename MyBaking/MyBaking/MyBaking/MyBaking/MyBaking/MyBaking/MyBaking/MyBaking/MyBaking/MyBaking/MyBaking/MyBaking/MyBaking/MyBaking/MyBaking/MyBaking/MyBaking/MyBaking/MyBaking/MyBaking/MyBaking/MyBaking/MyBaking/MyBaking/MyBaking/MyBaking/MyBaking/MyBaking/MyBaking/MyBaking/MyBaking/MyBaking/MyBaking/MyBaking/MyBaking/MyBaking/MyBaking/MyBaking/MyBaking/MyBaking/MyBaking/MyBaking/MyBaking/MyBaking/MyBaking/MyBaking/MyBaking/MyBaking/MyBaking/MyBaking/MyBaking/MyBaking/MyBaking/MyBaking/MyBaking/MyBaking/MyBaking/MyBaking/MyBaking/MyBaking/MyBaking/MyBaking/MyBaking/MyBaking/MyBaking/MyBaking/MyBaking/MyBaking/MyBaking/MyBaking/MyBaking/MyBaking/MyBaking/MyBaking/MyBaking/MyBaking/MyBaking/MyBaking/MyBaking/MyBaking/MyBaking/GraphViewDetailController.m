//
//  GraphViewDetailController.m
//  MyBaking
//
//  Created by lei on 11/26/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "GraphViewDetailController.h"

@interface GraphViewDetailController ()

@end

@implementation GraphViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    graphView = [[GraphView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 180)];
    [graphView setBackgroundColor:[UIColor yellowColor]];
    [graphView setSpacing:10];
    [graphView setFill:YES];
    [graphView setStrokeColor:[UIColor redColor]];
    [graphView setZeroLineStrokeColor:[UIColor greenColor]];
    [graphView setFillColor:[UIColor orangeColor]];
    [graphView setLineWidth:2];
    [graphView setCurvedLines:YES];
    [self.view addSubview:graphView];
    
    UIButton *addPoints = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addPoints.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 50, 270, 100, 40);
    [addPoints setTitle:@"add point" forState:UIControlStateNormal];
    [addPoints addTarget:self action:@selector(addPoint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPoints];
}

-(void) addPoint:(id) sender {
    
    float low_bound = 0.00;
    float high_bound = 10.00;
    float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    int intRndValue = (int)(rndValue + 0.5);
    
    [graphView setPoint:intRndValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
