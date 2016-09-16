//
//  PVSocketConnection.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVSocketConnection.h"
#import "SocketIO.h"

@implementation PVSocketConnection
@synthesize IO, delegate;

static PVSocketConnection *shared = NULL;

-(id)init {
    if (self = [super init])
    {
        IO = [[SocketIO alloc] initWithDelegate:self];
        [IO connectToHost:@"192.168.0.14" onPort:3000];
    }
    return self;
}

+ (PVSocketConnection *)sharedSingleton
{
    @synchronized(shared)
    {
        if ( !shared || shared == NULL )
        {
            // allocate the shared instance
            shared = [[PVSocketConnection alloc] init];
        }
        
        return shared;
    }
}

-(void)SocketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    NSLog(@"Delegating received packet..");
    [delegate receivedPacket:packet.dataAsJSON];
}

@end
