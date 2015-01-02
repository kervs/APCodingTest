//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"
#import "AFNetworking.h"

@interface LoginSectionViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxtField;
@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _userNameTxtField.delegate = self;
    _userNameTxtField.returnKeyType = UIReturnKeyNext;
    _passwordTxtField.delegate = self;
}
- (IBAction)loginDidPressed:(UIButton *)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"username":_userNameTxtField.text,
                               @"password":_passwordTxtField.text};
    [manager POST:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject[@"code"]);
        NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
        [self showAlertWith:code andMessage:message];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSString *errorString = @"error";
        [self showAlertWith:errorString andMessage:[error userInfo][@"error"]];
    }];
    
    
}

-(void)showAlertWith:(NSString *)title andMessage:(NSString *)message{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:title
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqual: @"Success"] ) {
        if (buttonIndex == 0) {
            // do stuff
            MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
            [self.navigationController pushViewController:mainMenuViewController animated:YES];
        }
    }
    
}
- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameTxtField) {
        [_passwordTxtField becomeFirstResponder];
    }
    
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
