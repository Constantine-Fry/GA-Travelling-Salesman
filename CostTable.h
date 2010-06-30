//
//  CostTable.h
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/5/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CostTable : NSObject {
	int* intCosts_;
	int l_;
}

- (id)initWithSize:(int)L;
-(id)initRandomTableWithSize:(int)L;
-(int)CostBetweenI:(int)i andJ:(int)j;

@end
