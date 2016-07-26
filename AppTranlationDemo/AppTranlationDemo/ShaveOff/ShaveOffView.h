//
//  ShaveOffView.h
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/30.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShaveOffView : UIView

/**
 *  结果图片
 */
@property(nonatomic,assign)UIImage* resultImage;


/**
 *  提示图片
 */
@property(nonatomic,assign)UIImage* promptImage;


/**
 *  提示内容 The content Of prompt ,default is  刮一刮，中大奖
 */
@property(nonatomic,copy)NSString* promptContent;

/**
 *  提示颜色 
 */
@property(nonatomic,strong)UIColor* promptContentColor;


/**
 *  提示文字大小
 */
@property(nonatomic,strong)UIFont* promptContentFont;


/**
 *  结果内容
 */
@property(nonatomic,copy)NSString* resultContent;


/**
 *  结果内容颜色
 */
@property(nonatomic,strong)UIColor* resultContentColor;


/**
 *  结果文字大小
 */
@property(nonatomic,strong)UIFont* resultContentFont;

/**
 *  刮层颜色
 */
@property(nonatomic,strong)UIColor* shaveOffColor;

-(void)reloadToOrigin;

@end
