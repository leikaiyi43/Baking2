//
//  InfoViewController.m
//  MyBaking
//
//  Created by lei on 11/12/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoDetailViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    

    InfoDetailViewController *detailVC = [[InfoDetailViewController alloc] init];
    detailVC.navigationItem.title = NSLocalizedString(@"Info", @"信息");
    [self pushViewController:detailVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
