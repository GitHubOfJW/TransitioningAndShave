//
//  DetailViewController.m
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "ShaveOffViewCotroller.h"
#import "JWCellToDetailTransitioning.h"
#import "TableViewCell.h"
#import "DetailViewController.h"

@interface DetailViewController ()<UINavigationControllerDelegate>

/**
 *  transitioning
 */
@property(nonatomic,strong)JWCellToDetailTransitioning* translationing;
/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray* dataArray;

/**
 *  头部
 */
@property(nonatomic,strong)UIImageView* headView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<--" style:(UIBarButtonItemStyleDone) target:self action:@selector(left)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = 100;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for(NSInteger i = 0;i<50;i++)
        {
            GuideModel* model = [[GuideModel alloc] init];
            model.title = [NSString stringWithFormat:@"导游张小%zd",i];
            model.descTitle = [NSString stringWithFormat:@"一个非常牛逼的导游，三岁开始带团，四岁走遍真个亚洲，5岁便能精通8国语言，6岁获取世界最佳导游奖，7岁担任中国导游协会主席兼外交部部长,他的一生充满传奇色彩%zd",i];
            model.imageName =@"1";
            [self.dataArray addObject:model];
            
        }
        [self.tableView reloadData];
    });
}

-(void)left
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.delegate =self;
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate==self) {
        self.navigationController.delegate = nil;
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    cell.guideModel = self.dataArray[indexPath.row];
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headView.bounds.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row%2==1){
        TableViewCell *cell  =[self.tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [self.translationing addPushExpandAnimateView:cell];
        }
        ShaveOffViewCotroller* shaveoffVc = [[ShaveOffViewCotroller alloc] init];
        
        [self.navigationController pushViewController:shaveoffVc animated:YES];
        
        return;
    }
 
        [self.translationing addPopAnimateView:self.headView toFrame:self.sourceRect];
        [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
//        for(NSInteger i = 0;i<50;i++)
//        {
//            GuideModel* model = [[GuideModel alloc] init];
//            model.title = [NSString stringWithFormat:@"导游张小%zd",i];
//            model.descTitle = [NSString stringWithFormat:@"一个非常牛逼的导游，三岁开始带团，四岁走遍真个亚洲，5岁便能精通8国语言，6岁获取世界最佳导游奖，7岁担任中国导游协会主席兼外交部部长,他的一生充满传奇色彩%zd",i];
//            model.imageName =@"1";
//            [_dataArray addObject:model];
//            
//        }
    }
    return _dataArray;
}


-(UIImageView *)headView
{
    if (_headView ==nil) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.width/self.sourceRect.size.width*self.sourceRect.size.height)];
        [_headView setClipsToBounds:YES];
        _headView.image = [UIImage imageNamed:@"1"];
        _headView.contentMode  =UIViewContentModeScaleAspectFill;
    }
    return _headView;
}
 

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation==UINavigationControllerOperationPop) {
        return self.translationing;
    }else if (operation==UINavigationControllerOperationPush)
    {
        return self.translationing;
    }
    return nil;
}



-(JWCellToDetailTransitioning *)translationing
{
    if (_translationing==nil) {
        _translationing = [[JWCellToDetailTransitioning alloc]init];
    }
    return _translationing;
}
@end
