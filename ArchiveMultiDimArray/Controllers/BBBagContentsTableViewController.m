//
//  BBBagContentsTableViewController.m
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "BBBagContentsTableViewController.h"
#import "BBBagStore.h"
#import "BBItem.h"
#import "BBItemStore.h"
#import "BBChooseBagContentsTableViewController.h"
#import "BBItemTableViewCell.h"

@interface BBBagContentsTableViewController ()

@property (nonatomic) NSMutableArray *privateBagItems;

@end

@implementation BBBagContentsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //add existing exercise button to nav bar
        UINavigationItem *navItem = self.navigationItem;
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExistingExercise:)];
        navItem.rightBarButtonItem = bbi;
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerAction:) name:@"chooseItem" object:nil];
    
    return self;
}

//method for custom nav bar
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Notification
-(void)triggerAction:(NSNotification *) notification
{
    if ([notification.object isKindOfClass:[BBItem class]])
    {
        
        BBItem *item = [notification object];
        NSLog(@"item received: %@", item);
        
        [self.bag.itemsInBag addObject:item];
        NSLog(@"itemsInBag :%@", self.bag.itemsInBag);
    }
    else
    {
        NSLog(@"Error, object not recognised.");
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set up tableview
    self.tableView.rowHeight = 60;

    
    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    //load nib
    UINib *nib = [UINib nibWithNibName:@"BBItemTableViewCell" bundle:nil];
    
    //register nib containing cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BBItemTableViewCell"];
    
    self.privateBagItems = self.bag.itemsInBag;
}

- (void)viewWillAppear:(BOOL)animated
{
    // navigation bar appearance
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor],NSForegroundColorAttributeName,
                                    [UIColor blackColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.title = self.bag.bagName;
    
    //tableview
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview code


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bag.itemsInBag count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //get new cell
    BBItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBItemTableViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    NSArray *bagItems = self.bag.itemsInBag;
    
    
    BBItem *item = [bagItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.itemName;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellStartEditing = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toggleEditingMode:)];
}

- (IBAction)addExistingExercise:(id)sender
{
    BBChooseBagContentsTableViewController *tvc = [[BBChooseBagContentsTableViewController alloc] init];
    
    tvc.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tvc];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)toggleEditingMode:(id)sender
{
    if (self.isEditing) {
        [self setEditing:NO animated:YES];
    } else {
        [self setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if tableview is asking to commit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.bag.itemsInBag removeObjectAtIndex:indexPath.row];
        
        //remove row with animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
