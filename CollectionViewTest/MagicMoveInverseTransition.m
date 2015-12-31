//
//  MagicMoveInverseTransition.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/31.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "MagicMoveInverseTransition.h"
#import "YDCollectionViewCell.h"
#import "DetailViewController.h"
#import "YDCollectionViewController.h"

@implementation MagicMoveInverseTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DetailViewController *fromVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YDCollectionViewController *toVC = (YDCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //创建截图
    UIView *snapShotView = [fromVC.detailImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [containerView convertRect:fromVC.detailImageView.frame fromView:fromVC.view];
    fromVC.detailImageView.hidden = YES;
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    YDCollectionViewCell *cell = (YDCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.imageView.hidden = YES;
    
//    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        snapShotView.frame = toVC.finalCellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.detailImageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
