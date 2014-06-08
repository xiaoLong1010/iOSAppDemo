//
//  CsyLoginController.m
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyLoginController.h"

@interface CsyLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation CsyLoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1 注册notification监听方法,监听输入框的输入,一旦输入,发送notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:_accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:_passwordField];
    
    //
//    self.navigationItem.rightBarButtonItems
    
//    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
}
- (IBAction)autoLoginSwitchDidChange:(UISwitch *)sender {
    if (sender.isOn) {
//        self.rememberSwitch.on = YES;
        [self.rememberSwitch setOn:YES animated:YES];
    }
}
- (IBAction)rememberSwitchDidChange:(UISwitch *)sender {
    if (!sender.isOn) {
        //        self.rememberSwitch.on = YES;
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(NSNotification *)notification
{
    
    //判断两个输入框的内容是否为空
    self.loginBtn.hidden =  (self.accountField.text.length == 0) || (self.passwordField.text.length == 0);
}

//登录按钮点击之后,进行controller跳转
- (IBAction)loginButtonDidClick:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"Login2Add" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //1 获取输入框的数据
    NSString *name = self.accountField.text;
    
    //2 获取目的controller
    UIViewController *destController = segue.destinationViewController;
    
    //3 设置目的controller的标题
    destController.navigationItem.title = [NSString stringWithFormat:@"%@的联系人",name];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
