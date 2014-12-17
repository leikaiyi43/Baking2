//
//  GraphViewDetailController.m
//  MyBaking
//
//  Created by lei on 11/26/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "GraphViewDetailController.h"
#import "ProbelDao.h"
#import "GraphItemViewCell.h"
#import "ProbelModel.h"

@interface GraphViewDetailController () <UITableViewDataSource, UITableViewDelegate>{
    UITableViewController *_tableViewCtrl;
    ProbelDao *_probelDao;
    NSTimer *_timer;
}

@end

@implementation GraphViewDetailController

-(instancetype)init {
    if (self = [super init]) {
        _probelDao = [ProbelDao sharedProbelDao];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTime) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableViewCtrl = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _tableViewCtrl.navigationItem.title = NSLocalizedString(@"Graph", @"图表");
    _tableViewCtrl.tableView.delegate = self;
    _tableViewCtrl.tableView.dataSource = self;
    [self pushViewController:_tableViewCtrl animated:YES];
    
}

#pragma mark ---------- uitableviewDatasouces ------ 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _probelDao.probelNumber;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"Probe", @"探针"), (section + 1)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    
    GraphItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GraphItemViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ProbelModel *probel = [_probelDao probelModelForIndex:indexPath.section];
    [cell.graphView setArray:probel.tempArrays];
    cell.graphView.warnLine = (int)probel.tempMin;
    
    return cell;
}

# pragma mark --------- uitableviewdelegate ----------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark ------- nstimer target -----------
- (void) onTime {
    for (int i = 0; i < _probelDao.probelNumber; i++) {
        ProbelModel *probel = [_probelDao probelModelForIndex:i];
        if (probel.currentTemp > 0) {
            [_probelDao addTemp:probel.currentTemp toArrayForIndex:i];
        }
    }
    
    [_tableViewCtrl.tableView reloadData];
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
