//
//  ViewController.m
//  La Butaca
//
//  Created by Ivan Da Palma on 27/6/15.
//  Copyright (c) 2015 Ivan Da Palma. All rights reserved.
//

#import "ViewController.h"
#import "webViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"sgHolea"])
        self.url = @"http://m.filmaffinity.com/es/theater-showtimes.php?id=581";
    else if ([[segue identifier] isEqualToString:@"sgNervion"])
        self.url = @"http://m.filmaffinity.com/es/theater-showtimes.php?id=354" ;
    else // if ([[segue identifier] isEqualToString:@"sgEstrenos"])
        self.url = @"http://m.filmaffinity.com/es/rdcat.php?id=upc_th_es" ;
    
    webViewController *webVC = [segue destinationViewController];
    webVC.wvURL = self.url;
}


- (IBAction)btnInfo:(UIButton *)sender {
    UIAlertView *avAlerta = [[UIAlertView alloc] initWithTitle:@"Programador" message:@"Iván Da Palma" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [avAlerta show];

}
@end
