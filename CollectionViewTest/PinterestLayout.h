//
//  PinterestLayout.h
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PinterestLayoutDelegate <NSObject>

//图片高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
heightForPhotoAtIndexPath:(NSIndexPath *)indexPath
                withWidth:(CGFloat)width;
//文字高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
heightForAnnotationAtIndexPath:(NSIndexPath *)indexPath
                withWidth:(CGFloat)width;

@end

@interface PinterestLayout : UICollectionViewLayout

@property (weak, nonatomic) id<PinterestLayoutDelegate> delegate;

@end
