//
//  MusicViewController.m
//  Clock
//
//  Created by 达言科技 on 27/11/14.
//  Copyright (c) 2014年 达言科技. All rights reserved.
//

#import "MusicViewController.h"
#import "TimeoutViewController.h"
#import "BakingPreferences.h"
#import "RingUtil.h"

@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *name_array;
    NSInteger row;
    NSMutableArray *select_array;
    UITableView *_tableView;
    
}

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // read ringindex from user setting
    BakingPreferences *preferences = [BakingPreferences sharedBakingPreferences];
    row = preferences.ringIndex;
    
    RingUtil *ringUtil = [RingUtil sharedRingUtil];
    
    select_array=[NSMutableArray array];
    name_array=[NSArray arrayWithArray:[ringUtil getRingNames]];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title = NSLocalizedString(@"Ringtone", @"铃声设置");
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cancel", @"取消") style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem=left;
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Store", @"取消") style:UIBarButtonItemStyleDone target:self action:@selector(sucess)];
    self.navigationItem.rightBarButtonItem=right;
    
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    _tableView=tableView;
   
    
}
#pragma mark-------------UITableViewDataSource-----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return name_array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IdentiFier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:IdentiFier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentiFier];
    }
    cell.textLabel.text=name_array[indexPath.row];
    if (row==indexPath.row) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;

    }
    else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}
#pragma mark-----------未完成-------------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    row=indexPath.row;
    [_tableView reloadData];
}
-(void)cancel{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)sucess{
    NSString *str=name_array[row];
    [self.delegate MusicStr:str];
    BakingPreferences *pref = [BakingPreferences sharedBakingPreferences];
    pref.ringIndex = row;
    [pref savePreferences];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
