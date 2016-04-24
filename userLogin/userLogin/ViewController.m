//
//  ViewController.m
//  userLogin
//
//  Created by ma c on 16/4/24.
//  Copyright © 2016年 吴贞利. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface ViewController ()

@property (weak, nonatomic) NSManagedObjectContext *context;

/** 用户名 */
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;

@end

@implementation ViewController
- (NSManagedObjectContext *)context {
    if (!_context) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        _context = context;
    }
    return _context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)userRegister:(id)sender {
    NSString *name = self.nameTxt.text;
    NSString *psw = self.pwdTxt.text;
    if (!(name && psw && name.length && psw.length )) {
        return;
    }
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    user.name = name;
    user.psw = psw;
    [self.context save:nil];
}


- (IBAction)login:(id)sender {
    NSString *name = self.nameTxt.text;
    NSString *psw = self.pwdTxt.text;
    if (!(name && psw && name.length && psw.length )) {
        return;
    }
    User *user = [self userForName:name];
    if (user && [user.psw isEqualToString:psw] ) {
        [self alert:@"登录成功"];
        return;
    }else {
        [self alert:@"输入错误"];
    }
}

- (User *)userForName:(NSString *)name {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSString *msg = @"没有此用户";
        [self alert:msg];
        return nil;
    }
    User *user = [fetchedObjects firstObject];
    return user;
}
- (IBAction)showAllUser:(id)sender {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
//                                                                   ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray<User *> *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"查询错误");
        return;
    }
    for (User *user in fetchedObjects) {
        NSLog(@"%@   %@",user.name, user.psw);
    }
}

- (void)alert:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)textChange:(NSNotification *)notification {
    UITextField *field = (UITextField *) notification.object;
    NSLog(@"%@",field.text);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end






















