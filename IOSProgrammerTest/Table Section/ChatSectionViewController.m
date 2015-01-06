//
//  TableSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatSectionViewController.h"
#import "MainMenuViewController.h"
#import "ChatCell.h"

#define TABLE_CELL_HEIGHT 45.0f

@interface ChatSectionViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *isLoading;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *loadedChatData;
@property (nonatomic, strong) UIView *refreshLoadingView;
@property (nonatomic, strong) UIView *refreshColorView;
@property (nonatomic, strong) UIImageView *compass_background;
@property (nonatomic, strong) UIImageView *compass_spinner;
@property (assign) BOOL isRefreshIconsOverlap;
@property (assign) BOOL isRefreshAnimating;


@end

@implementation ChatSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadedChatData = [[NSMutableArray alloc] init];
    [self loadJSONData];
    [_isLoading startAnimating];
    //I learn about this cool trick witht he help of jackrabbitmobile
    
}


- (void)loadJSONData
{
    [self.loadedChatData removeAllObjects];
    //made this multithreading becasue it was blocking the main thread when loading up
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chatData" ofType:@"json"];
        
        NSError *error = nil;
        
        NSData *rawData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
        
        id JSONData = [NSJSONSerialization JSONObjectWithData:rawData options:NSJSONReadingAllowFragments error:&error];
        
        
        if ([JSONData isKindOfClass:[NSDictionary class]])
        {   dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *jsonDict = (NSDictionary *)JSONData;
            
            NSArray *loadedArray = [jsonDict objectForKey:@"data"];
            if ([loadedArray isKindOfClass:[NSArray class]])
            {
                for (NSDictionary *chatDict in loadedArray)
                {
                    ChatData *chatData = [[ChatData alloc] init];
                    [chatData loadWithDictionary:chatDict];
                    [self.loadedChatData addObject:chatData];
                }
                [_isLoading stopAnimating];
                _isLoading.hidden = YES;
                [self.tableView reloadData];
                
            }
        });
        }
    });
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"ChatCell";
    ChatCell *cell = nil;

    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (ChatCell *)[nib objectAtIndex:0];
    }

    ChatData *chatData = [self.loadedChatData objectAtIndex:[indexPath row]];
    
    
  [cell loadWithData:chatData];
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loadedChatData.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
