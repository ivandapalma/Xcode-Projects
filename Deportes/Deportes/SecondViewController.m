//
//  SecondViewController.m
//  12_TabBar
//
//  Created by Ivan Da Palma on 1/7/15.
//  Copyright (c) 2015 Ivan Da Palma. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self wvAs] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://as.com"]]];
    self.wvAs.scalesPageToFit=YES;
        
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
