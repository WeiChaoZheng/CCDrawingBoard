//
//  DrawingApp.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/16.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "DrawingApp.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface DrawingApp()
{
    NSMutableArray *_pathArr;
    UIBezierPath *_currentPath;//当前路径


    
    //调色板的View
    
    NSMutableArray *penwidth;
    NSMutableArray *pencolor;
    BOOL paletteFlag;
    CGContextRef context;
    int currentPathCount;
    BOOL flag ;
    //截屏图片
    UIImage * _image;
}

@end
@implementation DrawingApp
//重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;//用户的交互的开启
        self.multipleTouchEnabled = YES;//多点触控开启
        
        //初始化路径数组
        _pathArr = [NSMutableArray new];
        _paletteView = [[PaletteView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-85, 170, 170, 190)];
        _paletteView.hidden = YES;
        //让它的透明度为0
        _paletteView.alpha = 0;
        paletteFlag = NO;
        penwidth = [NSMutableArray array];
        pencolor = [NSMutableArray array];
        currentPathCount = 0;
        flag =YES;
        //工具栏按钮
        //撤销
        UIImage *undoBarButtonImage = [[UIImage imageNamed:@"undo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//总是取消图片的渲染,下同.
        _undoBarButton = [[UIBarButtonItem alloc] initWithImage:undoBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(undoBarButtonAction)];
        
        
        //调色板
        UIImage *paletteBarImage = [[UIImage imageNamed:@"palette"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        _paletteBarButton =[[UIBarButtonItem alloc] initWithImage:paletteBarImage style:UIBarButtonItemStylePlain target:self action:@selector(paletteBarButtonAction)];
        
        //截屏
        UIImage *captureBarImage = [[UIImage imageNamed:@"capture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _captureBarButton = [[UIBarButtonItem alloc] initWithImage: captureBarImage style:UIBarButtonItemStylePlain target:self action:@selector(captureBarButtonAction)];
        
        
        
        //分享
        UIImage *shareBarImage = [[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _shareBarButton = [[UIBarButtonItem alloc] initWithImage:shareBarImage style:UIBarButtonItemStylePlain target:self action:@selector(shareBarButtonAction)];
        
        [self addSubview:_paletteView];
    }
    return self;
}
//重绘
-(void)drawRect:(CGRect)rect
{
    /*
//    self.backgroundColor = [UIColor clearColor];
    //获取到画板

//    context = UIGraphicsGetCurrentContext();

//    NSLog(@"%p",context);
    //绘线
//    for (int k = 0; k < _facesArr.count; k++)
//    {
//        //设置画笔的颜色和大小
//        CGContextSetLineWidth(context, [penwidth[k] floatValue]);//大小
//        CGContextSetStrokeColorWithColor(context, [pencolor[k] CGColor]);//颜色
//        
//        //画一个页面
//        NSArray *lineSArr = _facesArr[k];
//        for (int i = 0; i < lineSArr.count; i++)
//        {
//            //画一条线
//            NSArray *pointArr = lineSArr[i];
//            //拿到第一个点
//            CGContextMoveToPoint(context, [pointArr[0] CGPointValue].x, [pointArr[0] CGPointValue].y);
//            for (int j = 1; j < pointArr.count; j++)
//            {
//                CGContextAddLineToPoint(context, [pointArr[j] CGPointValue].x, [pointArr[j] CGPointValue].y);
//            }
//            //执行画线
//            CGContextStrokePath(context);
//            NSLog(@"1");
//        }
//        
////    }
//
////    [self drawing];
//    NSLog(@"dd");
//    
//
    */
    for (int i = 0; i < _pathArr.count; i++)
    {
         UIBezierPath *path = _pathArr[i];//拿到路径的对象
        [pencolor[i] setStroke];//设置颜色
        [path  setLineWidth:[penwidth[i] floatValue]];//设置宽度
        [path stroke];//画线
        
    }
   
    
    
    
    
}
//开始点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*
     参数解释
     touches是触控点对象的集合,如果是多点触控的话,这就是多个对象,如果只是单点,就只有一个对象
     event UIEvent 事件类
     
     */
    //返回所有触控点对象的集合个数
    //初始化线数组
    
//    //当开始点击的时候记录点击的点

    //只有一个对象
    UITouch *touch = touches.anyObject;
    //获取第一个点
//    [_pointArr addObject:[NSValue valueWithCGPoint:[touch locationInView:self]]];
    
    //新创建一个空的路径对象,加进pathArr
    UIBezierPath *path = [UIBezierPath bezierPath];
    _currentPath = path;
    [_pathArr addObject:path];
    [path moveToPoint:[touch locationInView:self]];//为path对象设定第一个点(移动到当前点)
    
    //设置路径的属性

    
    [penwidth addObject:[NSNumber numberWithFloat:_paletteView.penWidthView.frame.size.width]];
    [pencolor addObject:_paletteView.penWidthView.backgroundColor];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //假设只有一个对象,不支持多点触控
    UITouch *touch = touches.anyObject;
    [_currentPath addLineToPoint:[touch locationInView:self]];
    
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    currentPathCount++;
    NSLog(@"%@",_pathArr);
}

//调色板触发按钮
-(void)paletteBarButtonAction
{
    if (!paletteFlag)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            _paletteView.hidden = NO;//取消隐藏
            _paletteView.alpha = 1;
            _paletteView.frame = CGRectMake(_paletteView.frame.origin.x, _paletteView.frame.origin.y+50, _paletteView.frame.size.width, _paletteView.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            NSLog(@"调色板调出完成!");
            paletteFlag = YES;
            
        }];

    } else
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _paletteView.frame = CGRectMake(_paletteView.frame.origin.x, _paletteView.frame.origin.y-50, _paletteView.frame.size.width, _paletteView.frame.size.height);
            _paletteView.alpha = 0;//透明度变成0
            
        } completion:^(BOOL finished) {
            NSLog(@"调色板回收成功!");
            _paletteView.hidden = YES;
            paletteFlag = NO;
        }];

    }
}
///撤销按钮
-(void)undoBarButtonAction
{
    [_pathArr removeLastObject];
    [penwidth removeLastObject];
    [pencolor removeLastObject];
    //重新调用重绘方法
    [self setNeedsDisplay];
    NSLog(@"撤销");
}

-(void)drawing
{
//    //绘线
//    for (int k = faceCount; k < _facesArr.count; k++)
//    {
//        //设置画笔的颜色和大小
//        CGContextSetLineWidth(context, [penwidth[k] floatValue]);//大小
//        CGContextSetStrokeColorWithColor(context, [pencolor[k] CGColor]);//颜色
//        
//        //画一个页面
//        NSArray *lineSArr = _facesArr[k];
//        for (int i = 0; i < lineSArr.count; i++)
//        {
//            //画一条线
//            NSArray *pointArr = lineSArr[i];
//            //拿到第一个点
//            CGContextMoveToPoint(context, [pointArr[0] CGPointValue].x, [pointArr[0] CGPointValue].y);
//            for (int j = 1; j < pointArr.count; j++)
//            {
//                CGContextAddLineToPoint(context, [pointArr[j] CGPointValue].x, [pointArr[j] CGPointValue].y);
//            }
//            //执行画线
//            CGContextStrokePath(context);
//            NSLog(@"1");
//        }
//        
//    }
    
    

}
//截屏按钮
-(void)captureBarButtonAction
{
    NSLog(@"截屏");
    
    //获取需要截取的图片大小
        CGSize imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width+10, [UIScreen mainScreen].bounds.size.height-108);
        if ( (&UIGraphicsBeginImageContextWithOptions))
        {
            UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        }
        else
        {
//            UIGraphicsBeginImageContext(imageSize);
        }
         context = UIGraphicsGetCurrentContext();
        for (UIWindow * window in [[UIApplication sharedApplication] windows]) {
            if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, [window center].x, [window center].y-64);
                CGContextConcatCTM(context, [window transform]);
                CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
                [[window layer] renderInContext:context];
                CGContextRestoreGState(context);
            }
        }
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
        _image = image;
        NSLog(@"Suceeded!");
        
    
}
//分享按钮
-(void)shareBarButtonAction
{
    NSLog(@"分享");
    //1、创建分享参数
    if (!_image)
    {
        [self captureBarButtonAction];
    }
//    NSArray* imageArray = @[_image];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (_image) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:_image
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}
@end
