//
//  HRTableViewController.h
//  Vivid
//
//  Created by Alexander Shipin on 20/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRViewController.h"
#import "HRIdentifierGenerator.h"
#import "HRListViewModel.h"

@class HRItem;

@interface HRTableViewController : HRViewController
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) HRIdentifierGenerator* identifierGenerator;
@property (nonatomic, weak) IBOutlet UITableView* tableView;

- (NSString*) identifierForIndexPath:(NSIndexPath*) indexPath withItem:(HRItem*) item;
- (void) registerNibName:(NSString*) nibName forClass:(Class) itemClass;

- (void)setViewModel:(HRListViewModel *)viewModel;
- (HRListViewModel*) viewModel;

@end
