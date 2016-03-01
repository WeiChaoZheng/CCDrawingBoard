//
//  PaletteView.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/22.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "PaletteView.h"

@implementation PaletteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10.0;
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.8];
        self.userInteractionEnabled = YES;
        _redSlider = [UISlider new];
        _greenSlider = [UISlider new];
        _blueSlider = [UISlider new];
        _colorButton = [UIButton new];
        _penWidthSlider = [UISlider new];
        _penWidthView = [UIView new];
        [self design];
        [self location];
        
        [self addSubview:_redSlider];
        [self addSubview:_greenSlider];
        [self addSubview:_blueSlider];
        [self addSubview:_colorButton];
        [self addSubview:_penWidthSlider];
        [self addSubview:_penWidthView];
        
        
        
    }
    return self;
}
//位置
-(void)location
{
    _redSlider.frame = CGRectMake(10, 20, 120, 31);
    
    
    _greenSlider.frame = CGRectMake(10, _redSlider.frame.origin.y+41, 120, 31);
    
    
    _blueSlider.frame = CGRectMake(10, _greenSlider.frame.origin.y+41, 120, 31);
    
    
    _penWidthSlider.frame = CGRectMake(10, _blueSlider.frame.origin.y+41, 120, 31);
//    _colorButton
    _penWidthView.frame = CGRectMake(150, 20, _penWidthSlider.value, 113);
    
}
//样式
-(void)design
{
    _redSlider.maximumValue = 1.0;
    _redSlider.minimumValue = 0;
    _redSlider.value = 0;
    _redSlider.tintColor = [UIColor redColor];
    _redSlider.tag = 1001;
    [_redSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    _greenSlider.maximumValue = 1.0;
    _greenSlider.minimumValue = 0;
    _greenSlider.value = 0;
    _greenSlider.tintColor = [UIColor greenColor];
    _greenSlider.tag = 1002;
    [_greenSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    _blueSlider.maximumValue = 1.0;
    _blueSlider.minimumValue = 0;
    _blueSlider.value = 0;
    _blueSlider.tintColor = [UIColor blueColor];
    _blueSlider.tag = 1003;
    [_blueSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    _penWidthSlider.maximumValue = 10;
    _penWidthSlider.minimumValue = 0;
    _penWidthSlider.value = 3;
    _penWidthSlider.tintColor = [UIColor blackColor];
    _penWidthSlider.tag = 1004;
    [_penWidthSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    _penWidthView.backgroundColor = [UIColor blackColor];
    
}

-(void)sliderAction:(UISlider*)sender
{
    switch (sender.tag)
    {
        case 1001:
        case 1002:
        case 1003:
            _penWidthView.backgroundColor = [UIColor colorWithRed:_redSlider.value green:_greenSlider.value blue:_blueSlider.value alpha:1];
            break;
        case 1004:
            _penWidthView.frame = CGRectMake(_penWidthView.frame.origin.x, _penWidthView.frame.origin.y, sender.value, _penWidthView.frame.size.height);
            break;
            
        default:
            break;
    }
}

@end
