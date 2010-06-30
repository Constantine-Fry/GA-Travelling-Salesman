//
//  CostTable.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/5/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "CostTable.h"
#import "defs.h"

@implementation CostTable

- (id) initWithSize:(int)L
{
	self = [super init];
	if (self != nil) {
		l_= L;
		intCosts_ = malloc(sizeof(int)*l_*l_);
		memset(intCosts_,0,sizeof(int)*l_*l_);
	}
	return self;
}


- (id) initRandomTableWithSize:(int)L
{
	self = [self initWithSize:L];
	if (self != nil) {
		srand(time(NULL));
		for (int i = 0; i < L; ++i){
			for (int j = i + 1; j < L; ++j){
				int n = (rand() % MAX_COST + 1);
				intCosts_[i*l_+j] = n;
				intCosts_[j*l_+i] = n;
			}
		}
	}
	return self;
}


-(NSString*)description{
	NSMutableString *res = [[NSMutableString alloc]init];
	[res appendString:@"\n   "];
	
	for(int i = 1; i <= l_; ++i){
		[res appendFormat:@"%.2d ",i];
	}
	[res appendString:@"\n"];
	
	for(int i = 1; i <= l_; ++i){
		[res appendFormat:@"%.2d ",i];
		for(int j =1; j<= l_; ++j){
			[res appendFormat:@"%.2d ",[self CostBetweenI:i andJ:j]];
		}
		[res appendString:@"\n"];
	}
	return [res autorelease];
}

-(int)CostBetweenI:(int)i andJ:(int)j{
//	if ((i==0) || (j==0)) {
//		NSLog(@"zero");
//	}
	return intCosts_[(i-1)*(l_)+j-1];
}

- (void) dealloc
{
	//[costs_ release];
	[super dealloc];
}



@end
