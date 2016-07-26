//
//  TableViewController.m
//  AppTranlationDemo
//
//  Created by 朱建伟 on 16/6/28.
//  Copyright © 2016年 zhujianwei. All rights reserved.
//
#import "ShaveOffViewCotroller.h"
#import "JWCellToDetailTransitioning.h"
#import "DetailViewController.h"
#import "TableViewCell.h"
#import "TableViewController.h"

@interface TableViewController ()<UINavigationControllerDelegate>

/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray* dataArray;

/**
 *  transitioning
 */
@property(nonatomic,strong)JWCellToDetailTransitioning* translationing;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 100;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.delegate =self;
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShaveOffViewCotroller* shaveoffVc = [[ShaveOffViewCotroller alloc] init];
//    [self.navigationController pushViewController:shaveoffVc animated:YES];
    
    TableViewCell *cell  =[self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
       CGRect tempRect = [self.translationing addPushAnimateView:cell.guideImageView toFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.width/cell.guideImageView.bounds.size.width*cell.guideImageView.bounds.size.height)];
        
        DetailViewController* detailVc = [[DetailViewController alloc]init];
        detailVc.sourceRect  = tempRect;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}




-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
        for(NSInteger i = 0;i<50;i++)
        {
            GuideModel* model = [[GuideModel alloc] init];
            model.title = [NSString stringWithFormat:@"导游张小%zd",i];
            model.descTitle = [NSString stringWithFormat:@"一个非常牛逼的导游，三岁开始带团，四岁走遍真个亚洲，5岁便能精通8国语言，6岁获取世界最佳导游奖，7岁担任中国导游协会主席兼外交部部长,他的一生充满传奇色彩%zd",i];
            model.imageName =@"1";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}


/**
 *  动画
 */
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController  animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    
    if (operation ==UINavigationControllerOperationPush) {
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
