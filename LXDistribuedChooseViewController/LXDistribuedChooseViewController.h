//
//  LXDistribuedChooseViewController.h
//  NewProject
//
//  Created by Livespro on 2017/4/20.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDistribuedTopCollectionViewHeight 40

#define kDistribuedLeftTableViewWidth [UIScreen mainScreen].bounds.size.width/4

@protocol LXDistribuedDataSource <NSObject>

@required

//需要注册的cell,根据对应的key给出 -- collection必须注册
- (NSDictionary *)collectionRegisters;//@{@"topClass":@[@""],@"topNib":@[],@"rightClass":@[],@"rightNib":@[],@"leftClass":@[],@"leftNib":@[]}

@optional

//topColleion高度
- (CGFloat)heightDistribuedTopCollectionView;

//leftTable宽度
- (CGFloat)widthDistribuedLeftTableView;

#pragma mark - left ->
- (UITableViewCell *)distribuedLeftTableView:(UITableView *)leftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)distribuedLeftTableView:(UITableView *)leftTableView numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInDistribuedLeftTableView:(UITableView *)leftTableView;

// Variable height support
- (CGFloat)distribuedLeftTableView:(UITableView *)leftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)distribuedLeftTableView:(UITableView *)leftTableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)distribuedLeftTableView:(UITableView *)leftTableView heightForFooterInSection:(NSInteger)section;

- (UIView *)distribuedLeftTableView:(UITableView *)leftTableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)distribuedLeftTableView:(UITableView *)leftTableView viewForFooterInSection:(NSInteger)section;
//点击事件
- (void)distribuedLeftTableViewDidSelectRowActionAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark - right ->
- (NSInteger)numberOfSectionsInDistribuedRightCollectionView:(UICollectionView *)rightCollectionView;

- (NSInteger)distribuedRightCollectionView:(UICollectionView *)rightCollectionView numberOfItemsInSection:(NSInteger)section;

- (UICollectionViewCell *)distribuedRightCollectionView:(UICollectionView *)rightCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)distribuedRightCollectionView:(UICollectionView *)rightCollectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

//点击事件
- (void)distribuedRightCollectionViewDidSelectItemActionAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - top ->
- (NSInteger)numberOfItemsInDistribuedTopCollectionView:(UICollectionView *)topCollectionView;

- (UICollectionViewCell *)distribuedTopCollectionView:(UICollectionView *)topCollectionView cellForItemAtIndex:(NSInteger)index;

//点击事件
- (void)distribuedTopCollectionViewDidSelectItemActionAtIndex:(NSInteger)index;

// collection layout support
- (CGSize)distribuedCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)distribuedCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)distribuedCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)distribuedCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)distribuedCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)distribuedCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end


@interface LXDistribuedChooseViewController : UIViewController

@property (nonatomic, strong)  UITableView *leftTableView;

@property (nonatomic, strong)  UICollectionView *rightCollectionView;

@property (nonatomic, strong)  UICollectionView *topCollectionView;

@property (nonatomic, assign)  id <LXDistribuedDataSource>delegate;

//获取topCollectionView 选择的index
- (NSInteger)topSelectedIndex;

//获取leftTableView 选择的indexPath
- (NSIndexPath *)leftSelectedIndexPath;

- (instancetype)initWithFrame:(CGRect)frame Delegate:(id)delegate;

@end
