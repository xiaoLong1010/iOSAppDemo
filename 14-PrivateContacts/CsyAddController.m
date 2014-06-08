//
//  CsyAddControllerV.m
//  iOSAppDemo
//
//  Created by csy on 6/8/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyAddController.h"
#import "CsyContacter.h"

@interface CsyAddController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation CsyAddController


- (void)viewDidLoad
{
    [super viewDidLoad];

    //设置代理
    self.nameField.delegate = self;
    self.phoneNumField.delegate = self;
    
    //注册监听通知,输入框有输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.phoneNumField];
}
- (IBAction)saveButtonDidClick:(UIButton *)sender {
    
    //1.生成数据
    NSDictionary *dict = @{@"name":self.nameField.text,@"phoneNum":self.phoneNumField.text};
    CsyContacter *contacter = [CsyContacter contacterWithDictionary:dict];
    
    //2.调用代理的方法
    [self.delegate addControllerWithContacter:contacter];
    
    //3 跳转到联系人界面
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textDidChange:(UITextField *)textField
{
//    NSLog(@"field change");
    self.saveBtn.hidden = (self.nameField.text.length == 0) || (self.phoneNumField.text.length == 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.nameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
