//
//  HRSideMenuViewController.m
//  HR lib
//
//  Created by Shipin Alex on 20/10/15.
//  Copyright © 2015 HR. All rights reserved.
//

#import "HRSideMenuViewController.h"
#import "UIView(HRConstraint).h"
#import "HRSideStoryboardSegue.h"
#import <objc/runtime.h>

HRImplementationKey(hrMainMenuViewControllerSegueIdentifier);
HRImplementationKey(hrSideMenuViewControllerSegueIdentifier);

@interface UIViewController(HRSideMenuSet)

- (void)setHrSideMenuViewController:(HRSideMenuViewController *)slideMenuViewController;

@end

@implementation UIViewController(HRSideMenu)

- (void)setHrSideMenuViewController:(HRSideMenuViewController *)slideMenuViewController
{
    objc_setAssociatedObject(self, @selector(hrSideMenuViewController), slideMenuViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HRSideMenuViewController *)hrSideMenuViewController
{
    HRSideMenuViewController *slideMenuTableViewController = objc_getAssociatedObject(self, @selector(hrSideMenuViewController));
    
    if (slideMenuTableViewController)
    {
        return slideMenuTableViewController;
    }
    
    if (self.parentViewController.hrSideMenuViewController)
    {
        return self.parentViewController.hrSideMenuViewController;
    }
    
    if (self.navigationController.hrSideMenuViewController)
    {
        return self.navigationController.hrSideMenuViewController;
    }
    
    if (self.tabBarController.hrSideMenuViewController)
    {
        return self.tabBarController.hrSideMenuViewController;
    }
    
    return nil;
}

@end


@interface HRSideMenuViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIView* sideMenuView;
@property (nonatomic,weak) UIView* mainView;
@property (nonatomic,weak) UIView* grayView;

@property (nonatomic,weak)  NSLayoutConstraint* leftConstraint;

@property (nonatomic,assign, readwrite) BOOL isShowMenu;
@property (nonatomic,assign) BOOL isInit;

@property (nonatomic,strong) NSArray<UIGestureRecognizer*>* gestureRecognizer;
@property (nonatomic,weak) NSLayoutConstraint* leftPositionConstraint;
@property (nonatomic,assign) CGPoint startPositionForPan;
@property (nonatomic,assign) CGFloat positionMenu;
@property (nonatomic,strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, weak) IBOutlet HRSideStoryboardSegue* sideSegue;
@property (nonatomic, weak) IBOutlet HRSideStoryboardSegue* mainSegue;

@end

@implementation HRSideMenuViewController{
    UIViewController* _rootViewController;
    UIViewController* _sideMenuViewController;
}


- (void) loadSubview{
    if (self.isInit) {
        return;
    }
    self.isInit = YES;
    
    
    UIView* sideView = [UIView new];
    sideView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:sideView];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:sideView
                                                             attribute:(NSLayoutAttributeWidth)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeWidth)
                                                            multiplier:0.65
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:sideView
                                                             attribute:(NSLayoutAttributeLeft)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeLeft)
                                                            multiplier:1.
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:sideView
                                                             attribute:(NSLayoutAttributeBottom)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeBottom)
                                                            multiplier:1.
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:sideView
                                                             attribute:(NSLayoutAttributeTop)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeTop)
                                                            multiplier:1.
                                                              constant:0.]]];
    
    UIView* mainView = [UIView new];
    mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:mainView];
    if (self.shadow) {
        mainView.layer.masksToBounds = NO;
        mainView.layer.shadowColor = [UIColor blackColor].CGColor;
        mainView.layer.shadowOpacity = 8;
        mainView.layer.shadowRadius = 6;
        mainView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    }

    
    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:mainView
                                                             attribute:(NSLayoutAttributeLeft)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeLeft)
                                                            multiplier:1.
                                                              constant:0.];
    NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem:mainView
                                                            attribute:(NSLayoutAttributeLeft)
                                                            relatedBy:(NSLayoutRelationEqual)
                                                               toItem:sideView
                                                            attribute:(NSLayoutAttributeRight)
                                                           multiplier:1.
                                                             constant:0.];
    right.priority = 993;
    left.priority = 994;
    
    [self.view addConstraints:@[left,
                                right,
                                [NSLayoutConstraint constraintWithItem:mainView
                                                             attribute:(NSLayoutAttributeBottom)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeBottom)
                                                            multiplier:1.
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:mainView
                                                             attribute:(NSLayoutAttributeTop)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeTop)
                                                            multiplier:1.
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:mainView
                                                             attribute:(NSLayoutAttributeWidth)
                                                             relatedBy:(NSLayoutRelationEqual)
                                                                toItem:self.view
                                                             attribute:(NSLayoutAttributeWidth)
                                                            multiplier:1.
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:mainView
                                                             attribute:(NSLayoutAttributeLeft)
                                                             relatedBy:(NSLayoutRelationLessThanOrEqual)
                                                                toItem:sideView
                                                             attribute:(NSLayoutAttributeRight)
                                                            multiplier:1.
                                                              constant:0.],
                                [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:(NSLayoutAttributeRight)
                                                             relatedBy:(NSLayoutRelationLessThanOrEqual)
                                                                toItem:mainView
                                                             attribute:(NSLayoutAttributeRight)
                                                            multiplier:1.
                                                              constant:0.]]];
    
    
    
    UIView* grayView = [UIView new];
    grayView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:grayView];
    [mainView hrAddMarginConstraintSubview:grayView top:20 bottom:0 right:0 left:0];
    
    
    self.grayView = grayView;
    grayView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.5];
    self.grayView.backgroundColor = [UIColor clearColor];
    
    self.leftConstraint = right;
    self.leftPositionConstraint = left;
    self.sideMenuView = sideView;
    self.mainView = mainView;
    
    
    UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionForCloseMenu:)];
    gesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.sideMenuView addGestureRecognizer:gesture];
    gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionForCloseMenu:)];
    gesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.grayView addGestureRecognizer:gesture];
    
    gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionForOpenMenu:)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.mainView addGestureRecognizer:gesture];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPanGestureRecornizer:)];
    [self.grayView addGestureRecognizer:pan];
    UIPanGestureRecognizer* pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPanGestureRecornizer:)];
    [self.mainView addGestureRecognizer:pan2];
    UIPanGestureRecognizer* pan3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPanGestureRecornizer:)];
    [self.sideMenuView addGestureRecognizer:pan3];
    self.gestureRecognizer = @[gesture,pan,pan2,pan3];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForCloseMenu:)];
    [self.grayView addGestureRecognizer:tap];
    
    
    [self performSegueWithIdentifier:hrSideMenuViewControllerSegueIdentifier sender:self];
    [self performSegueWithIdentifier:hrMainMenuViewControllerSegueIdentifier sender:self];
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self loadSubview];
    [self setIsEnable:self.isEnable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rootViewController viewWillAppear:animated];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rootViewController viewDidAppear:animated];
    self.mainView.backgroundColor = self.view.backgroundColor;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:hrSideMenuViewControllerSegueIdentifier]) {
        self.sideMenuViewController = (id)segue.destinationViewController;
        return;
    }
    if ([segue isKindOfClass:[HRSideStoryboardSegue class]]) {
        self.rootViewController = (id)segue.destinationViewController;
        [self closeMenuWithAnimation:YES];
    }
}

- (void)setIsShowMenu:(BOOL)isShowMenu {
    _isShowMenu = isShowMenu;
    self.leftPositionConstraint.constant = 0;
    self.leftConstraint.priority = _isShowMenu?995:993;
    self.grayView.alpha = isShowMenu?1:0;
    

    //self.isEnable = isShowMenu;
   // self.mainView.userInteractionEnabled = isShowMenu;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(sideMenuViewController:openViewController:)]) {
        [self.delegate sideMenuViewController:self openViewController:(_isShowMenu?self.sideMenuViewController:self.rootViewController)];
    }
}

- (void) openMenuWithAnimation:(BOOL)isAnimation {
    [self.sideMenuViewController viewWillAppear:isAnimation];
    [self.rootViewController.view endEditing:YES];
    if (isAnimation) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.isShowMenu = YES;
                         }
                         completion:^(BOOL finished) {
                             [self.sideMenuViewController viewDidAppear:isAnimation];
                         }];
    } else {
        self.isShowMenu = YES;
        [self.sideMenuViewController viewDidAppear:isAnimation];
    }
}

- (NSInteger) topHeight{
    if ([UIScreen mainScreen].bounds.size.width == 375 &&
        [UIScreen mainScreen].bounds.size.height == 812) {
        return -44;
    }
    return -20;
}



- (void)closeMenuWithAnimation:(BOOL)isAnimation {
    [self closeMenuWithAnimation:isAnimation completionBlock:nil];
}

- (void) closeMenuWithAnimation:(BOOL)isAnimation completionBlock:(void (^)(void))completionBlock {
    [self.sideMenuViewController viewWillDisappear:isAnimation];
    if (isAnimation) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.isShowMenu = NO;
                             
                         }
         completion:^(BOOL finished) {
             [self.sideMenuViewController viewDidDisappear:isAnimation];
             if (completionBlock) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     completionBlock();
                 });
             }
         }];
    } else {
        self.isShowMenu = NO;
        [self.sideMenuViewController viewDidDisappear:isAnimation];
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }
    }
}

#pragma mark -
- (void)setRootViewController:(UIViewController *)rootViewController {
    [_rootViewController removeFromParentViewController];
    [_rootViewController.view removeFromSuperview];
    rootViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainView addSubview:rootViewController.view];
    [self addChildViewController:rootViewController];
    _rootViewController =  rootViewController;
    self.topConstraint = [self.mainView hrAddMarginConstraintSubview:_rootViewController.view].firstObject;
     [_rootViewController didMoveToParentViewController:self];
    _rootViewController.hrSideMenuViewController = self;
    [self.mainView bringSubviewToFront:self.grayView];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)setSideMenuViewController:(UIViewController *)sideMenuViewController {
    [_sideMenuViewController removeFromParentViewController];
    [_sideMenuViewController.view removeFromSuperview];
    sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.sideMenuView addSubview:sideMenuViewController.view];
    [self addChildViewController:sideMenuViewController];
    _sideMenuViewController = sideMenuViewController;
    [self.sideMenuView hrAddMarginConstraintSubview:_sideMenuViewController.view];
    _sideMenuViewController.hrSideMenuViewController = self;
    [_sideMenuViewController didMoveToParentViewController:self];
    
}



- (UIViewController *)sideMenuViewController {
    [self loadSubview];
    return _sideMenuViewController;
}

- (UIViewController *)rootViewController {
    [self loadSubview];
    return _rootViewController;
}

- (void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
    for (UIGestureRecognizer* gr in self.gestureRecognizer) {
        gr.enabled = isEnable;
    }
}



#pragma mark - action
- (void) actionPanGestureRecornizer:(UIPanGestureRecognizer*)sender {
    CGPoint point = [sender locationInView:self.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startPositionForPan = point;
        self.positionMenu = (self.mainView.frame.origin.x - self.view.frame.origin.x );
        
        if ([self.delegate respondsToSelector:@selector(sideMenuViewController:openViewController:)]) {
            [self.delegate sideMenuViewController:self openViewController:(self.sideMenuViewController)];
        }
    } else if (sender.state == UIGestureRecognizerStateEnded ||
               sender.state == UIGestureRecognizerStateCancelled) {
        CGPoint v = [sender velocityInView:self.view];
        if (v.x > 0) {
            [self openMenuWithAnimation:YES];
        } else {
            [self closeMenuWithAnimation:YES];
        }
    } else {
        self.leftConstraint.priority = 993;
        self.leftPositionConstraint.constant =  (self.positionMenu + (point.x - self.startPositionForPan.x));
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        self.grayView.alpha = (self.mainView.frame.origin.x /  self.sideMenuView.frame.size.width);
    }
}

- (void) actionForOpenMenu:(id) sender{
    [self openMenuWithAnimation:YES];
}

- (void) actionForCloseMenu:(id) sender{
    [self closeMenuWithAnimation:YES];
}



@end
