//
//  SearchResult.m
//  SnapImage
//
//  Created by Arnav Patra on 09/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (id) initWithSearchText:(NSString *) text
             searchParams:(SearchParameters *) params
         nextSearchParams:(SearchParameters *) nextParams
{
    if(self = [super init])
    {
        _searchText = text;
        _searchParams = params;
        _nextSearchParams = nextParams;
        _searchResultItems = [NSMutableArray array];
    }
    
    return self;
}
- (SearchResultItem *) getSearchResultItemForIndexPath:(NSIndexPath *) indexPath
{
    SearchResultItem * item = nil;
    item = [self.searchResultItems objectAtIndex:indexPath.row];
    return item;
}

@end
