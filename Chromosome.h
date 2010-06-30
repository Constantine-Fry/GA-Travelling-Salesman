//
//  Chromosome.h
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/5/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Chromosome : NSObject {
	int *intChr_;
	int l_;
}

@property int* intChr;

- (id) InitEmptyChromosomeWithSize:(int)L;
- (id) InitRandomChromosomeWithSize:(int)L;
-(int)GenAtindex:(int)index;
-(int)Length;
-(void)Copy:(Chromosome*)chr;
-(int)FirstGen;
-(int)LastGen;
-(void)shuffle;



-(BOOL)CheckSum;
@end
