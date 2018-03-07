//
//  HRCollectionViewController.m
//  Vivid
//
//  Created by Alexander Shipin on 21/11/2017.
//  Copyright © 2017 Sibers. All rights reserved.
//

#import "HRCollectionViewController.h"
#import "HRItem.h"
#import "HRCollectionViewCell.h"

@interface HRCollectionViewController ()

@end

@implementation HRCollectionViewController

#pragma mark - UIViewController
- (void) viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

#pragma mark - HRViewController
- (void)allUpdate {
    [self.collectionView reloadData];
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
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil]
          forCellWithReuseIdentifier:identifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HRItem* item = [self.viewModel itemAtIndex:indexPath.row inSection:indexPath.section];
    NSString* identifier = [self identifierForIndexPath:indexPath withItem:item];
    HRCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    [cell fillWithItem:item];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel didSelectItemAtIndex:indexPath.row inSection:indexPath.section];
}

@end
