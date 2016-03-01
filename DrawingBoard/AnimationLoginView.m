//
//  AnimationLoginView.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/21.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "AnimationLoginView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface AnimationLoginView ()<UITextFieldDelegate>
{
    UIImageView *handLeftImage;
    UIImageView *handRightImage;
    UIImageView *leftImage;
    UIImageView *rightImage;
}
@end
@implementation AnimationLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
        _loginView.backgroundColor = [UIColor whiteColor];
        _loginView.tag = 800;
        _loginView.layer.borderWidth = 1;
        _loginView.layer.borderColor = [UIColor colorWithRed:143/255.0 green:190/255.0 blue:135/255.0 alpha:1].CGColor;
        
        //这是头部图片,放在loginView下面
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.frame = CGRectMake(kWidth/2-105, 100, 210, 110);
        headerImage.image = [UIImage imageNamed:@"header"];
        [self addSubview:headerImage];
        //遮眼的两只手,放在头部图片上面
        leftImage = [UIImageView new];
        leftImage.image = [UIImage imageNamed:@"left"];
        rightImage = [UIImageView new];
        rightImage.image = [UIImage imageNamed:@"right"];
        
        
        leftImage.frame = CGRectMake(kWidth/ 2 - 92, 200-11 , 40, 65);
        
        rightImage.frame = CGRectMake(kWidth/ 2 + 55, 200-11 , 40, 65);
        
        [self addSubview:leftImage];
        [self addSubview:rightImage];
        
        [self addSubview:_loginView];
        //手部的图片
        [self animationHand];
        //设置文本框代理
        _loginView.userTextField.delegate =self;
        _loginView.mmTextField.delegate = self;
        
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerAction)];
        [self addGestureRecognizer:gestureRecognizer];
        
    }
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
//手势触发方法
-(void)tapGestureRecognizerAction
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        leftImage.frame = CGRectMake(handLeftImage.frame.origin.x, handLeftImage.frame.origin.y+20, 40, 60);
        
        rightImage.frame = CGRectMake(handRightImage.frame.origin.x, handRightImage.frame.origin.y+20, 40, 60);
        
        
    } completion:^(BOOL finished) {
        NSLog(@"睁眼");
        handLeftImage.hidden = NO;
        handRightImage.hidden = NO;
    }];
    /*
     use to make the view or any subview that is the first responder resign (optionally force)
     使用的视图或任何子视图,是第一响应者辞职(可选)
     */
    // UIView 的方法 让视图或者他的子视图取消第一响应者
    [self endEditing:YES];
    
    
}

#pragma mark - 动画制作
-(void)animationHand
{
    //平放的两只手
    //左
    handLeftImage = [UIImageView new];
    handLeftImage.frame = CGRectMake(kWidth/ 2 - 92, 200 - 22, 40, 40);
    handLeftImage.image = [UIImage imageNamed:@"hand"];
    [self addSubview:handLeftImage];
    //右
    handRightImage = [UIImageView new];
    handRightImage.frame = CGRectMake(kWidth/ 2 + 55, 200 - 22, 40, 40);
    handRightImage.image = [UIImage imageNamed:@"hand"];
    [self addSubview:handRightImage];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    if ([textField isEqual:_loginView.userTextField])
    {
        //
        [UIView animateWithDuration:0.5 animations:^{
            
            leftImage.frame = CGRectMake(handLeftImage.frame.origin.x, handLeftImage.frame.origin.y+20, 40, 60);
            
            rightImage.frame = CGRectMake(handRightImage.frame.origin.x, handRightImage.frame.origin.y+20, 40, 60);
            
            
        } completion:^(BOOL finished) {
            NSLog(@"睁眼");
            handLeftImage.hidden = NO;
            handRightImage.hidden = NO;
        }];
    }
    if ([textField isEqual:_loginView.mmTextField])
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            leftImage.frame = CGRectMake(handLeftImage.frame.origin.x+43, handLeftImage.frame.origin.y-15, 40, 60);
            
            rightImage.frame = CGRectMake(handRightImage.frame.origin.x-41, handRightImage.frame.origin.y-15, 40, 60);
            
            handLeftImage.hidden = YES;
            handRightImage.hidden = YES;
            
            
        } completion:^(BOOL finished) {
            NSLog(@"闭眼");
        }];
    }
    
}

@end
