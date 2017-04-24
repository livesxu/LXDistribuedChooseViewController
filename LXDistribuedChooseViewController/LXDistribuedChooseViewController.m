//
//  LXDistribuedChooseViewController.m
//  NewProject
//
//  Created by Livespro on 2017/4/20.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "LXDistribuedChooseViewController.h"

@interface LXDistribuedChooseViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,   copy)  NSString *topIndexSign;//顶部选择标记

@property (nonatomic, strong)  NSIndexPath *leftIndexPathSign;//左侧选择标记

@end

@implementation LXDistribuedChooseViewController

- (void)dealloc{
    
    [self removeObserver:self forKeyPath:@"self.topIndexSign"];
    [self removeObserver:self forKeyPath:@"self.leftIndexPathSign"];
    
}

- (instancetype)initWithFrame:(CGRect)frame Delegate:(id)delegate;{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        
        self.view.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *keys = [[self.delegate collectionRegisters] allKeys];
    
    //加载上侧、右侧collection
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqualToString:@"topClass"] || [obj isEqualToString:@"topNib"]) {
            
            [self.view addSubview:self.topCollectionView];
            
        } else if ([obj isEqualToString:@"rightClass"] || [obj isEqualToString:@"rightNib"]) {
            
            [self.view addSubview:self.rightCollectionView];
        }
    }];
    
    //加载左侧table
    if ([self.delegate respondsToSelector:@selector(widthDistribuedLeftTableView)]) {
    
        if ([self.delegate widthDistribuedLeftTableView] > 0) {
         
            [self.view addSubview:self.leftTableView];
        }
    }else{
        
        [self.view addSubview:self.leftTableView];
    }
    
    [self addObserver:self forKeyPath:@"self.topIndexSign" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"self.leftIndexPathSign" options:NSKeyValueObservingOptionNew context:nil];
}

//监听 -->
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"self.topIndexSign"]) {
        
        [self.topCollectionView reloadData];
        
        //上侧点击事件传递
        if ([self.delegate respondsToSelector:@selector(distribuedTopCollectionViewDidSelectItemActionAtIndex:)]) {
            
            [self.delegate distribuedTopCollectionViewDidSelectItemActionAtIndex:self.topIndexSign.integerValue];
        }
        
    } else if ([keyPath isEqualToString:@"self.leftIndexPathSign"] && change[@"new"]) {
       
        [self.leftTableView reloadData];
        
        //左侧点击事件传递
        if ([self.delegate respondsToSelector:@selector(distribuedLeftTableViewDidSelectRowActionAtIndexPath:)]) {
            
            [self.delegate distribuedLeftTableViewDidSelectRowActionAtIndexPath:self.leftIndexPathSign];
        }
    }
}

#pragma mark - lazyLoad ->
- (UICollectionView *)topCollectionView{
    if (!_topCollectionView) {
       
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeZero;
        
        _topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _topCollectionView.backgroundColor = [UIColor clearColor];
        _topCollectionView.pagingEnabled = YES;
        _topCollectionView.dataSource = self;
        _topCollectionView.delegate = self;
        _topCollectionView.showsHorizontalScrollIndicator = NO;
        
        NSArray *itemClasses = [[self.delegate collectionRegisters] objectForKey:@"topClass"];
        
        NSArray *itemNibs = [[self.delegate collectionRegisters] objectForKey:@"topNib"];
        
        for (NSString *className in itemClasses) {
            
            [_topCollectionView registerClass:[NSClassFromString(className) class] forCellWithReuseIdentifier:className];
        }
        
        for (NSString *nibName in itemNibs) {
            
            [_topCollectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
        }
        
    }
    return _topCollectionView;
}

- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.showsVerticalScrollIndicator  = NO;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.backgroundColor = [UIColor clearColor];
        
        NSArray *itemClasses = [[self.delegate collectionRegisters] objectForKey:@"leftClass"];
        
        NSArray *itemNibs = [[self.delegate collectionRegisters] objectForKey:@"leftNib"];
        
        for (NSString *className in itemClasses) {
            
            [_leftTableView registerClass:[NSClassFromString(className) class] forCellReuseIdentifier:className];
        }
        
        for (NSString *nibName in itemNibs) {
            
            [_leftTableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
        }
        
    }
    return _leftTableView;
}

- (UICollectionView *)rightCollectionView{
    if (!_rightCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeZero;
        
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _rightCollectionView.backgroundColor = [UIColor clearColor];
        _rightCollectionView.pagingEnabled = YES;
        _rightCollectionView.dataSource = self;
        _rightCollectionView.delegate = self;
        _rightCollectionView.showsHorizontalScrollIndicator = NO;
        
        NSArray *itemClasses = [[self.delegate collectionRegisters] objectForKey:@"rightClass"];
        
        NSArray *itemNibs = [[self.delegate collectionRegisters] objectForKey:@"rightNib"];
        
        for (NSString *className in itemClasses) {
            
            [_rightCollectionView registerClass:[NSClassFromString(className) class] forCellWithReuseIdentifier:className];
        }
        
        for (NSString *nibName in itemNibs) {
            
            [_rightCollectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
        }
    }
    return _rightCollectionView;
}

- (NSString *)topIndexSign{
    if (!_topIndexSign) {
        
        if (!_topCollectionView) return nil;
        
        _topIndexSign = @"0";
        
        //上侧点击事件传递
        if ([self.delegate respondsToSelector:@selector(distribuedTopCollectionViewDidSelectItemActionAtIndex:)]) {
            
            [self.delegate distribuedTopCollectionViewDidSelectItemActionAtIndex:_topIndexSign.integerValue];
        }
    }
    return _topIndexSign;
}

- (NSIndexPath *)leftIndexPathSign{
    if (!_leftIndexPathSign) {
        
        if (!_topIndexSign && _topCollectionView) return nil;
        
        if (!_leftTableView) return nil;
        
        _leftIndexPathSign = [NSIndexPath indexPathForRow:0 inSection:0];
        //左侧点击事件传递
        if ([self.delegate respondsToSelector:@selector(distribuedLeftTableViewDidSelectRowActionAtIndexPath:)]) {
            
            [self.delegate distribuedLeftTableViewDidSelectRowActionAtIndexPath:_leftIndexPathSign];
        }
    }
    return _leftIndexPathSign;
}

//获取topCollectionView 选择的index
- (NSInteger)topSelectedIndex;{

    return self.topIndexSign.integerValue;
}

//获取leftTableView 选择的indexPath
- (NSIndexPath *)leftSelectedIndexPath;{
    
    return self.leftIndexPathSign;
}

#pragma mark - delegate - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInDistribuedLeftTableView:)]) {
        
        [self leftIndexPathSign];
        
        return [self.delegate numberOfSectionsInDistribuedLeftTableView:tableView];
    } else {
        
        [self leftIndexPathSign];
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    
    return [self.delegate distribuedLeftTableView:tableView numberOfRowsInSection:section];
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    return [self.delegate distribuedLeftTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!(indexPath.section == self.leftIndexPathSign.section && indexPath.row == self.leftIndexPathSign.row)) {
      
        self.leftIndexPathSign = indexPath;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedLeftTableView:heightForRowAtIndexPath:)]) {
        
        return [self.delegate distribuedLeftTableView:tableView heightForRowAtIndexPath:indexPath];
        
    } else {
        
        return 44.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedLeftTableView:heightForHeaderInSection:)]) {
        
        return [self.delegate distribuedLeftTableView:tableView heightForHeaderInSection:section];
        
    } else {
        
        return 0.01f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedLeftTableView:heightForFooterInSection:)]) {
        
        return [self.delegate distribuedLeftTableView:tableView heightForFooterInSection:section];
        
    } else {
        
        return 0.01f;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedLeftTableView:viewForHeaderInSection:)]) {
        
        return [self.delegate distribuedLeftTableView:tableView viewForHeaderInSection:section];
    } else {
        
        return [[UIView alloc]init];
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedLeftTableView:viewForFooterInSection:)]) {
        
        return [self.delegate distribuedLeftTableView:tableView viewForFooterInSection:section];
    } else {
        
        return [[UIView alloc]init];
    }
}

#pragma mark - collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (collectionView == _topCollectionView) {
        
        [self topIndexSign];
        
        return 1;
    } else {
        
        if ([self.delegate respondsToSelector:@selector(numberOfSectionsInDistribuedRightCollectionView:)]) {
            
            return [self.delegate numberOfSectionsInDistribuedRightCollectionView:collectionView];
        }else{
            
            return 1;
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    
    if (collectionView == _topCollectionView) {
        
        return [self.delegate numberOfItemsInDistribuedTopCollectionView:collectionView];
    } else {
        
        return [self.delegate distribuedRightCollectionView:collectionView numberOfItemsInSection:section];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    if (collectionView == _topCollectionView) {
        return [self.delegate distribuedTopCollectionView:collectionView cellForItemAtIndex:indexPath.item];
    } else {
        return [self.delegate distribuedRightCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;{
    
    if (collectionView == _rightCollectionView && [self.delegate respondsToSelector:@selector(distribuedRightCollectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        
        return [self.delegate distribuedRightCollectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (collectionView == _topCollectionView) {
        
        if (indexPath.item != self.topIndexSign.integerValue) {
            
            _leftIndexPathSign = [NSIndexPath indexPathForRow:0 inSection:0];
           
            self.topIndexSign = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
        }
        
    } else if (collectionView == _rightCollectionView) {
        
        if ([self.delegate respondsToSelector:@selector(distribuedRightCollectionViewDidSelectItemActionAtIndexPath:)]) {
            
            [self.delegate distribuedRightCollectionViewDidSelectItemActionAtIndexPath:indexPath];
        }
    }
}

// collection layout support
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    return [self.delegate distribuedCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedCollectionView:layout:insetForSectionAtIndex:)]) {
        
        return [self.delegate distribuedCollectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    } else {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedCollectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        
        return [self.delegate distribuedCollectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    } else {
        
        return 0;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedCollectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        
        return [self.delegate distribuedCollectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        
        return 0;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedCollectionView:layout:referenceSizeForHeaderInSection:)]) {
        
        return [self.delegate distribuedCollectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    } else {
        
        return CGSizeZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;{
    
    if ([self.delegate respondsToSelector:@selector(distribuedCollectionView:layout:referenceSizeForFooterInSection:)]) {
        
        return [self.delegate distribuedCollectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    } else {
        
        return CGSizeZero;
    }
}

- (void)viewWillLayoutSubviews{
    
    CGFloat collectionHeight = 0;
    //top frame
    if ([self.delegate respondsToSelector:@selector(numberOfItemsInDistribuedTopCollectionView:)] &&
        [self.delegate respondsToSelector:@selector(distribuedTopCollectionView:cellForItemAtIndex:)]) {
    
        collectionHeight += [self.delegate respondsToSelector:@selector(heightDistribuedTopCollectionView)] ? [self.delegate heightDistribuedTopCollectionView] : kDistribuedTopCollectionViewHeight;
        self.topCollectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), collectionHeight);
    }
    
    CGFloat leftWidth = kDistribuedLeftTableViewWidth;
    //down frame
    if ([self.delegate respondsToSelector:@selector(widthDistribuedLeftTableView)]) {
        
        leftWidth = [self.delegate widthDistribuedLeftTableView];
    }
    self.leftTableView.frame = CGRectMake(0, collectionHeight, leftWidth, CGRectGetHeight(self.view.frame) - collectionHeight);
    
    self.rightCollectionView.frame = CGRectMake(leftWidth, collectionHeight,CGRectGetWidth(self.view.frame) - leftWidth, CGRectGetHeight(self.view.frame) - collectionHeight);
}

@end
