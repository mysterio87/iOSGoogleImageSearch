//
//  ViewController.m
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.searchField.text);
    [self.searchField resignFirstResponder];
    [self performSegueWithIdentifier:COLLECTIONS_PAGE sender:self];
    return YES;
}

- (IBAction)searchButtonTapped:(id)sender
{
    NSString * query = [self.searchField.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    if([query isEqualToString:@""])
    {
        return;
    }
    else
    {
        [self performSegueWithIdentifier:COLLECTIONS_PAGE sender:self];
    }
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageCollectionViewController * controller = [segue destinationViewController];
    [controller setUpForSearchQuery:self.searchField.text];
}

@end
