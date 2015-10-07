//
//  Define.h
//  Firsty
//
//  Created by Hyacinthe Hamon on 10/11/2014.
//  Copyright (c) 2015 Kick Labs Co. All rights reserved.
//

#define Header 45
#define Footer 60

#define Width self.view.frame.size.width
#define Height self.view.frame.size.height


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define KFontUsed @"weblysleekuil"
#define menuViewDelegate @"menuDelegate"

//standard color
#define UIColorForApp        [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]

#define UIColorForBG         [UIColor colorWithRed:136.0/255.0f green:41/255.0f blue:114/255.0f alpha:1.0]
#define UIColorForBG1         [UIColor colorWithRed:136.0/255.0f green:41/255.0f blue:114/255.0f alpha:0.8]

#define UIColorForButton     [UIColor colorWithRed:102.0/255.0f green:163/255.0f blue:242/255.0f alpha:1.0]


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
