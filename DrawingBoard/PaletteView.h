//
//  PaletteView.h
//  DrawingBoard
//
//  Created by ibokan on 16/1/22.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaletteView : UIView
//调色板的控件
@property(nonatomic,strong)UISlider *redSlider;
@property(nonatomic,strong)UISlider *greenSlider;
@property(nonatomic,strong)UISlider *blueSlider;
@property(nonatomic,strong)UISlider *penWidthSlider;
//固定颜色的按钮
@property(nonatomic,strong)UIButton *colorButton;
//用于显示画笔大小和颜色的view
@property(nonatomic,strong)UIView *penWidthView;

@end
