//
//  ViewController.m
//  CHEnvirSwitcherDemo
//
//  Created by 朱彦君 on 16/7/19.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import "CHViewController.h"
#import "CHAboutUsController.h"

#import "UIViewController+EnvironmentSwitcher.h"
@interface CHViewController ()

@property (nonatomic , strong) UIButton *aboutUsBtn;


@property (nonatomic , strong) UIButton *testBtn;


@end

@implementation CHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aboutUsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.aboutUsBtn.frame  =  CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 100, 100, 50);
    [self.aboutUsBtn  setTitle:@"关于我们" forState:UIControlStateNormal];
    [self.aboutUsBtn addTarget:self action:@selector(goToAboutUs) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.aboutUsBtn];
    
    
    
    self.testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.testBtn.frame  =  CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 + 100, 100, 50);
    [self.testBtn  setTitle:@"外界调用"                                                                                                                                                                                                                                                                forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(openSwitcher) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)goToAboutUs{
    
    CHAboutUsController *aboutUsVC = [[CHAboutUsController alloc] initWithURL:@"https://www.baidu.com"];
    
    [self.navigationController pushViewController:aboutUsVC animated:YES];
    
    
   
}

- (void)openSwitcher{
    
     [UIViewController openEnvironmentSwitcher];
    
    
}
@end
