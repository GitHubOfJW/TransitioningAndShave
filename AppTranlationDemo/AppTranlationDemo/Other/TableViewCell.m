//
//  TableViewCell.m
//  ;
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
///**
// *  图片
// */
//@property(nonatomic,strong)UIImageView* guideImageView;

/**
 *  标题
 */
@property(nonatomic,strong)UILabel* titleLabel;

/**
 *  子标题
 */
@property(nonatomic,strong)UILabel* descLabel;

@end

@implementation TableViewCell

/**
 *  初始化
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //图片
        self.guideImageView= [[UIImageView alloc] init];
        self.guideImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.guideImageView setClipsToBounds:YES];
        [self.contentView addSubview:self.guideImageView];
        
        //标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        //子标题
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.numberOfLines  = 0;
        self.descLabel.font = [UIFont systemFontOfSize:10];
        self.descLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.descLabel];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
     
    
    CGFloat margin = 10;
    CGFloat imageW = (self.bounds.size.width-2*margin)*0.4;
    CGFloat imageH = self.bounds.size.height-2*margin;
    CGFloat imageX = margin;
    CGFloat imageY = margin;
    self.guideImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleX = CGRectGetMaxX(self.guideImageView.frame)+margin;
    CGFloat titleY = margin;
    CGFloat titleW = self.bounds.size.width-margin-titleX;
    CGFloat titleH = 21;
    self.titleLabel.frame =  CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat descX = titleX;
    CGFloat descY = CGRectGetMaxY(self.titleLabel.frame)+margin;
    CGFloat descW = titleW;
    CGFloat descH = self.bounds.size.height-margin - descY;
    self.descLabel.frame = CGRectMake(descX, descY, descW, descH);
    
    
}

-(void)setGuideModel:(GuideModel *)guideModel
{
    _guideModel = guideModel;
    
    self.guideImageView.image = [UIImage imageNamed:guideModel.imageName];
    
    self.titleLabel.text = guideModel.title;
    
    self.descLabel.text = guideModel.descTitle;
}
@end
