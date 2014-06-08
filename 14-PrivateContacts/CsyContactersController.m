//
//  CsyAddController.m
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyContactersController.h"
#import "CsyContacterService.h"
#import "CsyContacterCell.h"
#import "CsyContacter.h"
#import "CsyAddController.h"
#import "CsyContacterCell.h"
#import "CsyUpdateController.h"

@interface CsyContactersController () <UIActionSheetDelegate,CsyAddControllerDelegete,CsyUpdateControllerDelegate>

@property (strong,nonatomic) UIBarButtonItem *deleteBtn;
@end

@implementation CsyContactersController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加delete按钮
    UINavigationItem *navItem = self.navigationItem;
    
    UIBarButtonItem *addBtn = navItem.rightBarButtonItem;
    
    UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteCell)];
    
    self.deleteBtn = deleteBtn;
    
    navItem.rightBarButtonItems = @[deleteBtn,addBtn];
    
//    self.tableView.rowHeight = 100.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CsyContacterService sharedContacterService] numOfContacters];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    CsyContacterCell *cell = [CsyContacterCell contactrCellWithTableView:tableView];

    //获取数据
    CsyContacter *contacter = [[CsyContacterService sharedContacterService] contacterWithIndex:indexPath.row];
    
    //设置数据
    
    cell.contacter = contacter;
    
    
    return cell;
}

/**
 *  logout按钮点击之后
 */
- (IBAction)logoutButtonDidClick:(UIBarButtonItem *)sender {

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"退出" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
    
    [actionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {     //点击确定按钮
        [self.navigationController popViewControllerAnimated:YES];      //返回上一个controller
    }
}



/**
 *  获取数据之后,添加数据
 *
 */
- (void)addControllerWithContacter:(CsyContacter *)contacter
{
    //1 添加数据到数据库
    [[CsyContacterService sharedContacterService] create:contacter];
    
    //2 增加一个cell
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
    
    //3 添加一行到tableView
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:YES];
    
    NSInteger count = [[CsyContacterService sharedContacterService] numOfContacters];
    
    for (int i = 0; i < count; i++) {
        CsyContacter *contacter = [[CsyContacterService sharedContacterService] contacterWithIndex:i];
        CsyContacterCell *cell = (CsyContacterCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        NSLog(@"%p--%p",contacter,cell.contacter);
    }
}

/**
 *  delete按钮点击
 *
 */

- (void)deleteCell
{

    self.deleteBtn.title = self.tableView.isEditing ? @"delete" : @"done";
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"style");
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"commit");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //1 拿到选中的cell索引
//        NSIndexPath *path = [tableView indexPathForSelectedRow];
        
        //2 删掉模型里的数据
        [[CsyContacterService sharedContacterService] deleteContacterWithIndex:indexPath.row];
        
        //3 tableView的delte
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];

//        NSInteger count = [[CsyContacterService sharedContacterService] numOfContacters];
//        
//        for (int i = 0; i < count; i++) {
//            CsyContacter *contacter = [[CsyContacterService sharedContacterService] contacterWithIndex:i];
//            CsyContacterCell *cell = (CsyContacterCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            
//            NSLog(@"%p--%p",contacter,cell.contacter);
//        }


        
    }
}


//跳转之前做些事情,设置代理
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Add"]) {
//        NSLog(@"add");
        CsyAddController *addController = segue.destinationViewController;
        addController.delegate = self;
    }else if ([segue.identifier isEqualToString:@"update"]){
        NSLog(@"update");
        //1 跳转的controller
        CsyUpdateController *updateController = segue.destinationViewController;
        
        //2 选中的cell
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        CsyContacter *contacter = [[CsyContacterService sharedContacterService] contacterWithIndex:path.row];
        
        //3 更新controller
        updateController.navigationItem.title = contacter.name;
//        updateController.nameField.text = contacter.name;  //view还没生成,赋值无效
        updateController.indexPath = path;
        updateController.contacter = contacter;
        
        //4 设置代理
        updateController.delegate = self;
    }
}

//编辑之后,刷新tableView
- (void)updateControllerRefreshTableViewWithIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
