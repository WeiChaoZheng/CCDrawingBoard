//
//  DrawingViewController.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/21.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingApp.h"
@interface DrawingViewController ()
{
    DrawingApp *drawingView;
}
@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    drawingView = [[DrawingApp alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:drawingView];
    
    self.navigationController.toolbarHidden = NO;
    //点击回收导航栏
    self.navigationController.hidesBarsOnTap = YES;
    //工具栏上的自动空格
    UIBarButtonItem *AotuSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    self.toolbarItems = @[drawingView.undoBarButton,AotuSpace,drawingView.paletteBarButton,AotuSpace,drawingView.captureBarButton,AotuSpace,drawingView.shareBarButton];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;//取消默认滑动返回上个页面的功能
    //为self.view添加手势,开启用户交互
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tapAction
{
    if (!drawingView.paletteView.hidden)//如果是隐藏的,跳过.不是执行回收调色板动画代码
    {
        
    }
    
}



@end
