//
//  BakingViewController.m
//  MyBaking
//
//  Created by lei on 11/12/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "BakingViewController.h"

@interface BakingViewController ()

@end

@implementation BakingViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewController *tableViewCtrl = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tableViewCtrl.navigationItem.title = @"烧烤";
    
    tableViewCtrl.tableView.delegate = self;
    tableViewCtrl.tableView.dataSource = self;
    
    [self pushViewController:tableViewCtrl animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    
    ProbeItemView *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProbeItemView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
    }
    
    if (indexPath.row == 0) {
    
    } else if (indexPath.row == 1) {
        
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Probe 1";
    } else if (section == 1) {
        return @"Probe 2";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void) probeItemViewDidTimerSelected:(ProbeItemView *)probeItemView {
    TimeoutViewController *timeoutViewCtrl = [[TimeoutViewController alloc] init];
    [self pushViewController:timeoutViewCtrl animated:YES];
}
-(void) probeItemViewDidTemperatureSelected: (ProbeItemView *)probeItemView {
        NSLog(@"temperature");
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
