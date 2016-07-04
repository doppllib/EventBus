//
//  ViewController.m
//  ios
//
//  Created by Kevin Galligan on 6/11/16.
//  Copyright © 2016 Kevin Galligan. All rights reserved.
//

#import "ViewController.h"
#import "AllTests.h"
#import "java/lang/System.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)runClicked:(id)sender {
    
    
    [AllTests runTests];
    //    [_benchmarkPresenter startBenchmark];
    //    [_simpleTestPresenter runDbTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
