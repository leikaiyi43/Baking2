//
//  LanguageViewController.m
//  MyBaking
//
//  Created by lei on 11/14/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "LanguageViewController.h"

@interface LanguageViewController ()


@end

@implementation LanguageViewController

@synthesize languages;
@synthesize selectedIndex;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.languages = [NSArray arrayWithObjects:@"中文", @"English", nil];
    
    BakingPreferences *preferences = [BakingPreferences sharedBakingPreferences];
    self.selectedIndex = preferences.languageIndex;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell.textLabel setText:[self.languages objectAtIndex:indexPath.row]];
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            NSLog(@"选择中文");
            break;
        case 1:
            NSLog(@"选择English");
            break;
        default:
            break;
    }
    
    if (indexPath.row != self.selectedIndex) {
        self.selectedIndex = indexPath.row;
        BakingPreferences *preferences = [BakingPreferences sharedBakingPreferences];
        [preferences setLanguageIndex:indexPath.row];
        [preferences savePreferences];
    }
    
    [tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    
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
