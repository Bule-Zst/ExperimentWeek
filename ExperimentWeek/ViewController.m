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
    
    // getAll
    [s deleteAll];
    [s addWithName:@"zst" Number:@"1" Sex:@"male"];
    [s addWithName:@"jojo" Number:@"2" Sex:@"male"];
    NSLog(@"%lu", [[s getAll] count] );
    NSLog(@"--------------------------");
    
    // getByName
    [s deleteAll];
    [s addWithName:@"z" Number:@"1" Sex:@"male"];
    [s addWithName:@"z" Number:@"1" Sex:@"male"];
    [s addWithName:@"z" Number:@"1" Sex:@"male"];
    [s addWithName:@"t" Number:@"1" Sex:@"male"];
    [s addWithName:@"t" Number:@"1" Sex:@"male"];
    NSLog(@"%lu", [[s getByName:@"z"] count ] );
    NSLog(@"%lu", [[s getByName:@"t"] count ] );
    NSLog(@"--------------------------");
    
    // delete by id
    [s deleteAll];
    [s addWithName:@"z" Number:@"1" Sex:@"male"];
    NSMutableArray* arr = [s getAll];
    NSInteger index = [[[arr objectAtIndex:0] objectForKey:@"id"] intValue];
    [s deleteById:index];
    NSLog(@"%lu", [[s getAll] count] );
    NSLog(@"--------------------------");
    
    // update with id
    [s deleteAll];
    [s addWithName:@"z" Number:@"1" Sex:@"male"];
    int _id = [[[[s getAll] objectAtIndex:0] objectForKey:@"id"] intValue];
    [s showById:_id];
    [s updateWithId:_id Name:@"s" Number:@"2" Sex:@"female"];
    [s showById:_id];
    NSLog(@"--------------------------");
}


@end
