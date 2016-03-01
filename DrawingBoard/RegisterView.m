//
//  RegisterView.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/19.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView ()<UITextFieldDelegate>

@end
@implementation RegisterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _userTextField = [UITextField new];
        _userTextField.tag = 2000;
        _mmTextField = [UITextField new];
        _mmTextField.tag = 2001;
        _validationMM = [UITextField new];//再次输入的验证密码
        _validationMM.tag = 2002;
        _phoneNumber = [UITextField new];
        _phoneNumber.tag = 2003;
        _valificationCode = [UITextField new];
        _valificationCode.tag = 2004;
        
        
        //验证按钮
        _validationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //注册按钮
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //返回登陆页面
        _backLogin = [UIButton buttonWithType:UIButtonTypeSystem];
        
        
        [self design];
        [self locationAll];
        
        [self addSubview:_userTextField];
        [self addSubview:_mmTextField];
        [self addSubview:_validationMM];
        [self addSubview:_valificationCode];
        [self addSubview:_phoneNumber];
        //设置代理
        _userTextField.delegate =self;
        _mmTextField.delegate = self;
        _validationMM.delegate = self;
        _valificationCode.delegate =self;
        _phoneNumber.delegate = self;
        [self addSubview:_validationBtn];
        [self addSubview:_registerBtn];
        [self addSubview:_backLogin];
    }
    return self;
}
//样式设计
-(void)design
{
//用户名输入框
    _userTextField.placeholder = @"请输入用户名";
    
    _userTextField.layer.borderColor = [UIColor colorWithRed:143/255.0 green:190/255.0 blue:135/255.0 alpha:1].CGColor;//边框颜色
    _userTextField.borderStyle = UITextBorderStyleRoundedRect;//系统样式的边框自带圆角不透明白色背景
    //设置用户小图像
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    imageView1.frame = CGRectMake(5, 5, 20,20);
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [view1 addSubview:imageView1];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;//图片自适应View大小
    _userTextField.leftView = view1;
    _userTextField.leftViewMode = UITextFieldViewModeAlways;//总是显示leftView
    _userTextField.returnKeyType = UIReturnKeyDone;
    
//密码框框1
    _mmTextField.placeholder = @"请输入密码";
    
    _mmTextField.borderStyle = UITextBorderStyleRoundedRect;//系统样式的边框自带圆角不透明白色背景
    //设置密码小图像
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pass"]];
    
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.frame = CGRectMake(5, 5, 20,20);
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [view2 addSubview:imageView2];
    _mmTextField.leftView = view2;
    
    _mmTextField.leftViewMode = UITextFieldViewModeAlways;//总是显示leftView
    _mmTextField.returnKeyType = UIReturnKeyDone;
    //隐藏输入
    _mmTextField.secureTextEntry = YES;
    //再次编辑就清空
    _mmTextField.clearsOnBeginEditing = YES;
    
    
//密码框框2
    _validationMM.placeholder = @"请再次输入密码";
    _validationMM.borderStyle = UITextBorderStyleRoundedRect;//系统样式的边框自带圆角不透明白色背景
    //设置密码小图像
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pass"]];
    
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.frame = CGRectMake(5, 5, 20,20);
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [view3 addSubview:imageView3];
    _validationMM.leftView = view3;
    
    _validationMM.leftViewMode = UITextFieldViewModeAlways;//总是显示leftView
    _validationMM.returnKeyType = UIReturnKeyDone;
    //隐藏输入
    _validationMM.secureTextEntry = YES;
    //再次编辑就清空
    _validationMM.clearsOnBeginEditing = YES;
    
//验证码输入框
    _valificationCode.placeholder = @"请输入验证码";
    _valificationCode.adjustsFontSizeToFitWidth = YES;
    _valificationCode.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//数字和标点符号键盘
    _valificationCode.borderStyle = UITextBorderStyleRoundedRect;//系统样式的边框自带圆角不透明白色背景
    _valificationCode.returnKeyType = UIReturnKeyDone;

    //再次编辑就清空
    _valificationCode.clearsOnBeginEditing = YES;
    
//手机号码输入框
    _phoneNumber.placeholder = @"请输入电话号码";
    
    _phoneNumber.adjustsFontSizeToFitWidth = YES;
    _phoneNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumber.returnKeyType = UIReturnKeyDone;
    
//验证码按钮
    _validationBtn.layer.masksToBounds =YES;
    _validationBtn.layer.cornerRadius = 5.0;
    [_validationBtn setTitle:@"获取验证码" forState:0];
    _validationBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_validationBtn setTitleColor:[UIColor whiteColor] forState:0];
    _validationBtn.backgroundColor = [UIColor colorWithRed:176/255.0 green:233/255.0 blue:167/255.0 alpha:1];
//注册按钮
    _registerBtn.layer.masksToBounds = YES;
    _registerBtn.layer.cornerRadius = 5.0;
    [_registerBtn setTitle:@"注册" forState:0];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:0];
    _registerBtn.backgroundColor = [UIColor colorWithRed:176/255.0 green:233/255.0 blue:167/255.0 alpha:1];
//backLoginBtn
    _backLogin.layer.masksToBounds = YES;
    _backLogin.layer.cornerRadius = 5.0;
    [_backLogin setTitle:@"已有账号" forState:0];
    [_backLogin setTitleColor:[UIColor whiteColor] forState:0];
    _backLogin.backgroundColor = [UIColor colorWithRed:176/255.0 green:233/255.0 blue:167/255.0 alpha:1];
}
//位置
-(void)locationAll
{
    _userTextField.frame = CGRectMake(50, 50, 220, 30);
    _mmTextField.frame =CGRectMake(50, _userTextField.frame.origin.y+40, 220, 30);
    _validationMM.frame = CGRectMake(50, _mmTextField.frame.origin.y+40, 220, 30);
    //电话号码框框
    _phoneNumber.frame =CGRectMake(50, _validationMM.frame.origin.y+40, 220, 30);
    //填写验证码的框框
    _valificationCode.frame =CGRectMake(50, _phoneNumber.frame.origin.y+40, 110, 30);
    
    //验证码按钮
    _validationBtn.frame = CGRectMake(50+220-100, _phoneNumber.frame.origin.y+40, 100, 30);
    _registerBtn.frame = CGRectMake(50, _validationBtn.frame.origin.y+40, 100, 30);
    _backLogin.frame = CGRectMake(170, _validationBtn.frame.origin.y+40, 100, 30);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//将要退出文本框时调用
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    //根据文本框的类型tag不同实现其他选择方法
    switch (textField.tag)
    {
        //用户文本框
        case 2000:
            //需要检验用户名是否重复
            if ([self userNameRepeat:textField])
            {
                //弹出提示,用户名已经被注册
                [self pushErrorAlertWithMessage:@"用户名已经被注册" handler:^(UIAlertAction *action) {
                    textField.text = @"";
                }];
            }
            
            break;
        //用户密码
        case 2001:
            
            break;
        //验证用户密码
        case 2002:
            //调用密码验证的方法
            [self mmTextFieldValidation:textField];
            break;
        //电话号码框
        case 2003:
//            验证是不是11位数字
            
            break;
        //验证码框
        case 2004:
//            四位数字验证码
            
            break;
            
        default:
            break;
    }
    
    
    return YES;
}
//
-(void)mmTextFieldValidation:(UITextField *)textField
{
    if ([_mmTextField.text isEqualToString:textField.text])
    {
        NSLog(@"两次输入密码正确");
    }
    else
    {
        [self pushErrorAlertWithMessage:@"两次输入的密码不一致" handler:^(UIAlertAction *action) {
            textField.text = @"";
        }];
        
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
    [self.viewController presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

#pragma mark - 检验用户名是否重复的方法
-(BOOL)userNameRepeat:(UITextField *)textField
{
    //和本地的数据进行比对
    //获取本地目录文件
    NSString *homeDocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [homeDocumentsPath stringByAppendingPathComponent:@"UserData.txt"];
    
    //读取数据 (注意,这里需要dataArr,可能为空(第一次安装,未注册,创建UserData.txt文件的情况))
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:filePath];
    if (dataArr == nil)
    {
        //初始化
        dataArr = [NSMutableArray array];
    }else
    {
        //比对用户名数据
        for (NSDictionary *userData in dataArr)
        {
            if([textField.text isEqualToString:userData[@"userName"]])
            {
                return YES;//用户名重复,返回yes
            }
        }

        
    }

    return NO;
}
@end
