//
//  LoginView.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/19.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "LoginView.h"
#define Kwidth self.bounds.size.width
#define Kheight self.bounds.size.height

@interface LoginView ()


@end
@implementation LoginView

//重写initWithFrame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _userTextField = [UITextField new];
        _mmTextField = [UITextField new];
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self design];
        [self constraintAll];
        
        [self addSubview:_userTextField];
        [self addSubview:_mmTextField];
        [self addSubview:_loginBtn];
        [self addSubview:_registerBtn];
        
    }
    return self;
}
//约束
-(void)constraintAll
{
    _userTextField.translatesAutoresizingMaskIntoConstraints = NO;
    //上 50
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:_userTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:50];
//    左 50
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:_userTextField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:50];
//    右 -50
    NSLayoutConstraint *con3 = [NSLayoutConstraint constraintWithItem:_userTextField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
//    height 30
    NSLayoutConstraint *con4 = [NSLayoutConstraint constraintWithItem:_userTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:30];
    [self addConstraints:@[con1,con2,con3,con4]];
    
    
    
    _mmTextField.translatesAutoresizingMaskIntoConstraints = NO;
//    上 10
    NSLayoutConstraint *con5 = [NSLayoutConstraint constraintWithItem:_mmTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_userTextField attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    //    左 50
    NSLayoutConstraint *con6 = [NSLayoutConstraint constraintWithItem:_mmTextField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:50];
    //    右 -50
    NSLayoutConstraint *con7 = [NSLayoutConstraint constraintWithItem:_mmTextField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
    //    height 30
    NSLayoutConstraint *con8 = [NSLayoutConstraint constraintWithItem:_mmTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:30];
    [self addConstraints:@[con5,con6,con7,con8]];

    _loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    //    上 50
    NSLayoutConstraint *con9 = [NSLayoutConstraint constraintWithItem:_loginBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_mmTextField attribute:NSLayoutAttributeTop multiplier:1 constant:50];
    //    左 50
    NSLayoutConstraint *con10 = [NSLayoutConstraint constraintWithItem:_loginBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:50];
    //    width 100
    NSLayoutConstraint *con11 = [NSLayoutConstraint constraintWithItem:_loginBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100];
    //    height 30
    NSLayoutConstraint *con12 = [NSLayoutConstraint constraintWithItem:_loginBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:30];
    [self addConstraint:con9];
    [self addConstraint:con10];
    [self addConstraint:con11];
    [self addConstraint:con12];
    
    

    _registerBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    //    上 50
    NSLayoutConstraint *con13 = [NSLayoutConstraint constraintWithItem:_registerBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_mmTextField attribute:NSLayoutAttributeTop multiplier:1 constant:50];
    //    右 -50
    NSLayoutConstraint *con14 = [NSLayoutConstraint constraintWithItem:_registerBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
    //    width 100
    NSLayoutConstraint *con15 = [NSLayoutConstraint constraintWithItem:_registerBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100];
    //    height 30
    NSLayoutConstraint *con16 = [NSLayoutConstraint constraintWithItem:_registerBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:30];
    [self addConstraints:@[con13,con14,con15,con16]];

    
    
    
}
//样式的设置
-(void)design
{
    //用户名框框
//    _userTextField.layer.masksToBounds = YES;
//    _userTextField.layer.cornerRadius = 0.5;//圆角属性
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
    
    //密码框框
    _mmTextField.placeholder = @"请输入密码";
    
//    _mmTextField.layer.borderColor = [UIColor colorWithRed:143/255.0 green:190/255.0 blue:135/255.0 alpha:1].CGColor;//边框颜色
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
    
    //login
    _loginBtn.backgroundColor = [UIColor colorWithRed:176/255.0			 green:233/255.0 blue:167/255.0 alpha:1];
    _loginBtn.layer.cornerRadius = 5.0;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    //register
    _registerBtn.layer.masksToBounds = YES;
    _registerBtn.layer.cornerRadius = 5.0;
    _registerBtn.backgroundColor = [UIColor colorWithRed:176/255.0			 green:233/255.0 blue:167/255.0 alpha:1];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
