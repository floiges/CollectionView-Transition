//
//  YDCollectionViewController.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/29.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "YDCollectionViewController.h"
#import "YDCollectionViewCell.h"
#import "Photo.h"
#import "CollectionHeaderView.h"
#import "DetailViewController.h"
#import "MagicMoveTransition.h"

#import <AVFoundation/AVFoundation.h>

@interface YDCollectionViewController ()<UINavigationControllerDelegate>{
    NSArray *_photos;
}

@end

@implementation YDCollectionViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    PinterestLayout *layout = (PinterestLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    
    self.navigationItem.title = @"Pinterest";
    _photos = [Photo allPhotos];
    
    UIImage *patternImage = [UIImage imageNamed:@"Pattern"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(23, 5, 10, 5);
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    _photos = nil;
}

#pragma mark - prepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *vc = [segue destinationViewController];
    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    Photo *photo = _photos[indexPath.item];
    vc.detailImage = photo.image;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"myCell";
    YDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.photo = _photos[indexPath.item];
    
    return cell;
}


#pragma mark <PinterestLayoutDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForPhotoAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    Photo *photo = _photos[indexPath.item];
    CGRect boundingRect = CGRectMake(0, 0, width, MAXFLOAT);
    //根据image的比例进行居中显示, 如果没用这个函数, 要自己计算一下
    CGRect rect = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect);
    return rect.size.height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForAnnotationAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    CGFloat annotationPadding = 4;
    CGFloat annotationHeaderHeight = 17;
    Photo *photo = _photos[indexPath.item];
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:10];
    CGFloat commentHeight = [photo heightForCommentWithFont:font andWidth:width];
    CGFloat height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding;
    return height;
}

#pragma mark <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[DetailViewController class]]) {
        MagicMoveTransition *transition = [[MagicMoveTransition alloc] init];
        return transition;
    }else {
        return nil;
    }
}

@end
