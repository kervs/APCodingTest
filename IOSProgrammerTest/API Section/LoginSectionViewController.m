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
    //setting up type of keyborad
    _userNameTxtField.delegate = self;
    _userNameTxtField.returnKeyType = UIReturnKeyNext;
    _passwordTxtField.delegate = self;
}

- (IBAction)loginDidPressed:(UIButton *)sender {
    NSTimeInterval startingTime = [NSDate date].timeIntervalSince1970;
    
    //used AFNeworking to send out post request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"username":_userNameTxtField.text,
                               @"password":_passwordTxtField.text};
    
    [manager POST:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject[@"code"]);
        NSTimeInterval endingTime = [NSDate date].timeIntervalSince1970;
        [self showAlertWith:responseObject[@"code"] andMessage:responseObject[@"message"] andStartTime:startingTime andEndingtime:endingTime];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSString *errorString = @"error";
        NSTimeInterval endingTime = [NSDate date].timeIntervalSince1970;

        [self showAlertWith:errorString andMessage:[error userInfo][@"error"] andStartTime:startingTime andEndingtime:endingTime];
    }];
    
    
}

//just wanted to make this method so it would be reusable
-(void)showAlertWith:(NSString *)title andMessage:(NSString *)message andStartTime:(NSTimeInterval )startingTime andEndingtime:(NSTimeInterval) endingTime{
    
    NSString *finishedTitle = [NSString stringWithFormat:@"%@", title];
    NSString *finishedMessage = [NSString stringWithFormat:@"%@ and it took %f seconds ", message, endingTime - startingTime];
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:finishedTitle
                                                     message:finishedMessage
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
// delegate method to push the view if sucessful
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
//delegate method to get rid of keyborad
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

//delegate method to get rid of keyborad
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
