//
//  ImageCollectionViewController.m
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "SearchResult.h"
#import "SearchResultItem.h"
#import "UIImageView+AFNetworking.h"
#import "SearchFilter.h"

@interface ImageCollectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (nonatomic, strong) SearchResultItem * selectedItem;
@property (nonatomic, strong) SearchResult * searchResult;
@property (nonatomic, strong) SearchParameters * searchParameters;

@end

@implementation ImageCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.engine = [SearchEngine sharedSearchEngine];
    self.engine.delegate = self;
    [self.engine updateSearchWithParameters:self.searchParameters];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ImageShowcaseViewController * controller = [segue destinationViewController];
    controller.item = self.selectedItem;
}

#pragma mark - Search Field Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.searchField.text);
    [self.searchField resignFirstResponder];
    [self performSelectorOnMainThread:@selector(searchCurrentItemOnField) withObject:nil waitUntilDone:NO];
    return YES;
}

- (void) setUpForSearchQuery:(NSString *) searchQuery
{
    self.searchField.text = searchQuery;
    self.searchParameters = [[SearchParameters alloc] initWithColorType:nil imageSize:nil imageType:nil dateRestriction:nil rights:nil query:searchQuery start:1];
    self.searchResult = [[SearchResult alloc] initWithSearchText:searchQuery searchParams:self.searchParameters nextSearchParams:nil];
}

- (IBAction)searchButtonTouched:(id)sender
{
    NSString * searchText = @"";
    if(!(self.searchField.text == nil || [self.searchField.text isEqualToString:@""]))
        searchText = self.searchField.text;
    [self performSelectorOnMainThread:@selector(searchCurrentItemOnField) withObject:nil waitUntilDone:NO];
}

- (void) searchCurrentItemOnField
{
    self.searchParameters = [[SearchParameters alloc] initWithColorType:nil imageSize:nil imageType:nil dateRestriction:nil rights:nil query:self.searchField.text start:1];
    [self.engine updateSearchWithParameters:self.searchParameters];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return self.searchResult.searchResultItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    
    //Image Data Here
    SearchResultItem * item = [self searchResultItemForIndexPath:indexPath];
    [myCell.imageView setImageWithURL:item.thumbNailURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [self triggerNextSearchIfRequiredForIndexPath:indexPath];
    
    return myCell;
}

#pragma mark -
#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedItem = [self searchResultItemForIndexPath:indexPath];
    [self performSegueWithIdentifier:IMAGE_DETAILS_PAGE sender:self];
}

#pragma mark - Helpers
- (SearchResultItem *) searchResultItemForIndexPath:(NSIndexPath *) indexPath
{
    return [self.searchResult getSearchResultItemForIndexPath:indexPath];
}

- (void) triggerNextSearchIfRequiredForIndexPath:(NSIndexPath *) indexPath
{
    if (indexPath.row == self.searchResult.searchResultItems.count-1)
    {
        [self.engine updateSearchWithParameters:self.searchResult.nextSearchParams];
    }
}

- (void) nullifySearchResultsAndShowNewSearch
{
    self.searchResult = nil;
    self.searchResult = [[SearchResult alloc] initWithSearchText:self.searchField.text searchParams:self.searchParameters nextSearchParams:nil];
    [self.engine updateSearchWithParameters:self.searchParameters];
}

#pragma mark - Protocol Methods

-(void)searchEngine:(SearchEngine *)engine didUpdateWithResults:(id)results
{
    NSLog(@"Received Results: %@", results);
    
    SearchParameters * nextSearchParams = [self.searchParameters copy];
    nextSearchParams.start = [[[[results valueForKeyPath:@"queries.nextPage"] objectAtIndex:0] valueForKey:@"startIndex"] integerValue];
    self.searchResult.nextSearchParams = nextSearchParams;
    
    NSMutableArray * resultItems = [results valueForKey:@"items"];
    NSMutableArray * searchResultItems = [NSMutableArray array];
    for(NSMutableDictionary * dict in resultItems)
    {
        NSString * title = [dict valueForKey:@"title"];
        NSString * thumbURL = [dict valueForKeyPath:@"image.thumbnailLink"];
        NSString * fullURL = [dict valueForKey:@"link"];
        SearchResultItem * item = [[SearchResultItem alloc] initWithTitle:title thumbNailURL:thumbURL fullImageURL:fullURL];
        [searchResultItems addObject:item];
    }
    [self.searchResult.searchResultItems addObjectsFromArray:searchResultItems];
    [self.collectionView reloadData];
}
-(void)searchEngine:(SearchEngine *)engine didFailWithError:(NSError *)error
{
    NSLog(@"Error Encountered: %@", error.debugDescription);
}

#pragma mark - Filters

- (IBAction)sizeFilterTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:FILTER_SIZE_D
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:SIZE_ICON_DESCRIPTION, SIZE_SMALL_DESCRIPTION, SIZE_MEDIUM_DESCRIPTION, SIZE_LARGE_DESCRIPTION, SIZE_XLARGE_DESCRIPTION, SIZE_XXLARGE_DESCRIPTION, SIZE_HUGE_DESCRIPTION, nil];
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)colorFilterTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:FILTER_COLOR_D
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:COLOR_MONO_DESCRIPTION, COLOR_GRAY_DESCRIPTION, COLOR_COLOR_DESCRIPTION, nil];
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)typeFilterTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:FILTER_TYPE_D
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:TYPE_CLIPART_DESCRIPTION, TYPE_FACE_DESCRIPTION, TYPE_LINE_ART_DESCRIPTION, TYPE_NEWS_DESCRIPTION, TYPE_PHOTO_DESCRIPTION, nil];
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)timeFilterTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:FILTER_DATE_D
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:DATE_DAYS_DESCRIPTION, DATE_WEEK_DESCRIPTION,DATE_MONTH_DESCRIPTION, DATE_YEAR_DESCRIPTION, nil];
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)rightsFilterTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:FILTER_RIGHTS_D
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:RIGHTS_PUBLIC_DESCRIPTION, RIGHTS_ATTR_DESCRIPTION, RIGHTS_SHARE_DESCRIPTION, RIGHTS_NONCOMM_DESCRIPTION, RIGHTS_NONDER_DESCRIPTION, nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.numberOfButtons-1 == buttonIndex)
        return;
    
    NSString * filterKey;
    
    if([actionSheet.title isEqualToString:FILTER_SIZE_D]) filterKey = FILTER_SIZE;
    if([actionSheet.title isEqualToString:FILTER_COLOR_D]) filterKey = FILTER_COLOR;
    if([actionSheet.title isEqualToString:FILTER_TYPE_D]) filterKey = FILTER_TYPE;
    if([actionSheet.title isEqualToString:FILTER_DATE_D]) filterKey = FILTER_DATE;
    if([actionSheet.title isEqualToString:FILTER_RIGHTS_D]) filterKey = FILTER_RIGHTS;
    
    SearchFilter * filter = [[SearchEngine filters] valueForKey:filterKey];
    [filter updateSearchParametersForParameter:self.searchParameters index:buttonIndex];
    
    [self nullifySearchResultsAndShowNewSearch];
    
    NSLog(@"%@", actionSheet.title);
}

@end
