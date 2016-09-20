//
//  JWCellToDetailTransitioning.m
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "JWCellToDetailTransitioning.h"
@interface JWCellToDetailTransitioning()
/**
 *  sourceView
 */
@property(nonatomic,strong)UIView* sourceView;

/**
 *  fromFrame
 */
@property(nonatomic,assign)CGRect fromFrame;

/**
 *  toFrame
 */
@property(nonatomic,assign)CGRect toFrame;

/**
 *  isPush
 */
@property(nonatomic,assign)BOOL isFrom;


/**
 *   Expand
 */
@property(nonatomic,assign)BOOL isExpand;
@end

@implementation JWCellToDetailTransitioning

-(instancetype)init
{
    if(self=[super init])
    {
        self.isFrom =YES;
        self.sourceView.hidden = YES;
        self.fromFrame = CGRectZero;
        self.toFrame=CGRectZero;
        self.isExpand = YES;
    }
    return self;
}

/**
 *  动画
 */
-(CGRect)addPushAnimateView:(UIView *)sourceView toFrame:(CGRect)toFrame
{
    self.isFrom =YES;
    self.isExpand = NO;
    if(!sourceView)return self.fromFrame;
    if ([sourceView isKindOfClass:[UIImageView class]]) {
        UIImageView*imageView =(UIImageView*)sourceView;
        UIImageView* sourceImageView = [[UIImageView alloc] init];
        sourceImageView.contentMode = imageView.contentMode;
        [sourceImageView setClipsToBounds:YES];
        sourceImageView.image = imageView.image;
        self.sourceView = sourceImageView;
    }else{
        self.sourceView =  [sourceView snapshotViewAfterScreenUpdates:YES];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.fromFrame = [sourceView convertRect:sourceView.bounds toView:window];
    self.sourceView.frame = self.fromFrame;
    self.toFrame = toFrame;
    
    return self.fromFrame;
    
}

/**
 *  动画
 */
-(CGRect)addPopAnimateView:(UIView *)sourceView toFrame:(CGRect)toFrame
{
    self.isFrom =NO;
    self.isExpand = NO;
    if(!sourceView)return self.fromFrame;
    if ([sourceView isKindOfClass:[UIImageView class]]) {
        UIImageView*imageView =(UIImageView*)sourceView;
        UIImageView* sourceImageView = [[UIImageView alloc] init];
        sourceImageView.contentMode = imageView.contentMode;
        [sourceImageView setClipsToBounds:YES];
        sourceImageView.image = imageView.image;
        self.sourceView = sourceImageView;
    }else{
        self.sourceView =  [sourceView snapshotViewAfterScreenUpdates:YES];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.fromFrame = [sourceView convertRect:sourceView.bounds toView:window];
    self.sourceView.frame = self.fromFrame;
    self.toFrame = toFrame;
    
    return  self.fromFrame;
}



/**
 *  添加一个动画 从指定的位置展开
 */
-(CGRect)addPushExpandAnimateView:(UIView *)sourceView
{
    self.isFrom =YES;
    self.isExpand = YES;
    if(!sourceView)return self.fromFrame;
    if ([sourceView isKindOfClass:[UIImageView class]]) {
        UIImageView*imageView =(UIImageView*)sourceView;
        UIImageView* sourceImageView = [[UIImageView alloc] init];
        sourceImageView.contentMode = imageView.contentMode;
        [sourceImageView setClipsToBounds:YES];
        sourceImageView.image = imageView.image;
        self.sourceView = sourceImageView;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.fromFrame = [sourceView convertRect:sourceView.bounds toView:window];
    if(_sourceView)
    {
        [self.sourceView removeFromSuperview];
        self.sourceView=nil;
    }
    self.sourceView.frame = self.fromFrame;
    self.toFrame = [UIScreen mainScreen].bounds;
    
    return  self.fromFrame;
}


/**
 *  展开动画
 */
-(void)pushExpandWithTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromViewController.view.frame = [UIScreen mainScreen].bounds;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.frame = [UIScreen mainScreen].bounds;
    
    UIView *containerView = [transitionContext containerView];
    containerView.frame = [UIScreen mainScreen].bounds;
    
    containerView.backgroundColor = [UIColor whiteColor];
    
    
    
    if ([[UIDevice currentDevice].systemVersion compare:@"9.0"]!=NSOrderedAscending) {
        [self viewControllerContentInsetRefresh:toViewController];
    }else{
        
    }
    
    UIView*cover  =[[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromViewController]];
    CGFloat value = 0/255.0;
    cover.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:0.6];
    self.sourceView.hidden =  NO;
    
    [containerView addSubview:fromViewController.view];
    
    [containerView addSubview:cover];
    
    [containerView addSubview:toViewController.view];
    
    [containerView addSubview:self.sourceView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    fromViewController.view.alpha = 1;
    toViewController.view.alpha = 0;
    
    CATransform3D a =CATransform3DMakeScale(0.95, 0.95, 0.95);
    CATransform3D b =CATransform3DMakeTranslation(0, 0, -15);
    [UIView animateWithDuration:duration*0.45 animations:^{
        fromViewController.view.layer.transform =CATransform3DConcat(a, b);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:duration*0.35 animations:^{
            self.sourceView.frame = cover.frame;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:duration*0.2 animations:^{
                fromViewController.view.alpha=1;
                toViewController.view.alpha= 1;
                self.sourceView.alpha = 0;
            }completion:^(BOOL finished) {
                [cover removeFromSuperview];
                fromViewController.view.layer.transform = CATransform3DIdentity;
                [self.sourceView removeFromSuperview];
                self.sourceView = nil;
                [transitionContext completeTransition:YES];
            }];
        }];
    }];
}





/**
 *  pop
 */
-(void)popWithTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromViewController.view.frame = [UIScreen mainScreen].bounds;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.frame = [UIScreen mainScreen].bounds;
    
    UIView *containerView = [transitionContext containerView];
    containerView.frame = [UIScreen mainScreen].bounds;
    
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    
    
    [containerView addSubview:self.sourceView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if ([[UIDevice currentDevice].systemVersion compare:@"9.0"]!=NSOrderedAscending) {
        
    }else{
        [self viewControllerContentInsetRefresh:toViewController];
    }
    
    toViewController.view.alpha = 0;
    fromViewController.view.alpha =1;
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1;
        self.sourceView.frame = self.toFrame;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            fromViewController.view.alpha = 0;
          
        }completion:^(BOOL finished) {
            
            fromViewController.view.alpha=1;
            [self.sourceView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
        
    }];
    
}



/**
 *  push
 */
-(void)pushWithTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromViewController.view.frame = [UIScreen mainScreen].bounds;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.frame = [UIScreen mainScreen].bounds;
    
    UIView *containerView = [transitionContext containerView];
    containerView.frame = [UIScreen mainScreen].bounds;
    
    containerView.backgroundColor = [UIColor whiteColor];
    
    
    
    if ([[UIDevice currentDevice].systemVersion compare:@"9.0"]!=NSOrderedAscending) {
        [self viewControllerContentInsetRefresh:toViewController];
    }else{
    }
    
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    [containerView addSubview:self.sourceView];
     
     NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    toViewController.view.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.alpha = 0;
        self.sourceView.frame = self.toFrame;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            toViewController.view.alpha = 1;
        }completion:^(BOOL finished) {
            
            fromViewController.view.alpha=1;
            [self.sourceView removeFromSuperview]; 
            [transitionContext completeTransition:YES];
            
        }];
    }];

}


/**
 *  适配
 */
-(void)viewControllerContentInsetRefresh:(UIViewController*)vc
{
    if (vc.navigationController&&![vc.navigationController isNavigationBarHidden]) {
        if ([vc.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)vc.view;
            scrollView.contentOffset = CGPointMake(0, -64);
        }
    }
    else if (!vc.automaticallyAdjustsScrollViewInsets){
        CGRect tempFrame = vc.view.frame;
        tempFrame.origin.y = 0;
        vc.view.frame = tempFrame;
    }
}


/**
 *  动画时长
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isExpand) {
        return 0.8;
    }
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isExpand) {//展开
        if(self.isFrom)
        {
            [self pushExpandWithTransition:transitionContext];
        }else
        {
            
        }
    }else{
        if(self.isFrom)
        {
            [self pushWithTransition:transitionContext];
        }else
        {
            [self popWithTransition:transitionContext];
        }
    }
}




-(UIView *)sourceView
{
    if (_sourceView ==nil) {
        _sourceView = [[UIView alloc] initWithFrame:CGRectMake(0, 300,[UIScreen mainScreen].bounds.size.width, 100)];
        _sourceView.backgroundColor = [UIColor whiteColor];
    }
    return _sourceView;
}
@end
