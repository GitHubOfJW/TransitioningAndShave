//
//  JWCellToDetailTransitioning.h
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JWCellToDetailTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
/**
 *  添加一个view 动画 从 一个frame 移动到下一个frame
 */
-(CGRect)addPushAnimateView:(UIView*)sourceView toFrame:(CGRect)toFrame;


/**
 *  添加一个View 动画 从一个frame  移动到下一个frame
 */
-(CGRect)addPopAnimateView:(UIView*)sourceView toFrame:(CGRect)toFrame;

/**
 *  添加一个动画 从指定的位置展开
 */
-(CGRect)addPushExpandAnimateView:(UIView *)sourceView;

@end
