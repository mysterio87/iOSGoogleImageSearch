//
//  SearchEngine.m
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "SearchEngine.h"
#import "SearchParameters.h"
#import "SearchFilter.h"

static NSString * const SearchEngineAPIKey = @"AIzaSyBEl_ElX6sM6l1yxdn2PoVMVpCeAtL9R7U";
static NSString * const SearchEngineCX = @"017886163562100349222:vdxoqdnqu7m";
static NSString * const SearchEngineURLString = @"https://www.googleapis.com/customsearch/v1/";

@implementation SearchEngine

#pragma mark - Public Methods
+ (SearchEngine *)sharedSearchEngine
{
    static SearchEngine *_sharedSearchEngine = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSearchEngine = [[self alloc] initWithBaseURL:[NSURL URLWithString:SearchEngineURLString]];
        
        SearchFilter * sizeFilter = [[SearchFilter alloc] initWithName:FILTER_SIZE filterIdentifiers:SIZE_ICON, SIZE_SMALL, SIZE_MEDIUM, SIZE_LARGE, SIZE_XLARGE, SIZE_XXLARGE, SIZE_HUGE, nil];
        SearchFilter * typeFilter = [[SearchFilter alloc] initWithName:FILTER_TYPE filterIdentifiers:TYPE_CLIPART, TYPE_FACE, TYPE_LINE_ART, TYPE_NEWS, TYPE_PHOTO, nil];
        SearchFilter * colorFilter = [[SearchFilter alloc] initWithName:FILTER_COLOR filterIdentifiers:COLOR_MONO, COLOR_GRAY, COLOR_COLOR, nil];
        SearchFilter * timeFilter = [[SearchFilter alloc] initWithName:FILTER_DATE filterIdentifiers:DATE_DAYS, DATE_WEEK, DATE_MONTH, DATE_YEAR, nil];
        SearchFilter * rightsFilter = [[SearchFilter alloc] initWithName:FILTER_RIGHTS filterIdentifiers:RIGHTS_PUBLIC, RIGHTS_ATTR, RIGHTS_SHARE, RIGHTS_NONCOMM, RIGHTS_NONDER, nil];
        searchFilters = [NSMutableDictionary dictionaryWithObjectsAndKeys:sizeFilter, FILTER_SIZE, typeFilter, FILTER_TYPE, colorFilter, FILTER_COLOR, timeFilter, FILTER_DATE, rightsFilter, FILTER_RIGHTS, nil];
    });
    
    return _sharedSearchEngine;
}

+ (NSMutableDictionary *) filters
{
    return searchFilters;
}

- (instancetype)initWithBaseURL
{
    NSURL *baseURL = [NSURL URLWithString:SearchEngineURLString];
    return [self initWithBaseURL:baseURL];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}
- (void) updateSearchWithParameters:(SearchParameters *) params
{
    NSMutableDictionary *parameters = [self _cseIdentityParams].mutableCopy;
    [parameters addEntriesFromDictionary:[params getDictionaryData]];
    
    [self GET:@"" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(searchEngine:didUpdateWithResults:)]) {
            [self.delegate searchEngine:self didUpdateWithResults:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(searchEngine:didFailWithError:)]) {
            [self.delegate searchEngine:self didFailWithError:error];
        }
    }];
}

#pragma mark - Helpers
- (NSDictionary *)_cseIdentityParams {
    return [NSDictionary dictionaryWithObjectsAndKeys:SearchEngineCX, CX, SearchEngineAPIKey, API_KEY, nil];
}

@end
