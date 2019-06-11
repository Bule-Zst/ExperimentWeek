//
//  ViewController.m
//  ExperimentWeek
//
//  Created by Bule on 2019/6/11.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "ViewController.h"
#import "Sqlite3Manager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Sqlite3Manager* s = [[ Sqlite3Manager alloc ] init];
    [s addWithName:@"zstt" Number:@"B16" Sex:@"male"];
    NSLog( @"%lu", [[s getByName:@"zst"] count] );
    NSLog( @"%lu", [[s getByName:@"zstt"] count] );
    //NSLog( [[[s getAllData] objectAtIndex:0]objectForKey:@"name"] );
}


@end
