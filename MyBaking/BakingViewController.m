//
//  BakingViewController.m
//  MyBaking
//
//  Created by lei on 11/12/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "BakingViewController.h"
#import "TemperatureViewController.h"
#import "ProbelDao.h"
#import "ProbelModel.h"
#import "RingUtil.h"
#import "TempUtil.h"

@interface BakingViewController () <TemperatureViewDelegate, ProbeModelDelegate> {
    ProbelDao* _probelDao;
}

@end

@implementation BakingViewController

-(instancetype)init {
    if (self = [super init]) {
        _probelDao = [ProbelDao sharedProbelDao];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timerCounts = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    _tableViewCtrl = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _tableViewCtrl.navigationItem.title = NSLocalizedString(@"Cooking", @"烧烤");
    
    _tableViewCtrl.tableView.delegate = self;
    _tableViewCtrl.tableView.dataSource = self;
    
    for (int i = 0; i < _probelDao.probelNumber; i ++) {
        [_probelDao addDelegate:self forIndex:i];
    }
    
    [self pushViewController:_tableViewCtrl animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_probelDao probelNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    
    ProbeItemView *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProbeItemView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    ProbelModel *model = [_probelDao probelModelForIndex:indexPath.section];
    NSInteger timeout = model.timeout;
    NSInteger currentTmep = model.currentTemp;
    NSInteger tempMin = model.tempMin;
    
    cell.timeCount = timeout;
    cell.temperature = currentTmep;
    cell.warnTemp =tempMin;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [NSString stringWithFormat:@"%@ %d", NSLocalizedString(@"Probe", @"探针"), (section + 1)];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void) probeItemViewDidTimerSelected:(ProbeItemView *)probeItemView {
    NSIndexPath *indexPath = [_tableViewCtrl.tableView indexPathForCell:probeItemView];
    TimeoutViewController *timeoutViewCtrl = [[TimeoutViewController alloc] init];
    timeoutViewCtrl.userData = [NSNumber numberWithLong:indexPath.section];
    timeoutViewCtrl.delegate = self;
    
    [self pushViewController:timeoutViewCtrl animated:YES];
}
-(void) probeItemViewDidTemperatureSelected: (ProbeItemView *)probeItemView {
    NSIndexPath *indexPath = [_tableViewCtrl.tableView indexPathForCell:probeItemView];
    TemperatureViewController *temperatureViewCtrl = [[TemperatureViewController alloc] init];
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
    [userData setObject:indexPath forKey:@"indexPath"];
    temperatureViewCtrl.userData = userData;
    temperatureViewCtrl.delegate = self;
    
    [self pushViewController:temperatureViewCtrl animated:YES];
}

-(void) timeWithSecond:(NSInteger) seconds userData:(id)userData{
    NSNumber *section = (NSNumber *)userData;
    ProbelModel *model = [_probelDao probelModelForIndex:section.intValue];
    model.timeout = seconds;
}

-(void) onTimer {
    NSInteger count = [_probelDao probelNumber];
    
    for (int i = 0; i < count; i++) {
        ProbelModel *model = [_probelDao probelModelForIndex:i];
        NSInteger timeout = model.timeout;
        
        if (timeout > 0) {
            timeout --;
            [_probelDao setTimeout:timeout forIndex:i];
        }
    }
    
    [_tableViewCtrl.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[RingUtil sharedRingUtil] stopRing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------- temperatureViewDelegate ----------
-(void) didTemperatureSeted:(NSInteger ) temp withUserData:(NSMutableDictionary *) userData {
    NSDictionary *dictionary = userData;
    NSIndexPath *indexPath = [dictionary objectForKey:@"indexPath"];
    
    ProbelModel *model = [_probelDao probelModelForIndex:indexPath.section];
    model.tempMin = temp;
}

#pragma mark ------- probe delegate -------
- (void) temp: (NSInteger) temp updateAtIndex: (NSInteger) index {
    ProbelModel *model = [_probelDao probelModelForIndex:index];
    if (model.tempMin < model.currentTemp && model.tempMin != -1) {
        [[RingUtil sharedRingUtil] playRing];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ %ld",NSLocalizedString(@"Probe", @"探针") , index + 1] message:NSLocalizedString(@"Temperature", @"温度限制") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"确定") otherButtonTitles:nil, nil];
        [alert show];
        [_probelDao setTempMin:-1 forIndex:index];
    }
}

- (void) timeout: (NSInteger) timeout updateAtIndex: (NSInteger) index {
    if (timeout == 0) {
        [[RingUtil sharedRingUtil] playRing];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ %ld",NSLocalizedString(@"Probe", @"探针") , index + 1] message:NSLocalizedString(@"Timeout", @"计时结束") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"确定") otherButtonTitles:nil, nil];
        [alert show];
        [_probelDao setTimeout:-1 forIndex:index];
    }
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
