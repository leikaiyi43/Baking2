//
//  SettingViewController.m
//  MyBaking
//
//  Created by lei on 11/11/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "SettingViewController.h"
#import "MusicViewController.h"

@interface SettingViewController ()
{
    UITableViewController *_tableViewController;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _tableViewController.navigationItem.title = NSLocalizedString(@"Settings", @"设置");
    
    [_tableViewController.tableView setDataSource:self];
    [_tableViewController.tableView setDelegate:self];
    
    [self pushViewController:_tableViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *languageId = @"languageCellId";
    static NSString *temperatureId = @"temperatureCellId";
    static NSString *musicId = @"musicId";
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    UITableViewCell *cell = nil;
    
    if (row == 0 && section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:temperatureId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:temperatureId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            switchView.thumbTintColor = [UIColor blackColor];
            [switchView addTarget:self action:@selector(temperatureChanged:) forControlEvents:UIControlEventValueChanged];
            
            switchView.onImage = [UIImage imageNamed:@"switchC.png"];
            switchView.offImage = [UIImage imageNamed:@"switchF.png"];
            
            
            cell.accessoryView = switchView;
        }
        
        NSString *unit;
        BOOL isTemperatreC = [BakingPreferences sharedBakingPreferences].isTemperatureC;
        if (isTemperatreC) {
            unit = @"℃";
        } else {
            unit = @"°F";
        }
        [((UISwitch *)cell.accessoryView) setOn:isTemperatreC];
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Temperature Units", @"温度单位"), unit];
    } else if (row == 1 && section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:languageId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:languageId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell.textLabel setText:NSLocalizedString(@"Language", @"语言")];
    } else if (row == 0 && section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:musicId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:musicId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell.textLabel setText:NSLocalizedString(@"Ringtone", @"铃声设置")];
    }
    
    return cell;

}

- (void) temperatureChanged:(id)sender {
    UISwitch *switchButton  = (UISwitch*) sender;
    BakingPreferences *pref = [BakingPreferences sharedBakingPreferences];
    pref.isTemperatureC = switchButton.isOn;
    [pref savePreferences];
    [_tableViewController.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1 && indexPath.section == 0) {
        LanguageViewController *languageViewCtrl = [[LanguageViewController alloc] initWithStyle:UITableViewStyleGrouped];
        languageViewCtrl.title = NSLocalizedString(@"Language", @"语言");
    
        [self pushViewController:languageViewCtrl animated:YES];
    
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        MusicViewController *musicViewCtrl = [[MusicViewController alloc] init];
        [self pushViewController:musicViewCtrl animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
