import express from "express";
import { BotFrameworkAdapter, ConversationState, MemoryStorage, UserState } from 'botbuilder';
import { Flow } from "./components/Flow";
import { FlowBot } from './bots/Bot';
import { BookingDialog } from "./dialogs/bookingDialog";
import { WelcomeDialog } from "./dialogs/welcomeDialog";
import { MainDialog } from "./dialogs/mainDialog";
import { SelectDialog } from "./dialogs/selectDialog";
require('source-map-support').install();

const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';
const app = express();
const port = 3978;

const adapter = new BotFrameworkAdapter({
    appId: process.env.MicrosoftAppId,
    appPassword: process.env.MicrosoftAppPassword
});

let conversationState: ConversationState;
let userState: UserState;

const memoryStorage = new MemoryStorage();
conversationState = new ConversationState(memoryStorage);
userState = new UserState(memoryStorage);

// Initialize Flows here
const flows:Flow[] = [
    {
        Dialog: new BookingDialog("test"),
        Entry: [ "test" ]
    },
    {
        Dialog: new WelcomeDialog(),
        Entry: [ "Example Flow" ]
    }
]

const selectDialog = new SelectDialog(flows, MAIN_WATERFALL_DIALOG)
const dialog = new MainDialog(flows, selectDialog);
const bot = new FlowBot(conversationState, userState, dialog);

app.post( "/api/messages", ( req, res ) => {
    adapter.processActivity(req, res, async (context) => {
        // Route to main dialog.
        await bot.run(context);
    });
});

app.listen( port, () => {
    // tslint:disable-next-line:no-console
    console.log( `bot started at http://localhost:${ port }` );
});