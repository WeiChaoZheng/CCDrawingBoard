//
//  RegisterViewController.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/20.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import <SMS_SDK/SMSSDK.h>
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    _registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    _registerView.viewController = self;
    //为三个button添加方法
    //backLogin
    [_registerView.backLogin addTarget:self action:@selector(backLoginAction) forControlEvents:UIControlEventTouchUpInside];
    //获取验证码按钮
    [_registerView.validationBtn addTarget:self action:@selector(validationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮
    [_registerView.registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_registerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 注册页面的三个button的方法
-(void)backLoginAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)validationBtnAction
{
//    NSLog(@"获取验证码");
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_registerView.phoneNumber.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error)
            NSLog(@"获取验证码成功");
        else
            NSLog(@"获取失败,%@",error);
    }];
}
-(void)registerBtnAction
{
    NSLog(@"比对验证码,注册");
    [SMSSDK commitVerificationCode:_registerView.valificationCode.text phoneNumber:_registerView.phoneNumber.text zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            
            NSLog(@"验证成功");
            //写入数据到本地
            [self writeData];
        }
        else
        {
//            NSLog(@"错误信息：%@",error);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message: [NSString stringWithFormat:@"%@",error]preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"晓得咯~!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了,晓得咯~!");
            }];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:^{
                
            } ];

        }
    }];
}

#pragma mark - 写入数据到本地
//写入数据到本地的方法
-(void)writeData
{
    //获取app的本地目录
    NSString *homeDocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    NSString *filePath = [homeDocumentsPath stringByAppendingPathComponent:@"UserData.txt"];
    
    //判断是否有文件,如果有,先把它读出来,加上新的数据,再写进去
    NSMutableArray *dataArr ;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    NSDictionary *userData = @{@"userName":_registerView.userTextField.text,@"password":_registerView.mmTextField.text};
    if (isExist)
    {
        dataArr = [NSMutableArray arrayWithContentsOfFile:filePath ];
    }
    else
    {
        dataArr = [NSMutableArray array];
    }
    
    [dataArr addObject:userData];//把字典存入数组中
    BOOL isSuccess = [dataArr writeToFile:filePath atomically:YES];
    if (isSuccess) {
        NSLog(@"注册成功");
        NSLog(@"%@",filePath);
        //弹出提示,注册成功
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"恭喜您注册成功!" preferredStyle:UIAlertControllerStyleAlert];
        //弹出方式UIAlertControllerStyleAlert,消息框框
        UIAlertAction *alertAciton = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction *action) {
            
            NSLog(@"回到登陆界面");
            [self.navigationController popViewControllerAnimated:YES];
            
                    }];
        
        //添加Action
        [alertController addAction:alertAciton];
        //弹出提示框
        [self presentViewController:alertController animated:YES completion:^{
            
        }];

        
        
//        [self pushErrorAlertWithMessage:@"恭喜您注册成功!" handler:^(UIAlertAction *action) {
//            NSLog(@"回到登陆界面");
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
        
    }
    else
    {
        NSLog(@"错误");
    }

}


#pragma mark - 弹出提示框
/**
 *  弹出提示框,只有确定一个按钮,起一个提示作用
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
