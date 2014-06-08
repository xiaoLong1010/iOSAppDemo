//
//  CsyUpdateController.m
//  iOSAppDemo
//
//  Created by csy on 6/8/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyUpdateController.h"
#import "CsyContacter.h"
#import "CsyContacterService.h"

@interface CsyUpdateController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation CsyUpdateController

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
    
    //输入框赋值
//    CsyContacter *contacter = [[CsyContacterService sharedContacterService] contacterWithIndex:self.indexPath.row];
    self.nameField.text = self.contacter.name;
    self.phoneNumField.text = self.contacter.phoneNum;
    
//    NSLog(@"%d",self.nameField.isEnabled);
    //注册监听通知,输入框有输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.phoneNumField];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateButtonDidClick:(UIBarButtonItem *)sender {
    
    //1 更改按钮文字
    sender.title = self.nameField.isEnabled ? @"编辑" : @"取消";
    
    //2 更改输入框状态和文字
    self.nameField.enabled = !self.nameField.isEnabled;
    self.phoneNumField.enabled = !self.phoneNumField.isEnabled;
    
    self.nameField.text = self.contacter.name;
    self.phoneNumField.text = self.contacter.phoneNum;
    
    //2.1 phoneNum成为第一响应者
    if (self.nameField.enabled) {
        [self.phoneNumField becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
    }
    
    
    //3 更改按钮状态
    self.saveBtn.hidden = !self.saveBtn.hidden;
    
    
    
}

//监听输入框
- (void)textDidChange:(UITextField *)textField
{
    //    NSLog(@"field change");
    self.saveBtn.hidden = (self.nameField.text.length == 0) || (self.phoneNumField.text.length == 0);
}


- (IBAction)saveButtonDidClick:(UIButton *)sender {
    
    //1 获取新的模型
//    NSDictionary *dict = @{@"name":self.nameField.text,@"phoneNum":self.phoneNumField.text};
//    CsyContacter *contacter = [CsyContacter contacterWithDictionary:dict];
    
    //1 更新模型
    self.contacter.name = self.nameField.text;
    self.contacter.phoneNum = self.phoneNumField.text;
    
    [[CsyContacterService sharedContacterService] updateContacterWithContacter:self.contacter WithIndex:self.indexPath];
    
    //2 通知代理刷新数据
    [self.delegate updateControllerRefreshTableViewWithIndexPath:self.indexPath];
    
    //3 返回
    [self.navigationController popViewControllerAnimated:YES];
    
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
