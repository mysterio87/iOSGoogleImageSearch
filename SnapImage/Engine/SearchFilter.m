//
//  SearchFilter.m
//  SnapImage
//
//  Created by Arnav Patra on 9/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "SearchFilter.h"

@implementation SearchFilter

- (id) initWithName:(NSString *) name filterIdentifiers:(NSString *) identifier, ...
{
    if(self=[super init])
    {
        _name = name;
        _filterIdentifiers = [NSMutableArray array];
        va_list args;
        
        [_filterIdentifiers addObject:identifier];
        
        va_start(args, identifier);
        
        id arg = nil;
        while ((arg = va_arg(args,id))) {
            [_filterIdentifiers addObject:arg];
        }
        
        va_end(args);
    }
    
    return self;
}

- (void) updateSearchParametersForParameter:(SearchParameters *) params index:(int) index
{
    [params setValue:[self.filterIdentifiers objectAtIndex:index] forKey:self.name];
}

@end
