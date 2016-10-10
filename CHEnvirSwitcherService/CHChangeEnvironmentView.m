//
//  ChangeEnvironmentView.m
//  关于我的_切换环境组件
//
//  Created by 朱彦君 on 16/7/17.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import "CHChangeEnvironmentView.h"
#import "CHEnvironmentSupply.h"
#import "UIViewController+EnvironmentSwitcher.h"

#define Label_height [UIScreen mainScreen].bounds.size.width/8

@interface CHChangeEnvironmentView()<UITextFieldDelegate>

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UIView *bgView;

@property (nonatomic , strong) NSString *currentUrl;


@end

@implementation CHChangeEnvironmentView


- (instancetype)init
{
    
     CGRect rect = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width/3*2, [UIScreen mainScreen].bounds.size.height) ;
    self = [super initWithFrame:rect];
    if (self) {
         self.backgroundColor = [UIColor whiteColor];
        
         [self addSubviews];
        
    }
    return self;
}
 
- (void)addSubviews{

    self.bgView = [[UIView alloc] init];
    self.bgView.frame = [UIScreen mainScreen].bounds;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.1;
    self.bgView.hidden = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switcherHide:)];
    [self.bgView addGestureRecognizer:tapGestureRecognizer];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/8, [UIScreen mainScreen].bounds.size.width/3*2, Label_height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"选择环境";
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.titleLabel];
    
    
    self.urlShow = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, [UIScreen mainScreen].bounds.size.width/3*2, 60)];
    [self showCurrentUrl];
    self.urlShow.textAlignment = NSTextAlignmentCenter;
    self.urlShow.numberOfLines = 3;
    self.urlShow.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.urlShow];
    
    
    self.CustomTestField = [[UITextField alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/12, self.urlShow.frame.origin.y + self.urlShow.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width/2 , 30)];
    self.CustomTestField.layer.borderColor = [UIColor blackColor].CGColor;
    self.CustomTestField.layer.borderWidth = 1;
    self.CustomTestField.delegate = self;
    [self addSubview:self.CustomTestField];
    
    self.formalBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.formalBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/6, self.CustomTestField.frame.origin.y + self.CustomTestField.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width/3, Label_height) ;
    [self.formalBtn setTitle:@"正式环境" forState:UIControlStateNormal];
    [self.formalBtn addTarget:self action:@selector(changFormalEnvironment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.formalBtn];
    
    self.testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.testBtn.frame = CGRectMake(self.formalBtn.frame.origin.x, self.formalBtn.frame.origin.y + self.formalBtn.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width/3, Label_height) ;
    [self.testBtn setTitle:@"测试环境" forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(changTestEnvironment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.testBtn];
    
    self.otherBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.otherBtn.frame = CGRectMake(self.testBtn.frame.origin.x, self.testBtn.frame.origin.y + self.testBtn.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width/3, Label_height) ;
    [self.otherBtn setTitle:@"自定义环境" forState:UIControlStateNormal];
    [self.otherBtn addTarget:self action:@selector(CustomEnvironment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.otherBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelBtn.frame = CGRectMake(self.otherBtn.frame.origin.x, self.otherBtn.frame.origin.y + self.otherBtn.frame.size.height + 10, [UIScreen mainScreen].bounds.size.width/3, Label_height) ;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(closeSwitcher) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
}

- (void)changTestEnvironment{
    
    [CHEnvironmentSupply setHostWithType:CHTestEnvironment completed:nil];
    
    [self showCurrentUrl];
    
}

- (void)changFormalEnvironment{
    
    [CHEnvironmentSupply setHostWithType:CHProductEnvironment completed:nil];
    
    [self showCurrentUrl];
    
    
}


- (void)closeSwitcher{
    
    
    [self close];
    
}


- (void)CustomEnvironment{
    
    if (self.CustomTestField.text.length > 0) {
        
         [CHEnvironmentSupply setHostWithCustomPath:self.CustomTestField.text completed:nil];
    }
    
   
    [CHEnvironmentSupply setHostWithType:CHCustomEnvironment completed:nil];
    
    [self showCurrentUrl];
    
    
    self.CustomTestField.text = @"";
    
    
}


- (void)showCurrentUrl{
    
    [self.CustomTestField resignFirstResponder];
  
    self.currentUrl = [CHEnvironmentSupply servicePath];
    
    self.urlShow.text = [NSString stringWithFormat:@"当前环境:%@",_currentUrl];
    
    
    
}


- (void)show{
   
    self.bgView.hidden = NO;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self.bgView];
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.alpha = 0.6;
        
        CGRect rect = self.frame;
        rect.origin.x = [UIScreen mainScreen].bounds.size.width/3;
        
        self.frame = rect;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    
    

}


- (void)close{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.alpha = 0.1;
        
        CGRect rect = self.frame;
        
        rect.origin.x = [UIScreen mainScreen].bounds.size.width;
        
        self.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        
        [self  removeFromSuperview];
    }];
    
    
   
    
}


- (void)switcherHide:(UITapGestureRecognizer*)tap{
    
    [self close];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    
    if (self.CustomTestField.text.length > 0) {
        
        [CHEnvironmentSupply setHostWithCustomPath:self.CustomTestField.text completed:nil];
    }
    
    
    [CHEnvironmentSupply setHostWithType:CHCustomEnvironment completed:nil];
    
    
    [self close];
    
    return YES;
    
}

-(void)dealloc{
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
