"use strict";
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmptyBot = void 0;
const botbuilder_1 = require("botbuilder");
class EmptyBot extends botbuilder_1.ActivityHandler {
    constructor(conversationReferences) {
        super();
        // Dependency injected dictionary for storing ConversationReference objects used in NotifyController to proactively message users
        this.conversationReferences1 = conversationReferences;
        this.onConversationUpdate((context, next) => __awaiter(this, void 0, void 0, function* () {
            addConversationReference(context.activity);
            yield next();
        }));
        // See https://aka.ms/about-bot-activity-message to learn more about the message and other activity types.
        this.onMessage((context, next) => __awaiter(this, void 0, void 0, function* () {
            addConversationReference(context.activity);
            // Echo back what the user said
            yield context.sendActivity(`You sent '${context.activity.text}'`);
            yield next();
        }));
        this.onMembersAdded((context, next) => __awaiter(this, void 0, void 0, function* () {
            const membersAdded = context.activity.membersAdded;
            const welcomeText = 'Hello and welcome!';
            for (const member of membersAdded) {
                if (member.id !== context.activity.recipient.id) {
                    const welcomeMessage = 'Welcome to the Proactive Bot sample.  Navigate to http://localhost:3978/api/notify to proactively message everyone who has previously messaged this bot.';
                    yield context.sendActivity(welcomeMessage);
                }
            }
            // By calling next() you ensure that the next BotHandler is run.
            yield next();
        }));
        function addConversationReference(activity) {
            const conversationReference = botbuilder_1.TurnContext.getConversationReference(activity);
            conversationReferences[conversationReference.conversation.id] = conversationReference;
        }
    }
}
exports.EmptyBot = EmptyBot;
//# sourceMappingURL=bot.js.map