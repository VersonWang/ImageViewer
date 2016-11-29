//
//  GQBaseCollectionView.m
//  ImageViewer
//
//  Created by 高旗 on 16/11/29.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import "GQBaseCollectionView.h"

@interface GQReuseTabViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation GQReuseTabViewFlowLayout
- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end

@implementation GQBaseCollectionView {
     GQReuseTabViewFlowLayout *layouts;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    layouts  = [[GQReuseTabViewFlowLayout alloc] init];
    
    self = [super initWithFrame:frame collectionViewLayout:layouts];
    if (self) {
        [self _initViews:frame];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _initViews:self.frame];
}

- (void)_initViews:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    //去掉垂直方向的滚动条
    self.showsHorizontalScrollIndicator = NO;
    
    self.delegate = self;
    self.dataSource = self;
    
    //设置减速的方式， UIScrollViewDecelerationRateFast 为快速减速
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.selectedInexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [layouts prepareLayout];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = [dataArray copy];
    [layouts prepareLayout];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10000;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"GQBaseCellIdentifier";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    return cell;
}

#pragma mark - UIScrollView delegate

//手指离开屏幕时调用的协议方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //判断手指离开屏幕时，视图是否正在减速，如果是减速说明视图还在滚动中，如果不是则说明视图停止了
    if(!decelerate) {
        [self scrollCellToCenter];
    }
}

//已经减速停止后调用的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollCellToCenter];
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    [self getPageIndex];
}

//将单元格滚动至中间位置
- (void)scrollCellToCenter
{
    CGFloat edge = self.contentInset.right;
    
    float y = self.contentOffset.x + edge + self.frame.size.width/2;
    int row = y/self.frame.size.width;
    
    if (row < 0) {
        row = _dataArray.count;
    }
    
    if (row >= _dataArray.count) {
        row = 0;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)getPageIndex
{
    CGFloat edge = self.contentInset.right;
    
    float y = self.contentOffset.x + edge + self.frame.size.width/2;
    int row = y/self.frame.size.width;
    
    if (row >= _dataArray.count || row < 0) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    if (indexPath.row != self.selectedInexPath.row) {
        if (self.block) {
            self.block(row);
        }
        //记录选中的单元格IndexPath
        self.selectedInexPath = indexPath;
    }
}

@end
