//
//  DetailViewController.m
//  CollectionViewTest
//
//  Created by 224 on 15/12/31.
//  Copyright © 2015年 zoomlgd. All rights reserved.
//

#import "DetailViewController.h"
#import "YDCollectionViewController.h"
#import "MagicMoveInverseTransition.h"

@interface DetailViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Detail";
    self.detailImageView.image = self.detailImage;
    self.navigationController.delegate = self;
    
    UIImage *patternImage = [UIImage imageNamed:@"Pattern"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            //当手慢慢划入时，我们把总体手势划入的进度告诉UIPercentDrivenInteractiveTransition 对象
            [self.percentDrivenTransition updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法
            if (progress > 0.5) {
                [self.percentDrivenTransition finishInteractiveTransition];
            }else {
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
            break;
        default:
            break;
    }
}

#pragma mark - <UINavigationControllerDelegate>

//Called to allow the delegate to return a noninteractive animator object for use during view controller transitions.
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if ([toVC isKindOfClass:[YDCollectionViewController class]]) {
        MagicMoveInverseTransition *inverseTransition = [[MagicMoveInverseTransition alloc] init];
        return inverseTransition;
    }else {
        return nil;
    }
}

//Called to allow the delegate to return an interactive animator object for use during view controller transitions.
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
        return self.percentDrivenTransition;
    }else {
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
