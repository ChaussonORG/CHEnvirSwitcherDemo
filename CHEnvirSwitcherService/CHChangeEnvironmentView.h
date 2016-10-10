//
//  ChangeEnvironmentView.h
//  关于我的_切换环境组件
//
//  Created by 朱彦君 on 16/7/17.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHChangeEnvironmentView : UIView

@property (nonatomic , strong) UIButton *testBtn;//测试环境转换按钮

@property (nonatomic , strong) UIButton *formalBtn;//正式环境转换按钮

@property (nonatomic , strong) UIButton *otherBtn;//其他操作按钮

@property (nonatomic , strong) UITextField *CustomTestField;//用于填写自定义Url

@property (nonatomic , strong) UILabel *urlShow;//URL展示框

@property (nonatomic , strong) UIButton *cancelBtn;



- (void)show;

- (void)close;

@end
