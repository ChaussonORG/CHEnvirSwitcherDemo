//
//  CHAboutUsController.h
//  CHEnvirSwitcherDemo
//
//  Created by 朱彦君 on 16/7/19.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHAboutUsController : UIViewController

@property (nonatomic, strong)NSURL *url;

@property (nonatomic, strong)UIWebView *mainWebView;


- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;

/**
 * @brief 根据远端URL地址加载
 */
- (instancetype)initWithURL:(NSString *)url;


@end
