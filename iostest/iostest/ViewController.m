//
//  ViewController.m
//  iostest
//
//  Created by Kevin Galligan on 1/19/17.
//  Copyright © 2017 Kevin Galligan. All rights reserved.
//

#import "ViewController.h"
#import "UiTester.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UiTester runTests];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
