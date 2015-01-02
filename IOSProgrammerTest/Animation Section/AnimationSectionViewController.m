//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AnimationSectionViewController ()
@property (strong, nonatomic) IBOutlet UITextView *txtFieldView;
@property (strong, nonatomic) IBOutlet UIImageView *logo;

@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)spinBtnDidPressed:(id)sender {
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor magentaColor]];
    static int colorIndex = 0;
    NSInteger numberOfSpins = 2;
    
    while (numberOfSpins != 0) {
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self.logo setTransform:CGAffineTransformRotate(self.logo.transform, M_PI)];
                             
                             // Change the background color
                             self.logo.backgroundColor = [colorArray objectAtIndex:colorIndex];
                             colorIndex = (colorIndex + 1) % colorArray.count;
                         }
                         completion:nil];
        numberOfSpins--;
    }
    self.logo.backgroundColor = [UIColor clearColor];
    
    

    
    
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    self.logo.center = location;
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

@end
