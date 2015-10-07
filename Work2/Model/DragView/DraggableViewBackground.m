//
//  DraggableViewBackground.m
//  testing swiping
//
//  Created by Richard Kim on 8/23/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "DraggableViewBackground.h"

@implementation DraggableViewBackground{
    NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIButton* xButton;
    UIButton* refreshButton;
    UIButton* locationButton;
    UIButton* checkButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1

@synthesize exampleCardLabels; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        [self loadCards];
        [self setupView];
    }
    return self;
}

//%%% sets up the extra buttons on the screen
-(void)setupView
{
    self.backgroundColor = [UIColor whiteColor]; //the gray background colors
    
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(-10, self.frame.size.height - 70, 80, 80)];
    xButton.layer.cornerRadius = xButton.frame.size.height/2;
    xButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    xButton.layer.borderWidth = 1;
    xButton.layer.masksToBounds = YES;
    [xButton setImage:[UIImage imageNamed:@"xButton.png"] forState:UIControlStateNormal];
    xButton.backgroundColor  = [UIColor whiteColor];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    
    refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(60, self.frame.size.height - 45, 50, 50)];
    refreshButton.layer.cornerRadius =  refreshButton.frame.size.height/2;
    [refreshButton setImage:[UIImage imageNamed:@"refreshBtn.png"] forState:UIControlStateNormal];
    refreshButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    refreshButton.layer.borderWidth = 1;
    refreshButton.layer.masksToBounds = YES;
    refreshButton.backgroundColor  = [UIColor whiteColor];
    [refreshButton  addTarget:self action:@selector(backRefreshCard) forControlEvents:UIControlEventTouchUpInside];
    
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 70, self.frame.size.height - 70, 80, 80)];
    [checkButton setImage:[UIImage imageNamed:@"checkBtn.png"] forState:UIControlStateNormal];
    checkButton.layer.cornerRadius = checkButton.frame.size.height/2;
    checkButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    checkButton.layer.borderWidth = 1;
    checkButton.layer.masksToBounds = YES;
    checkButton.backgroundColor  = [UIColor whiteColor];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    
    locationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 110, self.frame.size.height - 45, 50, 50)];
    [locationButton setTitle:@"CV" forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    locationButton.layer.cornerRadius = locationButton.frame.size.height/2;
    locationButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    locationButton.layer.borderWidth = 1;
    locationButton.layer.masksToBounds = YES;
    locationButton.backgroundColor  = [UIColor whiteColor];
    
    [self addSubview:xButton];
    [self addSubview:refreshButton];
    [self addSubview:checkButton];
    [self addSubview:locationButton];
}

- (void)backRefreshCard{
    
}

-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(20, 10, self.frame.size.width - 40, self.frame.size.height - 30)];
    draggableView.delegate = self;
    
    NSDictionary *data = [exampleCardLabels objectAtIndex:index];
    
    
    
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([exampleCardLabels count] > 0) {
        NSInteger numLoadedCardsCap =(([exampleCardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardLabels count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[exampleCardLabels count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
}

-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}

-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }

}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
