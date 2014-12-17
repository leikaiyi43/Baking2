//
//  InfoDetailViewController.m
//  MyBaking
//
//  Created by lei on 12/14/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "ProbelDao.h"
#import "ProbelModel.h"
#import "TempUtil.h"

@interface InfoDetailViewController ()<ProbeModelDelegate> {
    ProbelDao *_probelDao;
}

@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _probelDao = [ProbelDao sharedProbelDao];
    for (int i = 0; i < _probelDao.probelNumber; i++) {
        ProbelModel *model = [_probelDao probelModelForIndex:i];
        [model addDelegate:self];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) temp: (NSInteger) temp updateAtIndex: (NSInteger) index {
    if (index == 0) {
        _temp1.text = [[TempUtil sharedTempUtil] stringLocalizedTemp:temp];
    } else if (index == 1) {
        _temp2.text = [[TempUtil sharedTempUtil] stringLocalizedTemp:temp];
    }
}

- (void) timeout: (NSInteger) timeout updateAtIndex: (NSInteger) index {
    if (index == 0) {
        _time1.text = [self formatTime:timeout];
    } else if (index == 1) {
        _time2.text = [self formatTime:timeout];
    }
}

- (NSString *) formatTime:(NSInteger) count {
    NSInteger seconds = count % 60;
    NSInteger minutes = (count / 60) % 60;
    NSInteger hours = count / 3600;
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d", hours, minutes, seconds];
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
