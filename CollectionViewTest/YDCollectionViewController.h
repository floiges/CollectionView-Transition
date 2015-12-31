//
//  YDCollectionViewController.h
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinterestLayout.h"

@interface YDCollectionViewController : UICollectionViewController<PinterestLayoutDelegate>

@property (nonatomic,assign) CGRect finalCellRect;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
