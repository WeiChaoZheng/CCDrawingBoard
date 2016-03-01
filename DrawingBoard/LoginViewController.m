//
//  LoginViewController.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/19.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "LoginViewController.h"
#import "AnimationLoginView.h"
#import "RegisterViewController.h"
#import "DrawingViewController.h"
@interface LoginViewController ()
{
    BOOL flag;//登陆的标志
    BOOL userFlag ;//用户名输入是否正确的标志
}
@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = NO;
    userFlag = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登陆";
    
    _animationLoginView =[[AnimationLoginView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_animationLoginView];
    //为button添加点击方法
    [_animationLoginView.loginView.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_animationLoginView.loginView.registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//登陆的方法
-(void)loginBtnAction:(UIButton *)sender
{
//    //和本地的数据进行比对
//    //获取本地目录文件
//    NSString *homeDocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [homeDocumentsPath stringByAppendingPathComponent:@"UserData.txt"];
//    
//    //读取数据 (注意,这里需要dataArr,可能为空(第一次安装,未注册,创建UserData.txt文件的情况))
//    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:filePath];
//    if (dataArr == nil)
//    {
//        //弹出警告
//        [self pushErrorAlertWithMessage:@"无用户数据,请进行注册" handler:^(UIAlertAction *action) {
//            
//        }];
//    } else
//    {
//        for (NSDictionary *userData in dataArr)
//        {
//            if ([_animationLoginView.loginView.userTextField.text isEqualToString:userData[@"userName"]])
//            {
//                NSLog(@"用户名正确");
//                userFlag =YES;
//                if ([_animationLoginView.loginView.mmTextField.text isEqualToString:userData[@"password"]])
//                {
//                    NSLog(@"密码正确");
//                    flag = YES;
//                    break;
//                }
//            }
//            
//        }
//        
//        //    验证成功则登陆,不成功提示错误
//        if (flag)
//        {
//            DrawingViewController *drawingVC = [DrawingViewController new];
//            
//            [self.navigationController pushViewController:drawingVC animated:YES];
//            //标志初始化
//            flag = NO;
//            userFlag = NO;
//        }else
//        {
//            NSString *messageStr;
//            if (!userFlag)
//            {
//                messageStr = @"您输入的用户名有误";
//            }
//            else
//            {
//                messageStr =@"您输入的密码有误";
//            }
//            //调用弹出警告框的方法
//            [self pushErrorAlertWithMessage:messageStr handler:^(UIAlertAction *action) {
//                //点击确定之后执行的代码
//                
//                //如果是用户名错误,把用户名清空了,反之把密码清了,之后把标志初始化
//                if (!userFlag)
//                {
//                    _animationLoginView.loginView.userTextField.text = @"";
//                    _animationLoginView.loginView.mmTextField.text = @"";
//                }
//                else
//                {
//                    _animationLoginView.loginView.mmTextField.text = @"";
//                }
//                flag = NO;
//                userFlag = NO;
//            }];
//            
//        }
//    }
//    
    
//  这里是直接进入画板页面的代码
     DrawingViewController *drawingVC = [DrawingViewController new];
 
     [self.navigationController pushViewController:drawingVC animated:YES];


    
}
//注册的方法
-(void)registerBtnAction:(UIButton*)sender
{
    //推送到注册页面
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark - 弹出错误警告框
/**
 *  弹出警告框,只有确定一个按钮,起一个提示作用
 *
 *  @param message 需要显示的内容
 *  @param action  点击确定后需要执行的代码块
 */
-(void)pushErrorAlertWithMessage:(NSString *)message handler:(void(^)(UIAlertAction *action))action
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
    //弹出方式UIAlertControllerStyleAlert,消息框框
    UIAlertAction *alertAciton = [UIAlertAction actionWithTitle:@"确定" style:0 handler:action];
                                  
    [alertController addAction:alertAciton];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

}
@end
