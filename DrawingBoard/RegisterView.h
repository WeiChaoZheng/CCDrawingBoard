//
//  RegisterView.h
//  DrawingBoard
//
//  Created by ibokan on 16/1/19.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
@property(nonatomic,strong)UITextField *userTextField;
@property(nonatomic,strong)UITextField *mmTextField;
@property(nonatomic,strong)UITextField *validationMM;
@property(nonatomic,strong)UITextField *valificationCode;
@property(nonatomic,strong)UITextField *phoneNumber;
@property(nonatomic,strong)UIButton *validationBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *backLogin;
@property(nonatomic,strong)UIViewController *viewController;
@end
