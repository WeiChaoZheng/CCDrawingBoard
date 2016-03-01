//
//  AppDelegate.m
//  DrawingBoard
//
//  Created by ibokan on 16/1/16.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    LoginViewController *LoginVC = [LoginViewController new];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:LoginVC];
    [self.window makeKeyAndVisible];
    
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"e6eeb7e7d63e"
             withSecret:@"a8ded62dbe5c9e7ba17edaaa788204ff"];
    
    [ShareSDK  registerApp:@"f6ea82c53e06" activePlatforms:@[@(SSDKPlatformTypeQQ),
                                                             @(SSDKPlatformTypeWechat),
                                                             @(SSDKPlatformSubTypeQZone),
                                                             @(SSDKPlatformTypeSinaWeibo)]
                  onImport:^(SSDKPlatformType platformType)
    {
        switch (platformType)
        {
                //新浪微博
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                //QQ
            case SSDKPlatformSubTypeQZone:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
                //微信
            case SSDKPlatformSubTypeWechatSession:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            
            default:
                break;
        }
        
    }
           onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
    {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                          appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                      appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"100371282"
                                     appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                   authType:SSDKAuthTypeBoth];
                break;
                
            default:
                break;
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
