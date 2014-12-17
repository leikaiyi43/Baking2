//
//  TemperatureViewController.m
//  MyBaking
//
//  Created by lei on 11/30/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "TemperatureViewController.h"
#import "SSRollingButtonScrollView.h"
#import "FoodLevelCell.h"
#import "CustomeTemperatureViewController.h"
#import "TempUtil.h"
#import "BakingPreferences.h"

@interface TemperatureViewController () <SSRollingButtonScrollViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray *foods;
    NSDictionary *food;
    
    NSInteger selectedIndex;
    NSInteger currentTemp;
}

@end

@implementation TemperatureViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        currentTemp = 0;
        selectedIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"Temperature", @"温度");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Custom", @"自定义") style: UIBarButtonItemStylePlain target:self action:@selector(presentCustomeTempViewCtrl)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"FoodLevel" ofType:@"plist"];
    foods = [[NSMutableArray alloc] initWithContentsOfFile:plist];
    food = [foods objectAtIndex:0];
    NSString *foodName = NSLocalizedString([food objectForKey:@"name"], @"foodName");
    _foodNameLabel.text = foodName;

    NSMutableArray *imageNames = [NSMutableArray array];
    NSMutableArray *centerImageNames = [NSMutableArray array];
    for (NSDictionary *f in foods) {
        NSString *imageName = [f objectForKey:@"img"];
        [imageNames addObject: imageName];
        [centerImageNames addObject:[NSString stringWithFormat:@"%@S", imageName]];
    }

    self.phoneticSelector01.spacingBetweenButtons = 10.0f;
    self.phoneticSelector01.fixedButtonHeight = 75.0f;
    self.phoneticSelector01.fixedButtonWidth = 75.0f;
    self.phoneticSelector01.centerButtonTextColor = [UIColor clearColor];
    self.phoneticSelector01.notCenterButtonTextColor = [UIColor clearColor];
    self.phoneticSelector01.ssRollingButtonScrollViewDelegate = self;

    [self.phoneticSelector01 createButtonArrayWithButtonNormalImageNames:imageNames andCenterButtonImageNames:centerImageNames];
    

    [self.view addSubview:self.phoneticSelector01];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- class method ------
- (void) customeTemperature: (NSInteger) temp {
    currentTemp = temp;
    [self didTemperatureSeted];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSegmentChanged:(id)sender {
    NSInteger index = _titleSegment.selectedSegmentIndex;
    NSLog(@"%d", index);
}

- (void) didTemperatureSeted {
    if (_delegate && [_delegate respondsToSelector:@selector(didTemperatureSeted:withUserData:)]) {
        [_delegate didTemperatureSeted:currentTemp withUserData:_userData];
    }
}


#pragma mark - SSRollingButtonScrollViewDelegate

- (void)rollingScrollViewButtonPushed:(UIButton *)button ssRollingButtonScrollView:(SSRollingButtonScrollView *)rollingButtonScrollView
{
    selectedIndex = 0;
    NSInteger index = button.tag - 100;
    food = [foods objectAtIndex:index];
    NSString *foodName = NSLocalizedString([food objectForKey:@"name"], @"foodName");
    _foodNameLabel.text = foodName;
    [self.tableView reloadData];
}

- (void)rollingScrollViewButtonIsInCenter:(UIButton *)button ssRollingButtonScrollView:(SSRollingButtonScrollView *)rollingButtonScrollView
{
    selectedIndex = 0;
    NSInteger index = button.tag - 100;
    food = [foods objectAtIndex:index];
    NSString *foodName =  NSLocalizedString([food objectForKey:@"name"], @"foodName");
    _foodNameLabel.text = foodName;
    [self.tableView reloadData];
}

- (void) inflateTableViewWith:(NSArray *) levels {
    
}
#pragma mark -------- end -------------

#pragma mark -------- tableview delegate------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (food) {
        NSArray *levels = [food objectForKey:@"levels"];
        return [levels count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *foodLevelCell = @"foodLevelCell";
    FoodLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:foodLevelCell];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"FoodLevelCell" bundle:nil] forCellReuseIdentifier:foodLevelCell];
        cell = [tableView dequeueReusableCellWithIdentifier:foodLevelCell];
    }


    NSArray *levels = [food objectForKey:@"levels"];
    NSDictionary *level = [levels objectAtIndex:indexPath.row];
    NSString *name = NSLocalizedString([level objectForKey:@"name"], @"name");
//    NSNumber *value = [level objectForKey:@"value"];
    cell.name.text = name;
    
    if ([BakingPreferences sharedBakingPreferences].isTemperatureC) {
        cell.value.text = [level objectForKey:@"content"];
    } else {
        cell.value.text = [level objectForKey:@"content2"];
    }
    
    if (selectedIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedIndex = indexPath.row;
    [tableView reloadData];
}

#pragma mark ---------- end --------------

- (IBAction)onConfirmed:(id)sender {
    NSArray *levels = [food objectForKey:@"levels"];
    NSDictionary *level = [levels objectAtIndex:selectedIndex];
    NSNumber *value = [level objectForKey:@"value"];
    currentTemp = value.intValue;
    [self didTemperatureSeted];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) presentCustomeTempViewCtrl {
    CustomeTemperatureViewController *controller = [[CustomeTemperatureViewController alloc] initWithNibName:@"CustomeTemperatureViewController" bundle:nil];
    controller.temperatureCtrl = self;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
