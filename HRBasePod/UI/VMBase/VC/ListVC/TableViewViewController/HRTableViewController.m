//
//  HRTableViewController.m
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRTableViewController.h"
#import "HRTableViewCell.h"
#import "HRItem.h"

@interface HRTableViewController ()



@end

@implementation HRTableViewController


#pragma mark - UIViewController
- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - HRViewController
- (void)allUpdate {
    [self.tableView reloadData];
}

#pragma mark - public
- (void)setViewModel:(HRListViewModel *)viewModel{
    [super setViewModel:viewModel];
}

- (HRListViewModel*) viewModel{
    return nil;
}

- (NSString*) identifierForIndexPath:(NSIndexPath*) indexPath withItem:(HRItem*) item{
    return [self.identifierGenerator identifierForObject:item];
}

- (HRIdentifierGenerator *)identifierGenerator {
    if (!_identifierGenerator) {
        _identifierGenerator = [HRIdentifierGenerator new];
    }
    return _identifierGenerator;
}

- (void) registerNibName:(NSString*) nibName forClass:(Class) itemClass{
    NSString* identifier = [self.identifierGenerator registerIdentifierForClass:itemClass];
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil]
         forCellReuseIdentifier:identifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HRItem* item = [self.viewModel itemAtIndex:indexPath.row inSection:indexPath.section];
    NSString* identifier = [self identifierForIndexPath:indexPath withItem:item];
    HRTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                            forIndexPath:indexPath];
    [cell fillWithItem:item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.viewModel didSelectItemAtIndex:indexPath.row inSection:indexPath.section];
}

@end
