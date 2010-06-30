//
//  ChangerProtocol.h
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/6/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Chromosome;
@protocol ChangerProtocol

-(void)Change:(Chromosome*)one and:(Chromosome*)two;

@end
