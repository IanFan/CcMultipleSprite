//
//  MultipleSpriteLayer.h
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MultipleSpriteLayer : CCLayer
{
  NSMutableArray *spriteNodeMutableArray;
}

+(CCScene *) scene;

-(void)update:(ccTime)dt;
-(void)addSpriteNode:(ccTime)dt;

@end
