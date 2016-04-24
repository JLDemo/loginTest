//
//  User+CoreDataProperties.h
//  userLogin
//
//  Created by ma c on 16/4/24.
//  Copyright © 2016年 吴贞利. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *psw;

@end

NS_ASSUME_NONNULL_END
