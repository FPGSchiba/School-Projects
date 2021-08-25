"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const app = express_1.default();
const port = 3978;
const botbuilder_1 = require("botbuilder");
const bookingBot_1 = require("./bots/bookingBot");
const mainDialog_1 = require("./dialogs/mainDialog");
const botbuilder_dialogs_adaptive_1 = require("botbuilder-dialogs-adaptive");
const BOOKING_DIALOG = 'bookingDialog';
const adapter = new botbuilder_1.BotFrameworkAdapter({
    appId: process.env.MicrosoftAppId,
    appPassword: process.env.MicrosoftAppPassword
});
// Catch-all for errors.
const onTurnErrorHandler = (context, error) => __awaiter(void 0, void 0, void 0, function* () {
    // This check writes out errors to console log .vs. app insights.
    // NOTE: In production environment, you should consider logging this to Azure
    //       application insights.
    console.error(`\n [onTurnError] unhandled error: ${error}`);
    // Send a trace activity, which will be displayed in Bot Framework Emulator
    yield context.sendTraceActivity('OnTurnError Trace', `${error}`, 'https://www.botframework.com/schemas/error', 'TurnError');
    // Send a message to the user
    yield context.sendActivity('The bot encountered an error or bug.');
    yield context.sendActivity('To continue to run this bot, please fix the bot source code.');
    // Clear out state
    yield conversationState.delete(context);
});
adapter.onTurnError = onTurnErrorHandler;
let conversationState;
let userState;
const memoryStorage = new botbuilder_1.MemoryStorage();
conversationState = new botbuilder_1.ConversationState(memoryStorage);
userState = new botbuilder_1.UserState(memoryStorage);
const adaptiveDialog = new botbuilder_dialogs_adaptive_1.AdaptiveDialog(BOOKING_DIALOG);
const dialog = new mainDialog_1.MainDialog(adaptiveDialog);
const bot = new bookingBot_1.DialogAndWelcomeBot(conversationState, userState, dialog);
// Create API Server.
app.post("/api/messages", (req, res) => {
    adapter.processActivity(req, res, (context) => __awaiter(void 0, void 0, void 0, function* () {
        // Route to main dialog.
        yield bot.run(context);
    }));
});
// start the Express server
const server = app.listen(port, () => {
    // tslint:disable-next-line:no-console
    console.log(`server started at http://localhost:${port}`);
});
//# sourceMappingURL=index.js.map