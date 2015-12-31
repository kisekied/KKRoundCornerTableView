//
//  ViewController.m
//  KKRoundCornerTableView
//
//  Created by kisekied on 15/11/24.
//  Copyright © 2015年 kisekied. All rights reserved.
//

#import "ViewController.h"
#import "KKRoundCornerCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray arrayWithArray:@[@"A", @"B", @"C", @"D", @"E", @"F", @"G"]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return _dataArr.count;
    } else {
        return section + 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellID = @"CELLID";
    KKRoundCornerCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[KKRoundCornerCell alloc] initWithCornerRadius:10.0f Style:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    
    if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
        cell.roundCornerType = KKRoundCornerCellTypeSingleRow;
    } else if (indexPath.row == 0) {
        cell.roundCornerType = KKRoundCornerCellTypeTop;
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.roundCornerType = KKRoundCornerCellTypeBottom;
    } else {
        cell.roundCornerType = KKRoundCornerCellTypeDefault;
    }
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0
//                                     green:arc4random() % 256 / 256.0
//                                      blue:arc4random() % 256 / 256.0
//                                     alpha:1.0];
    cell.backgroundColor = [UIColor cyanColor];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组第%ld行", indexPath.section + 1, indexPath.row + 1];
    
    if (indexPath.section == 3) {
        cell.textLabel.text = [_dataArr objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end