
//
//  ShaveOffViewCotroller.m
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/30.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//

#import "ShaveOffView.h"
#import "ShaveOffViewCotroller.h"
@interface ShaveOffViewCotroller()
/**
 *  shaveOffView
 */
@property(nonatomic,strong)ShaveOffView* shaveOffView;

@end
@implementation ShaveOffViewCotroller


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.shaveOffView.promptImage = [UIImage imageNamed:@"Prompt"];
    self.shaveOffView.resultImage = [UIImage imageNamed:@"10"];
   [self.view addSubview:self.shaveOffView];
    
    CGFloat value = 240/255.0;
    self.view.backgroundColor = [UIColor colorWithRed:(value) green:(value) blue:(value) alpha:1];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-80)*0.5, (self.view.bounds.size.height-80-20), 80, 20)];
    
    [btn setTitle:@"还原" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

-(void)btnClick
{
    NSInteger randomValue =  arc4random_uniform(100)%10;
    
    switch (randomValue) {
        case 1:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"10"];
            break;
        case 2:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"20"];
            break;
        case 3:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"30"];
            break;
        case 4:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"50"];
            break;
        case 5:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"100"];
            break;
        case 6:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"200"];
            break;
        case 7:
            self.shaveOffView.resultImage = [UIImage imageNamed:@"300"];
            break;
        default:
            self.shaveOffView.resultContent = @"抱歉，大奖与您擦肩而过";
            break;
    }
    [self.shaveOffView reloadToOrigin];

}

-(ShaveOffView *)shaveOffView
{
    if (_shaveOffView ==nil) {
        _shaveOffView = [[ShaveOffView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 150)];
        
    }
    return _shaveOffView;
}

@end
