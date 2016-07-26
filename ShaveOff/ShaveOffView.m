//
//  ShaveOffView.m
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/30.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#define KClipPathLineW 20
#import "ShaveOverLayView.h"
#import "ShaveOffView.h"

@interface ShaveOffView()

/**
 *  shaveOverLayView
 */
@property(nonatomic,strong)ShaveOverLayView* shaveLayerView;

/**
 *  resultLabel
 */
@property(nonatomic,strong)UILabel* resultLabel;

/**
 *  图片
 */
@property(nonatomic,strong)UIImageView* resultImageView;
@end

@implementation ShaveOffView

/**
 *  初始化
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setClipsToBounds:YES];
        /**
         *  提示内容
         */
        self.promptContent = @"刮一刮，中大奖";
        
        /**
         *  提示颜色
         */
        self.promptContentColor = [UIColor whiteColor];
        
        /**
         *  提示文字大小
         */
        self.promptContentFont  =[UIFont systemFontOfSize:20];
        
        /**
         *  结果内容
         */
        self.resultContent = @"再接再厉";
        
        
        /**
         *  结果内容颜色
         */
        self.resultContentColor = [UIColor blackColor];
        
        
        /**
         *  结果文字大小
         */
        self.resultContentFont = [UIFont systemFontOfSize:20];

        
        /**
         *  刮层颜色
         */
        CGFloat r = 175/255.0;
        CGFloat g = 179/255.0;
        CGFloat b = 176/255.0;
        self.shaveOffColor = [UIColor colorWithRed:r green:g blue:b alpha:1]; 
     
        
        self.resultLabel = [[UILabel alloc] init];
        self.resultLabel.text = self.resultContent;
        self.resultLabel.font = self.resultContentFont;
        self.resultLabel.textAlignment = NSTextAlignmentCenter;
        self.resultLabel.textColor = self.resultContentColor;
        [self addSubview:self.resultLabel];
        
        self.resultImageView = [[UIImageView alloc] init];
        self.resultImageView.hidden = YES;
        self.resultImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.resultImageView];
        
        self.shaveLayerView = [[ShaveOverLayView alloc] init];
        self.shaveLayerView.shaveOffColor = self.shaveOffColor;
        self.shaveLayerView.promptContent =self.promptContent;
        self.shaveLayerView.promptContentFont =self.promptContentFont;
        self.shaveLayerView.promptContentColor = self.promptContentColor;
        [self addSubview:self.shaveLayerView];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.resultLabel.frame =self.bounds;
    self.resultImageView.frame = self.bounds;
    self.shaveLayerView.frame =  self.bounds;
    
    [self caluteCheckRectArray];
}

-(void)caluteCheckRectArray
{
    [self.shaveLayerView.resultCheckRectArray removeAllObjects];
    
    if (self.resultImage) {
        NSDictionary* attr = @{NSFontAttributeName:self.resultContentFont};
        
        CGSize size  = [self.resultContent boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
        for (NSInteger i=0; i<self.resultContent.length; i++) {
            CGFloat w  = (size.width/self.resultContent.length);
            CGFloat x  = (self.bounds.size.width-size.width)*0.5+i*w;
            CGFloat y  = (self.bounds.size.height-size.height)*0.5;
            CGFloat h  = size.height;
            CGRect checkRect = CGRectMake(x, y, w, h);
            [self.shaveLayerView.resultCheckRectArray addObject:[NSValue valueWithCGRect:checkRect]];
            
        }
        return;
    }
    
    CGSize size =  CGSizeMake(self.bounds.size.width*0.6, self.bounds.size.height*0.6);
    
    NSInteger columns = 4;
    NSInteger rows = 2;
    CGFloat w = size.width/columns;
    CGFloat h = size.height/rows;
    
    for (NSInteger i=0; i<rows; i++) {
        for (NSInteger j= 0; j<columns; j++) {
            CGFloat x  = (self.bounds.size.width-size.width)*0.5+j*w;
            CGFloat y  = (self.bounds.size.height-size.height)*0.5+i*h;
            CGRect checkRect = CGRectMake(x, y, w, h);
            [self.shaveLayerView.resultCheckRectArray addObject:[NSValue valueWithCGRect:checkRect]];
        }
    }
    

}

-(void)reloadToOrigin
{
    if (!CGRectEqualToRect(self.bounds, CGRectZero)) {
        [self caluteCheckRectArray];
    }
    [self.shaveLayerView reloadToOrigin];
}


/**
 *  提示内容 The content Of prompt ,default is  刮一刮，中大奖
 */
-(void)setPromptContent:(NSString *)promptContent
{
    if (promptContent) {
        _promptContent = [promptContent copy];
        self.shaveLayerView.promptContent =  _promptContent;
    }
    
}

/**
 *  提示颜色
 */
-(void)setPromptContentColor:(UIColor *)promptContentColor
{
    if (promptContentColor) {
        _promptContentColor = promptContentColor;
        self.shaveLayerView.promptContentColor = promptContentColor;
    }
}


/**
 *  提示文字大小
 */
-(void)setPromptContentFont:(UIFont *)promptContentFont
{
    if (promptContentFont) {
        _promptContentFont = promptContentFont;
        self.shaveLayerView.promptContentFont = promptContentFont;
    }
}


/**
 *  结果内容
 */
-(void)setResultContent:(NSString *)resultContent
{
    if (resultContent&&resultContent.length) {
        _resultContent = [resultContent copy];
        self.resultLabel.hidden =NO;
        self.resultImageView.hidden = YES;
        self.resultLabel.text = _resultContent;
    }
}

/**
 *  结果内容颜色
 */
-(void)setResultContentColor:(UIColor *)resultContentColor
{
    if (resultContentColor) {
        _resultContentColor = resultContentColor;
        self.resultLabel.textColor = resultContentColor;
    }
}


/**
 *  结果文字大小
 */
-(void)setResultContentFont:(UIFont *)resultContentFont
{
    if (resultContentFont) {
        _resultContentFont = resultContentFont;
        self.resultLabel .font = resultContentFont;
    }
}
/**
 *  刮层颜色
 */
-(void)setShaveOffColor:(UIColor *)shaveOffColor
{
    if (shaveOffColor) {
        _shaveOffColor = shaveOffColor;
        self.shaveLayerView.shaveOffColor= shaveOffColor;
    }
}

-(void)setResultImage:(UIImage *)resultImage
{
    if (resultImage) {
        self.resultImageView.image = resultImage;
        self.resultImageView.hidden = NO;
        self.resultLabel.hidden =YES;
    }
}

-(void)setPromptImage:(UIImage *)promptImage
{
    if (promptImage) {
        _promptImage = promptImage;
        self.shaveLayerView.promptImage = promptImage;
    }
}
@end
