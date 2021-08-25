import express from "express";
const app = express();
const port = 3978;


import { BotFrameworkAdapter, ConversationState, MemoryStorage, UserState } from 'botbuilder';

import { DialogAndWelcomeBot } from './bots/bookingBot';
import { MainDialog } from './dialogs/mainDialog';
import { AdaptiveDialog } from "botbuilder-dialogs-adaptive";
const BOOKING_DIALOG = 'bookingDialog';


const adapter = new BotFrameworkAdapter({
    appId: process.env.MicrosoftAppId,
    appPassword: process.env.MicrosoftAppPassword
});

// Catch-all for errors.
const onTurnErrorHandler = async (context: any, error: any) => {
    console.error(`\n [onTurnError] unhandled error: ${ error }`);

    // Send a trace activity, which will be displayed in Bot Framework Emulator
    await context.sendTraceActivity(
        'OnTurnError Trace',
        `${ error }`,
        'https://www.botframework.com/schemas/error',
        'TurnError'
    );

    // Send a message to the user
    await context.sendActivity('The bot encountered an error or bug.');
    await context.sendActivity('To continue to run this bot, please fix the bot source code.');
    // Clear out state
    await conversationState.delete(context);
};

adapter.onTurnError = onTurnErrorHandler;

let conversationState: ConversationState;
let userState: UserState;

const memoryStorage = new MemoryStorage();
conversationState = new ConversationState(memoryStorage);
userState = new UserState(memoryStorage);

const adaptiveDialog = new AdaptiveDialog(BOOKING_DIALOG);
const dialog = new MainDialog(adaptiveDialog);
const bot = new DialogAndWelcomeBot(conversationState, userState, dialog);

// Create API Server.
app.post( "/api/messages", ( req, res ) => {
    adapter.processActivity(req, res, async (context) => {
        // Route to main dialog.
        await bot.run(context);
    });
});

// start the Express server
const server = app.listen( port, () => {
    // tslint:disable-next-line:no-console
    console.log( `server started at http://localhost:${ port }` );
});