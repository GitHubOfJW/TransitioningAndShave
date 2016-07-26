//
//  guideModel.h
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuideModel : NSObject
/**
 *  标题
 */
@property(nonatomic,copy)NSString* title;

/**
 *  自标题
 */
@property(nonatomic,copy)NSString* descTitle;


/**
 *  图片名
 */
@property(nonatomic,copy)NSString* imageName;
@end
