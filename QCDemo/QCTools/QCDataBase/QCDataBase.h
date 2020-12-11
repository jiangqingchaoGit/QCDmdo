//
//  QCDataBase.h
//  QCDemo
//
//  Created by JQC on 2020/10/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCChatModel.h"
#import "QCListModel.h"
#import "QCAssociatedModel.h"

/*
 *  FMDB 头文件
 */
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCDataBase : NSObject
@property(strong,nonatomic)FMDatabase * database;

+ (QCDataBase *)shared;
- (void)createFMDB;

-(void)changeChatModel:(QCChatModel *)model;
-(void)insertChatModel:(QCChatModel *)model;
-(void)deleteChatModel:(QCChatModel *)model;
-(void)deleteChatWithMtype:(NSString *)typeStr byListId:(NSString *)listId;
-(void)updateChatModel:(QCChatModel *)model;
-(void)updateChatModelForMessage:(NSString *)msgid;
-(NSMutableArray *)queryChatModel:(NSString *)listId;
-(void)removeAllChatModel:(QCChatModel *)model;

-(void)insertListModel:(QCListModel *)model;
-(void)deleteListModel:(QCListModel *)model;
-(void)updateListModel:(QCListModel *)model;

-(void)isBannedListModel:(QCListModel *)model withIsBanned:(NSString *)isBanned;
-(NSMutableArray *)queryMsgId:(NSString *)msgId;
-(NSMutableArray *)queryListModel:(QCListModel *)model;
-(NSMutableArray *)querywithListId:(NSString *)listId;
-(NSMutableArray *)GETARRWithListId:(NSString *)listId withContent:(NSString *)content;

- (void )queryByListId:(QCListModel *)model;
//     消息列表置顶
- (void )upTopByListId:(NSString *)listId withIsTop:(NSString *)isTop;
- (void )upDisturbByListId:(NSString *)listId withIsDisturb:(NSString *)isDisturb;
-(void)removeAllListModel:(QCListModel *)model;


-(void)insertAssociatedModel:(QCAssociatedModel *)model;
-(void)deleteAssociatedModel:(QCAssociatedModel *)model;
-(void)updateAssociatedModel:(QCAssociatedModel *)model;
-(NSMutableArray *)queryAssociatedModel:(QCAssociatedModel *)model;
- (void )queryByAssociatedId:(QCAssociatedModel *)model;
-(void)removeAllAssociatedModel:(QCAssociatedModel *)model;

@end

NS_ASSUME_NONNULL_END
