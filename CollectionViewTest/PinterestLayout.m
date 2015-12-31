//
//  PinterestLayout.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "PinterestLayout.h"
#import "PinterestLayoutAttributes.h"

static const NSInteger numberOfColumns = 2;
static const CGFloat cellPadding = 6.0;

@interface PinterestLayout ()

@property (strong, nonatomic) NSMutableArray *cache;
@property (assign, nonatomic) CGFloat contentHeight;
@property (assign, nonatomic) CGFloat contentWidth;

@end

@implementation PinterestLayout

- (NSMutableArray *)cache {
    if (_cache == nil) {
        _cache = [[NSMutableArray alloc] init];
        _contentHeight = 0.0;
    }
    
    return _cache;
}

- (CGFloat)contentWidth {
    UIEdgeInsets insets = self.collectionView.contentInset;
    return CGRectGetWidth(self.collectionView.bounds) - (insets.left + insets.right);
}

#pragma mark - 必须实现的几个方法

+ (Class)layoutAttributesClass {
    return [PinterestLayoutAttributes class];
}

- (void)prepareLayout {
    //1.只计算一次
    if (self.cache.count == 0) {
        //2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        // 每列宽度
        CGFloat columnWidth = self.contentWidth / numberOfColumns;
        NSMutableArray *xOffset = [NSMutableArray array];
        NSMutableArray *yOffset = [NSMutableArray array];
        // 其实就是xOffset就是两个,都是固定的.
        for (int column = 0; column < numberOfColumns; column++) {
            CGFloat offset = column * columnWidth;
            [xOffset addObject:@(offset)];
            [yOffset addObject:@(0)];
        }
        
        NSInteger column = 0;
        
        // 3. Iterates through the list of items in the first section
        for (int item = 0; item < [self.collectionView numberOfItemsInSection:0];item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
            //4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
            //这个width是为了计算comment的长度的.
            CGFloat width = columnWidth - cellPadding *2;
            CGFloat photoHeight = [self.delegate collectionView:self.collectionView
                                      heightForPhotoAtIndexPath:indexPath
                                                      withWidth:width];
            CGFloat annotationHeight = [self.delegate collectionView:self.collectionView
                                      heightForAnnotationAtIndexPath:indexPath
                                                           withWidth:width];
            CGFloat height = cellPadding + photoHeight + annotationHeight + cellPadding;
            
            NSNumber *offsetX = xOffset[column];
            NSNumber *offsetY = yOffset[column];
            CGRect frame = CGRectMake([offsetX floatValue], [offsetY floatValue], columnWidth, height);
            CGRect insetFrame = CGRectInset(frame, cellPadding, cellPadding);
            
            //5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            PinterestLayoutAttributes *attributes = [PinterestLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            //assigns the photoHeight property that will be passed to the collection view cells.
            attributes.photoHeight = photoHeight;
            
            attributes.frame = insetFrame;
            [self.cache addObject:attributes];
            //6. Updates the collection view content height
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
            yOffset[column] = @([offsetY floatValue] + height);
            column = column >= (numberOfColumns - 1) ? 0 : ++column;
        }
    }
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in self.cache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
    }
    return [layoutAttributes copy];
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    
//}

@end
