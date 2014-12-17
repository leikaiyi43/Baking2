//
//  InfoViewController.m
//  MyBaking
//
//  Created by lei on 11/12/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *imageVC = [[UIViewController alloc] init];
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"image_0"],
                       [UIImage imageNamed:@"image_1"],
                       [UIImage imageNamed:@"image_2"],
                       [UIImage imageNamed:@"image_3"],
                       [UIImage imageNamed:@"image_4"],
                       [UIImage imageNamed:@"image_5"],
                       nil];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:[self.view bounds]];
    backgroundImage.animationImages = images;
    backgroundImage.animationDuration = 20;
    backgroundImage.animationRepeatCount = 0;
    [backgroundImage startAnimating];
    imageVC.navigationItem.title = NSLocalizedString(@"Info", @"信息");
    [imageVC.view addSubview:backgroundImage];
    
    InfoDetailView *detailView = [[InfoDetailView alloc] initWithFrame:
                                  CGRectMake(0, self.view.bounds.size.height - 200,
                                             self.view.bounds.size.width, 200)];
    detailView.alpha = 0.7;
    detailView.backgroundColor = [UIColor blackColor];
    [imageVC.view addSubview:detailView];
    
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self pushViewController:imageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
