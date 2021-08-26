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
const botbuilder_1 = require("botbuilder");
const Bot_1 = require("./bots/Bot");
const bookingDialog_1 = require("./dialogs/bookingDialog");
const welcomeDialog_1 = require("./dialogs/welcomeDialog");
const mainDialog_1 = require("./dialogs/mainDialog");
const selectDialog_1 = require("./dialogs/selectDialog");
require('source-map-support').install();
const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';
const app = express_1.default();
const port = 3978;
const adapter = new botbuilder_1.BotFrameworkAdapter({
    appId: process.env.MicrosoftAppId,
    appPassword: process.env.MicrosoftAppPassword
});
let conversationState;
let userState;
const memoryStorage = new botbuilder_1.MemoryStorage();
conversationState = new botbuilder_1.ConversationState(memoryStorage);
userState = new botbuilder_1.UserState(memoryStorage);
// Initialize Flows here
const flows = [
    {
        Dialog: new bookingDialog_1.BookingDialog("test"),
        Entry: ["test"]
    },
    {
        Dialog: new welcomeDialog_1.WelcomeDialog(),
        Entry: ["Example Flow"]
    }
];
const selectDialog = new selectDialog_1.SelectDialog(flows, MAIN_WATERFALL_DIALOG);
const dialog = new mainDialog_1.MainDialog(flows, selectDialog);
const bot = new Bot_1.FlowBot(conversationState, userState, dialog);
app.post("/api/messages", (req, res) => {
    adapter.processActivity(req, res, (context) => __awaiter(void 0, void 0, void 0, function* () {
        // Route to main dialog.
        yield bot.run(context);
    }));
});
app.listen(port, () => {
    // tslint:disable-next-line:no-console
    console.log(`bot started at http://localhost:${port}`);
});
//# sourceMappingURL=index.js.map