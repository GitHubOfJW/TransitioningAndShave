//
//  ShaveOffView.h
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/30.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShaveOverLayView : UIView
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
 *  刮层颜色
 */
@property(nonatomic,strong)UIColor* shaveOffColor;


-(void)reloadToOrigin;

/**
 *  resultCheckRectArray
 */
@property(nonatomic,strong)NSMutableArray<NSValue*>* resultCheckRectArray;


/**
 *  promptImage
 */
@property(nonatomic,strong)UIImage* promptImage;
@end
