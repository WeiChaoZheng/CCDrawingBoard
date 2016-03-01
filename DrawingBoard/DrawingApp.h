//
//  DrawingApp.h
//  DrawingBoard
//
//  Created by ibokan on 16/1/16.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaletteView.h"
@interface DrawingApp : UIView
//调色板的View
@property(nonatomic,strong)PaletteView *paletteView;
@property(nonatomic ,strong)UIColor *penColor;
@property(nonatomic,assign)CGFloat penWidth;
//调色板按钮
@property(nonatomic,strong)UIBarButtonItem *paletteBarButton;
//撤销按钮
@property(nonatomic,strong)UIBarButtonItem *undoBarButton;
//截屏
@property(nonatomic,strong)UIBarButtonItem *captureBarButton;
//分享
@property(nonatomic,strong)UIBarButtonItem *shareBarButton;
@end
