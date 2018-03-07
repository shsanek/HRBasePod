//
//  HRCollectionViewController.h
//  Vivid
//
//  Created by Alexander Shipin on 21/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRViewController.h"
#import "HRIdentifierGenerator.h"
#import "HRListViewModel.h"

@class HRItem;

@interface HRCollectionViewController : HRViewController
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) HRIdentifierGenerator* identifierGenerator;
@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;

- (NSString*) identifierForIndexPath:(NSIndexPath*) indexPath withItem:(HRItem*) item;
- (void) registerNibName:(NSString*) nibName forClass:(Class) itemClass;

- (void)setViewModel:(HRListViewModel *)viewModel;
- (HRListViewModel*) viewModel;

@end
