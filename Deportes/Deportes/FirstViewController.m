//
//  FirstViewController.m
//  12_TabBar
//
//  Created by Ivan Da Palma on 1/7/15.
//  Copyright (c) 2015 Ivan Da Palma. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self wvMarca] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.marca.com"]]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
