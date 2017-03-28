//
//  FirstViewController.m
//  Alineaciones
//
//  Created by Ivan Da Palma on 22/9/15.
//  Copyright © 2015 Ivan Da Palma. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:@"POR_442"];
    [[self POR_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"LI_442"];
    [[self LI_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"DFC1_442"];
    [[self DFC1_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"DFC2_442"];
    [[self DFC2_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"LD_442"];
    [[self LD_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"MCD_442"];
    [[self MCD_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"MVI_442"];
    [[self MVI_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"MVD_442"];
    [[self MVD_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"MCO_442"];
    [[self MCO_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"DC1_442"];
    [[self DC1_442] setText:string];
    string = [[NSUserDefaults standardUserDefaults] stringForKey:@"DC2_442"];
    [[self DC2_442] setText:string];
    

    
    // PARA QUE EL TECLADO DESAPAREZCA AL TOCAR FUERA DEL TEXTFIELD
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// PARA QUE EL TECLADO DESAPAREZCA AL TOCAR FUERA DEL TEXTFIELD
-(void)dismissKeyboard {
    [_POR_442 resignFirstResponder];
    [_LI_442 resignFirstResponder];
    [_DFC1_442 resignFirstResponder];
    [_DFC2_442 resignFirstResponder];
    [_LD_442 resignFirstResponder];
    [_MCD_442 resignFirstResponder];
    [_MVI_442 resignFirstResponder];
    [_MVD_442 resignFirstResponder];
    [_MCO_442 resignFirstResponder];
    [_DC2_442 resignFirstResponder];
    [_DC1_442 resignFirstResponder];
    
    [[NSUserDefaults standardUserDefaults] setObject:_POR_442.text forKey:@"POR_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_LI_442.text forKey:@"LI_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_DFC1_442.text forKey:@"DFC1_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_DFC2_442.text forKey:@"DFC2_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_LD_442.text forKey:@"LD_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_MCD_442.text forKey:@"MCD_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_MVI_442.text forKey:@"MVI_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_MVD_442.text forKey:@"MVD_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_MCO_442.text forKey:@"MCO_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_DC1_442.text forKey:@"DC1_442"];
    [[NSUserDefaults standardUserDefaults] setObject:_DC2_442.text forKey:@"DC2_442"];

}

@end
