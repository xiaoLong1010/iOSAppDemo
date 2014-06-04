//
//  CsyViewController.m
//  13-PickMenu
//
//  Created by csy on 6/3/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyViewController.h"

@interface CsyViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) NSArray *foodGroups;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (weak, nonatomic) IBOutlet UILabel *drinkLabel;
@property (weak, nonatomic) IBOutlet UIButton *randBtn;
@end

@implementation CsyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//	for (NSArray *group in self.foodGroups) {
//        CsyLog(@"%@",group);
//    }
    
    //初始化三个label，菜单名
    for (int i = 0; i < self.foodGroups.count; i++) {
        [self pickerView:self.picker didSelectRow:4 inComponent:i];
    }
    
//    NSInteger row = [self.picker selectedRowInComponent:0];
//    CsyLog(@"selected row = %d",row);
    
    //监听方法
    [self.randBtn addTarget:self action:@selector(randBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark -- UIPickerViewDataSource

//返回component数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foodGroups.count;
}

//返回每个component有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.foodGroups[component] count];
}

#pragma mark -- UIPickerViewDelegate

//每一行显示的数据，字符串数据

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foodGroups[component][row];
}

//选中某一行之后，该方法被调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    CsyLog(@"selected");
    NSString *item = self.foodGroups[component][row];
    switch (component) {
        case 0:
            self.fruitLabel.text = item;
            break;
        case 1:
            self.mainLabel.text = item;
            break;
        case 2:
            self.drinkLabel.text = item;
            break;
        default:
            break;
    }
}

#pragma mark --randBtn Listener

- (void)randBtnDidClick:(UIButton *)button
{
//    CsyLog(@"click");
    
    for (int i = 0; i < self.foodGroups.count; i++) {
        NSArray *group = self.foodGroups[i];
        NSInteger newRow = arc4random() % group.count;
        //之前被选中的行
        NSInteger currentRow = [self.picker selectedRowInComponent:i];
//        NSLog(@"currentRow = %d",currentRow);
        //如果随机值和当前的值相当，随机的值加1
        if (newRow == currentRow) {
            newRow = (newRow + 1) % group.count;
        }
//        NSLog(@"newRow = %d",newRow);
        //选中某行某列
        [self.picker selectRow:newRow inComponent:i animated:YES];
        //调用didSecled方法,更新三个label
        [self pickerView:self.picker didSelectRow:newRow inComponent:i];
    }

    
    
}

- (NSArray *)foodGroups
{
    if (!_foodGroups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        
        _foodGroups = [NSArray arrayWithContentsOfFile:path];

    }
    
    return _foodGroups;
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
