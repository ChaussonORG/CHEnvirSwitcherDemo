    //
//  EnvironmentSupply.m
//  关于我的_切换环境组件
//
//  Created by 朱彦君 on 16/7/18.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import "CHEnvironmentSupply.h"
#define CH_KEY_CURRENTENVIROMENT [NSString stringWithFormat:@"KEY_CURRENTPATH_%@",[[CHEnvironmentSupply class] description]];

#define CH_KEY_CUSTOMENVIROMENT [NSString stringWithFormat:@"KEY_CUSTOMPATH_%@",[[CHEnvironmentSupply class] description]];

@interface CHEnvironmentSupply ()

@property (nonatomic , strong) NSString *currentEnvironment;

@end


@implementation CHEnvironmentSupply


+ (NSString*)servicePath{
   
    NSString *currentUrl = [self readCurrentEnvironmentFromDefault];
    
    if (currentUrl.length > 0) {
        
         return currentUrl;
    }

    currentUrl = [self readFromEnvironmentPlistWithKey:@"Test"];
    
    [self writeCurrentUrlToDefault:currentUrl];
    
    return  currentUrl ;
    
}

+ (NSString *)readCurrentEnvironmentFromDefault{
    
    NSString *envirKey = CH_KEY_CURRENTENVIROMENT;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *password = [user objectForKey:envirKey];
    
    return password;
}

+ (NSString *)readCustomEnvironmentFromDefault{
    
    NSString *envirKey = CH_KEY_CUSTOMENVIROMENT;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *password = [user objectForKey:envirKey];
    
    return password;
    
}
+ (void)writeCurrentUrlToDefault:(NSString *)currentUrl{
    
    NSString *envirKey = CH_KEY_CURRENTENVIROMENT;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:currentUrl forKey:envirKey];
    
}

+ (NSString *)readFromEnvironmentPlistWithKey:(NSString*)key{
    
    NSDictionary *dic = [self getDicFromLocalProject];
    
    return [dic objectForKey:key];
    
}


+ (NSDictionary *)getDicFromLocalProject{
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *plistPath = [bundle pathForResource:@"CHEnviroConfigure" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    return dic;
    
}

+ (void)setHostWithType:(CHEnvironmentType)type completed:(void(^)())finish{
    
    NSString *currentUrl ;
    
    switch (type) {
        case CHProductEnvironment:{
            
            currentUrl = [self readFromEnvironmentPlistWithKey:@"Product"];
            
            break;
        }
        case CHTestEnvironment:{
            
            currentUrl = [self readFromEnvironmentPlistWithKey:@"Test"];
            
            break;
        }
        case CHCustomEnvironment:{
            
            currentUrl = [self readCustomEnvironmentFromDefault];
            
            break;
        }
        default:
            break;
    }
    
    [self writeCurrentUrlToDefault:currentUrl];

}


+ (void)setHostWithCustomPath:(NSString *)url completed:(void(^)())finish{
    
    
    [self writeCustomUrlToDefault:url];
    
    
    [self writeCurrentUrlToDefault:url];
    
    
}

+ (void)writeCustomUrlToDefault:(NSString *)currentUrl{
    
    NSString *envirKey = CH_KEY_CUSTOMENVIROMENT;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:currentUrl forKey:envirKey];
    
}

+ (BOOL)isProductEnvironment{
    
    NSString *productUrl = [self readFromEnvironmentPlistWithKey:@"Product"];
    
    return  [[self servicePath] isEqualToString:productUrl];;
}

+ (void)clearEnvironmentInDefault{
    
    NSString *envirKey = CH_KEY_CURRENTENVIROMENT;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:@"" forKey:envirKey];
}

@end
