//
//  InnoSearchPickerViewController.m
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoSearchPickerViewController.h"

@interface InnoSearchPickerViewController ()

@end

@implementation InnoSearchPickerViewController

- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        _methodNames = [[NSMutableArray alloc] initWithObjects:@"第一分类", @"第二分类", nil];
        self.clearsSelectionOnViewWillAppear = YES;
        self.preferredContentSize = CGSizeMake(150, 90);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_methodNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SearchPickerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [_methodNames objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [cell.textLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.0f]];
    UIColor *byteClubBlue = [UIColor colorWithRed:61/255.0f
                                            green:154/255.0f
                                             blue:232/255.0f
                                            alpha:1.0f];
    [cell.textLabel setTextColor:byteClubBlue];
    NSString *imageName = [NSString stringWithFormat:@"searchPickerIcon_%ld.png", (long)indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedMethodName = [_methodNames objectAtIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate selectedSearchMethod:selectedMethodName];
    }
}
@end
