//
//  ThirdViewController.m
//  12_TabBar
//
//  Created by Ivan Da Palma on 1/7/15.
//  Copyright (c) 2015 Ivan Da Palma. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self wvMF] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mercafutbol.com"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
