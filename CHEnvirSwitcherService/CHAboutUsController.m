//
//  CHAboutUsController.m
//  CHEnvirSwitcherDemo
//
//  Created by 朱彦君 on 16/7/19.
//  Copyright © 2016年 朱彦君. All rights reserved.
//

#import "CHAboutUsController.h"
#import "CHChangeEnvironmentView.h"
#import "UIViewController+EnvironmentSwitcher.h"
@interface CHAboutUsController ()

@property (nonatomic , strong) NSMutableString *password;
@end

@implementation CHAboutUsController


- (instancetype)initWithURL:(NSString *)url
{
    if (self = [super init]) {
        self.url = [NSURL URLWithString:url];
       
    }
    return self;
}

- (void)addSubviews{
    
    
    self.mainWebView = [[UIWebView alloc] init];
    
    
    self.mainWebView.frame = CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.mainWebView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    [self.mainWebView loadRequest:request];
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self setUpPassLockBtn];
    
    self.password = [[NSMutableString alloc] init];
}

- (void)setUpPassLockBtn{
    
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonOne.frame = CGRectMake(0, 64, 40, 40);
    [buttonOne addTarget:self action:@selector(pressPasswordWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonOne];
    buttonOne.tag = 1;
    
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonTwo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 64, 40, 40);
    [buttonTwo addTarget:self action:@selector(pressPasswordWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTwo];
    buttonTwo.tag = 2;
    
    UIButton *buttonThree = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonThree.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 40, 40, 40);
    [buttonThree addTarget:self action:@selector(pressPasswordWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonThree];
    buttonThree.tag = 3;
    
    
    UIButton *buttonFour = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonFour.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, 40, 40);
    [buttonFour addTarget:self action:@selector(pressPasswordWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonFour];
    buttonFour.tag = 4;
 

    
}

- (void)pressPasswordWithButton:(UIButton*)button{
    
    [self assemblePasswordwithButtonTag:button.tag];
    
     BOOL Result = [self checkPassword];
    
    if (Result) {
        
        [[self class] openEnvironmentSwitcher];
        
        [self.password deleteCharactersInRange:NSMakeRange(0, self.password.length)];
    }

    
}

- (void)assemblePasswordwithButtonTag:(NSInteger)tag{
    
    NSString *charactor = [NSString stringWithFormat:@"%ld",tag];
    
    [self.password appendString:charactor];
    
}

- (BOOL)checkPassword{
    
    
    NSString *password = [self findPasswordFromConfigureFile];
    
    if ([self.password containsString:password]) {
       
        return YES;
    }
    
    return NO;
    
}
- (NSString *)findPasswordFromConfigureFile{
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *plistPath = [bundle pathForResource:@"CHEnviroConfigure" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    
    NSString *password = [dic objectForKey:@"Password"];
    
    return password;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
