//
//  ViewController.m
//  SelectTags
//
//  Created by jm on 15/11/14.
//  Copyright © 2015年 Jim. All rights reserved.
//

#import "ViewController.h"
#import "BTKMyProfileTagViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BTKMyProfileTagViewController *VC = [[BTKMyProfileTagViewController alloc] init];
    [self.view addSubview:VC.view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
