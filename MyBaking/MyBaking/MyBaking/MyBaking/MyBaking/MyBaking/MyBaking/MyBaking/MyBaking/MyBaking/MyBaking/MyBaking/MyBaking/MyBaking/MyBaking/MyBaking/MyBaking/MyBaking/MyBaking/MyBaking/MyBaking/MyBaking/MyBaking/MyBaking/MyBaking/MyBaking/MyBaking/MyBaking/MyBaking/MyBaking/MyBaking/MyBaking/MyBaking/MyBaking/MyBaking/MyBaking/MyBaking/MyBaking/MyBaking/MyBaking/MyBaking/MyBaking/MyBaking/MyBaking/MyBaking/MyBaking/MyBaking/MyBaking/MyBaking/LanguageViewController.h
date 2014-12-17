//
//  LanguageViewController.h
//  MyBaking
//
//  Created by lei on 11/14/14.
//  Copyright (c) 2014 lky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BakingPreferences.h"

@interface LanguageViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, retain) NSArray *languages;

@end

