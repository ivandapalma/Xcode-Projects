//
//  webViewController.m
//  La Butaca
//
//  Created by Ivan Da Palma on 27/6/15.
//  Copyright (c) 2015 Ivan Da Palma. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[self wvWebP] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_wvURL]]];
    [[self wvWebL
      ] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_wvURL]]];
    
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAtras:(UIBarButtonItem *)sender {
[[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
