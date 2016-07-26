//
//  ShaveOffView.m
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/30.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#define KClipPathLineW 30

#import "ShaveOverLayView.h"

@interface ShaveOverLayView()
/**
 *  path
 */
@property(nonatomic,strong)NSMutableArray<UIBezierPath*>* clipPathArray;
 

/**
 *  滑动手势
 */
@property(nonatomic,strong)UIPanGestureRecognizer* panReg;

/**
 *  手势标记
 */
@property(nonatomic,assign)BOOL isMoving;

/**
 *  当前的path
 */
@property(nonatomic,strong)UIBezierPath* currentPath;

/**
 *  firstEnd
 */
@property(nonatomic,assign)BOOL endFlag;
@end

@implementation ShaveOverLayView
/**
 *  初始化
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
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
         *  刮层颜色
         */
        self.shaveOffColor = [UIColor redColor];//[UIColor colorWithRed:(174/255.0) green:(187/255.0) blue:(192/255.0) alpha:1];
        
        
        [self addGestureRecognizer:self.panReg];
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    
    if (self.endFlag)return;
    //结束了才能消失
    if(self.resultCheckRectArray.count==0&&!self.isMoving){
        self.endFlag = YES;
        return;
    }
    
    //画涂层
    if (self.promptImage) {
        [self.promptImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:1];
    }else{
        [self.shaveOffColor setFill];
        UIBezierPath *coverPath  = [UIBezierPath bezierPathWithRect:rect];
        [coverPath fill];
        
        //画提示文字
        NSDictionary* promptAttr = @{NSFontAttributeName:self.promptContentFont,NSForegroundColorAttributeName:self.promptContentColor};
        //计算大小
        CGSize promptSize = [self.promptContent boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:promptAttr context:nil].size;
        //画提示
        [self.promptContent drawInRect:CGRectMake((rect.size.width-promptSize.width)*0.5, (rect.size.height-promptSize.height)*0.5, promptSize.width, promptSize.height) withAttributes:promptAttr];
    }
    
    //添加截取
    [[UIColor clearColor] setStroke];
    [self.clipPathArray enumerateObjectsUsingBlock:^(UIBezierPath * _Nonnull path, NSUInteger idx, BOOL * _Nonnull stop) {
        [path strokeWithBlendMode:kCGBlendModeSourceIn alpha:1];
    }];
    
    
    if (self.isMoving) {
        //手指未松开 将本次画上
        if(self.currentPath)[self.currentPath strokeWithBlendMode:kCGBlendModeSourceIn alpha:1];
    } 
}


-(void)handlerPanReg:(UIPanGestureRecognizer*)panReg
{
   CGPoint currentPoint = [panReg locationInView:self];
    if (panReg.state == UIGestureRecognizerStateChanged) {//改变
        [self.currentPath addLineToPoint:currentPoint];//一直添加线
        [self setNeedsDisplay];//不断调用 重新绘图
        
        //检测点
        __block  NSMutableArray *m_array =[NSMutableArray array];
        [self.resultCheckRectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (CGRectContainsPoint(obj.CGRectValue, currentPoint)) {
                [m_array addObject:@(idx)];
//                NSLog(@"检测到一个");
            }
        }];
        
        if (m_array.count) {
            [m_array enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.resultCheckRectArray removeObjectAtIndex:obj.integerValue];
            }];
        }

    }else if (panReg.state ==UIGestureRecognizerStateBegan)//开始
    {
        self.currentPath = [UIBezierPath bezierPath];//创建path
        [self.currentPath setLineJoinStyle:kCGLineJoinRound];
        [self.currentPath setLineWidth:KClipPathLineW];
        [self.currentPath setLineCapStyle:kCGLineCapRound];
        [self.currentPath moveToPoint:currentPoint];
        
        self.isMoving = YES;//手势开始交互
        
        
    }else if(panReg.state==UIGestureRecognizerStateEnded||panReg.state==UIGestureRecognizerStateCancelled)//结束或取消
    { 
        //手势交互结束
        self.isMoving = NO;
        
        //手指松开 将本次涂鸦存储
        if(self.currentPath)[self.clipPathArray addObject:self.currentPath];
        
        //重画
        [self setNeedsDisplay];
        
    }
}


-(NSMutableArray<UIBezierPath *> *)clipPathArray
{
    if (_clipPathArray==nil) {
        _clipPathArray = [NSMutableArray array];
    }
    return _clipPathArray;
}

-(NSMutableArray<NSValue *> *)resultCheckRectArray
{
    if (_resultCheckRectArray==nil) {
        _resultCheckRectArray = [NSMutableArray array];
    }
    return _resultCheckRectArray;
}


-(UIPanGestureRecognizer *)panReg
{
    if (_panReg==nil) {
        _panReg  =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerPanReg:)];
        _panReg.maximumNumberOfTouches =1;
        _panReg.minimumNumberOfTouches =1;
    }
    return _panReg;
}

-(void)reloadToOrigin
{
    self.endFlag=NO;
    
    [self.clipPathArray removeAllObjects];
    
    [self setNeedsDisplay];
}



/**
 *  提示内容 The content Of prompt ,default is  刮一刮，中大奖
 */
-(void)setPromptContent:(NSString *)promptContent
{
    if (promptContent) {
        _promptContent = [promptContent copy];
        [self setNeedsDisplay];
    }
    
}

/**
 *  提示颜色
 */
-(void)setPromptContentColor:(UIColor *)promptContentColor
{
    if (promptContentColor) {
        _promptContentColor = promptContentColor;
        [self setNeedsDisplay];
    }
}


/**
 *  提示文字大小
 */
-(void)setPromptContentFont:(UIFont *)promptContentFont
{
    if (promptContentFont) {
        _promptContentFont = promptContentFont;
        [self setNeedsDisplay];
    }
}


/**
 *  刮层颜色
 */
-(void)setShaveOffColor:(UIColor *)shaveOffColor
{
    if (shaveOffColor) {
        _shaveOffColor = shaveOffColor;
        [self setNeedsDisplay];
    }
}

-(void)setPromptImage:(UIImage *)promptImage
{
    if(promptImage)
    {
        _promptImage = promptImage;
        [self setNeedsDisplay];
    }
}
@end
