//
//  ViewController.m
//  KCAlertViewDemo
//
//  Created by Shawn on 11/11/14.
//
//

#import "ViewController.h"
#import "../../KCAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.foundationNumber.text = [NSString stringWithFormat:@"Foundation number: %.2f", NSFoundationVersionNumber + 0.005];
}

- (IBAction)pressShowAlert:(id)sender {
    NSMutableArray *actions = @[].mutableCopy;
    
    [actions addObject:[KCAlertAction actionWithTitle:@"button 0 (destructive)" style:UIAlertActionStyleDestructive handler:^(KCAlertAction *action) {
        NSLog(@"button 0 (destructive) completion handler");
    }]];
    
    [actions addObject:[KCAlertAction actionWithTitle:@"button 1 (cancel)" style:UIAlertActionStyleCancel handler:^(KCAlertAction *action) {
        NSLog(@"button 1 (cancel) completion handler");
    }]];

    [actions addObject:[KCAlertAction actionWithTitle:@"button 2" style:UIAlertActionStyleDefault handler:^(KCAlertAction *action) {
        NSLog(@"button 2 completion handler");
    }]];
    
    [actions addObject:[KCAlertAction actionWithTitle:@"button 3" style:UIAlertActionStyleDefault handler:^(KCAlertAction *action) {
        NSLog(@"button 3 completion handler");
    }]];
    
    [[KCAlertView sharedInstance] showAlertWithViewController:self title:@"Title" message:@"Message" actions:actions];
}

@end
