//
//  MultipleSpriteLayer.m
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultipleSpriteLayer.h"
#import "SpriteNode.h"

@implementation MultipleSpriteLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	MultipleSpriteLayer *layer = [MultipleSpriteLayer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark - Update

-(void)addSpriteNode:(ccTime)dt {
  if (CCRANDOM_0_1() >= 0.3) {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    for (SpriteNode *spriteNode in spriteNodeMutableArray) {
      if (spriteNode.ready) {
        [spriteNode.sprite setPosition:ccp(CCRANDOM_0_1() * screenSize.width, screenSize.height + spriteNode.sprite.boundingBox.size.height/2)];
        [spriteNode setVx:0];
        [spriteNode setVy:-CCRANDOM_0_1() * 8 - 2];
        [spriteNode setReady:NO];
        break;
      }
    }
    
  }
  
}

-(void)update:(ccTime)dt {
  for (SpriteNode *spriteNode in spriteNodeMutableArray) {
    if (spriteNode.ready == NO) {
      [spriteNode.sprite setPosition:ccp(spriteNode.sprite.position.x + spriteNode.vx,
                                spriteNode.sprite.position.y + spriteNode.vy)];
      
      if (spriteNode.sprite.position.y <= -spriteNode.sprite.boundingBox.size.height) {
        [spriteNode.sprite setPosition:ccp(-spriteNode.sprite.boundingBox.size.width, -spriteNode.sprite.boundingBox.size.height)];
        [spriteNode setReady:YES];
      }
      
    }
  }
  
}

#pragma mark - Set

-(void)setMultipleSprite {
  spriteNodeMutableArray = [[NSMutableArray alloc]init];
  
  for (int i=0; i<20; i++) {
    SpriteNode *spriteNode = [[SpriteNode alloc]initWithImageFile:@"ball.png"];
    [spriteNode.sprite setPosition:ccp(-spriteNode.sprite.boundingBox.size.width, -spriteNode.sprite.boundingBox.size.height)];
    [spriteNodeMutableArray addObject:spriteNode];
    [self addChild:spriteNode.sprite];
    [spriteNode release];
  }
}

/*
 Target: Keep putting sprtes in the screen, remove it when it drops out of the screen.
 
 1. add many spriteNode in the mutableArray
 2. put the ready spriteNode in the top
 3. remove the spriteNode when it drops out of the screen
 */

#pragma mark - Init

-(id) init {
	if( (self=[super init])) {
    [self setMultipleSprite];
    
    [self schedule:@selector(addSpriteNode:) interval:0.5f];
    [self schedule:@selector(update:) interval:1.0f/60.0f];
	}
	return self;
}

- (void) dealloc {
  [spriteNodeMutableArray release],spriteNodeMutableArray=nil;
	[super dealloc];
}

@end
