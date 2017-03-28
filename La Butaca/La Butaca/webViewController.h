//
//  webViewController.h
//  La Butaca
//
//  Created by Ivan Da Palma on 27/6/15.
//  Copyright (c) 2015 Ivan Da Palma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface webViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *wvWebP;
@property (strong, nonatomic) IBOutlet UIWebView *wvWebL;
@property (strong,nonatomic) NSString *wvURL;
- (IBAction)btnAtras:(UIBarButtonItem *)sender;


@end
