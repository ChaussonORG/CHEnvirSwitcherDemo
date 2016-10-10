//
//  UIViewController+EnvironmentSwitcher.m
//  CHEnvirSwitcherDemo
//
//  Created by 朱彦君 on 16/7/19.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import "UIViewController+EnvironmentSwitcher.h"
#import "CHChangeEnvironmentView.h"

#import <objc/runtime.h>


static CHChangeEnvironmentView *obj;
@implementation UIViewController (EnvironmentSwitcher)


+ (void)openEnvironmentSwitcher{

    obj = [CHChangeEnvironmentView new];
    [obj show];
    
}



+ (void)closeEnvironmentSwitcher{
    
    
    [obj close];
    

}


@end
