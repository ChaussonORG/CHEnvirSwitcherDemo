//
//  EnvironmentSupply.h
//  关于我的_切换环境组件
//
//  Created by 朱彦君 on 16/7/18.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletedBlock)();

typedef NS_ENUM(NSInteger , CHEnvironmentType){
    CHProductEnvironment,
    CHTestEnvironment,
    CHCustomEnvironment,
};

@interface CHEnvironmentSupply : NSObject


+ (NSString*)servicePath;

+ (void)setHostWithType:(CHEnvironmentType)type completed:(void(^)())finish;

+ (void)setHostWithCustomPath:(NSString *)url completed:(void(^)())finish;


+ (BOOL)isProductEnvironment;


+ (void)clearEnvironmentInDefault;

@end
