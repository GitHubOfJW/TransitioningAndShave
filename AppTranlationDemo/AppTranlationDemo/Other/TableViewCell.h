//
//  TableViewCell.h
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "GuideModel.h"
#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
/**
 *  guideModel
 */
@property(nonatomic,strong)GuideModel* guideModel;

/**
 *  图片
 */
@property(nonatomic,strong)UIImageView* guideImageView;

@end
