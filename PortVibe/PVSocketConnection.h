//
//  PVSocketConnection.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <Foundation/Foundation.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"

@protocol SocketIOConnectionDelegate <NSObject>
@required
- (void) receivedPacket:(id)packet;
@end

@interface PVSocketConnection : NSObject <SocketIODelegate>
{
    SocketIO *IO;
    id <SocketIOConnectionDelegate> delegate;
}

@property (nonatomic, retain) SocketIO *IO;
@property (retain) id <SocketIOConnectionDelegate> delegate;

+(PVSocketConnection *)sharedSingleton; //class method returns singleton object

@end
