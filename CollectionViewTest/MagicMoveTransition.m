//
//  MagicMoveTransition.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/31.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "YDCollectionViewCell.h"
#import "DetailViewController.h"
#import "YDCollectionViewController.h"


@implementation MagicMoveTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DetailViewController *toVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    YDCollectionViewController *fromVC = (YDCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    NSIndexPath *indexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject];
    fromVC.indexPath = indexPath;
    YDCollectionViewCell *cell = (YDCollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:indexPath];
    
    //对Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    UIView *snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    //设置第二个控制器的位置和透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.0;
    toVC.detailImageView.hidden = YES;
    
    //把动画前后的两个ViewController加到容器中,顺序很重要
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.detailImageView.frame fromView:toVC.view];
        
    } completion:^(BOOL finished) {
        //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
        toVC.detailImageView.hidden = NO;
        cell.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

@end
