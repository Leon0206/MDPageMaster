//
//  XYPageMasterNavigationController.m
//  XYPageMaster
//
//  Created by lizitao on 2018/5/7.
//

#import "XYPageMasterNavigationController.h"

@interface XYPageMasterNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation XYPageMasterNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.interactivePopGestureRecognizer.delegate = weakSelf;
}

- (BOOL)shouldAutorotate
{
    return  NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        return YES;
    }
    return NO;//UIInterfaceOrientationPortrait;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    NSArray *chidVC = self.childViewControllers;
    if(chidVC.count == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (void)popToViewController:(UIViewController *)viewController withAnimation:(BOOL)animated
{
    if (!viewController) return;
    [super popToViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController withAnimation:(BOOL)animated
{
    if (!viewController) return;
    [super pushViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController withTransition:(XYNaviTransition *)naviTransition
{
    if (!viewController) return;
    if (naviTransition.animation == XYNaviAnimationTransition) {
        if (naviTransition.transition != nil) {
            [self.view.layer addAnimation:naviTransition.transition forKey:kCATransition];
            [self pushViewController:viewController animated:NO];
            return;
        }
    }
    [super pushViewController:viewController animated:(naviTransition.animation == XYNaviAnimationPush)];
}

- (void)popToViewController:(UIViewController *)viewController withTransition:(XYNaviTransition *)naviTransition
{
    if (naviTransition.animation == XYNaviAnimationTransition) {
        if (naviTransition.transition != nil) {
            [self.view.layer addAnimation:naviTransition.transition forKey:kCATransition];
            [self popToViewController:viewController animated:NO];
            return;
        }
    }
    [self popToViewController:viewController animated:(naviTransition.animation == XYNaviAnimationPush)];
}

- (void)popCurrentViewControllerWithTransition:(XYNaviTransition *)naviTransition
{
    if (naviTransition.animation == XYNaviAnimationTransition) {
        if (naviTransition.transition != nil) {
            [self.view.layer addAnimation:naviTransition.transition forKey:kCATransition];
            [self popViewControllerAnimated:NO];
            return;
        }
    }
    [self popViewControllerAnimated:naviTransition.animation == XYNaviAnimationPush];
}

- (void)popToHomeViewControllerWithTransition:(XYNaviTransition *)naviTransition
{
    if (naviTransition.animation == XYNaviAnimationTransition) {
        if (naviTransition.transition != nil) {
            [self.view.layer addAnimation:naviTransition.transition forKey:kCATransition];
            [self popToRootViewControllerAnimated:NO];
            return;
        }
    }
    [self popToRootViewControllerAnimated:naviTransition.animation == XYNaviAnimationPush];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
