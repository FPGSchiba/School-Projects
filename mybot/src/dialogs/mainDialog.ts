// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
import { TestDetails } from './bookingDetails';

import { InputHints, MessageFactory, StatePropertyAccessor, TurnContext } from 'botbuilder';
import { AdaptiveDialog } from 'botbuilder-dialogs-adaptive';
import * as data from "../../resources/test.json";
import {
    ComponentDialog,
    DialogSet,
    DialogState,
    DialogTurnResult,
    DialogTurnStatus,
    TextPrompt,
    WaterfallDialog,
    WaterfallStepContext
} from 'botbuilder-dialogs';
import { BookingDialog } from './bookingDialog';
const moment = require('moment');

const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';

export class MainDialog extends ComponentDialog {

    constructor(Dialog: AdaptiveDialog) {
        super('MainDialog');

        if (!Dialog) throw new Error('[MainDialog]: Missing parameter \'bookingDialog\' is required');

        // Define the main dialog and its related components.
        // This is a sample "book a flight" dialog.
        this.addDialog(new TextPrompt('TextPrompt'))
            .addDialog(Dialog)
            .addDialog(new WaterfallDialog(MAIN_WATERFALL_DIALOG, [
                this.introStep.bind(this),
                this.finalStep.bind(this)
            ]));

        this.initialDialogId = MAIN_WATERFALL_DIALOG;
    }


    public async run(context: TurnContext, accessor: StatePropertyAccessor<DialogState>) {
        const dialogSet = new DialogSet(accessor);
        dialogSet.add(this);
        const testDialog = new AdaptiveDialog("test");
        testDialog.schema = data;
        console.log(data);

        const dialogContext = await dialogSet.createContext(context);
        await testDialog.beginDialog(dialogContext);
    }

    private async introStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {;
        const messageText = (stepContext.options as any).restartMsg ? (stepContext.options as any).restartMsg : `What can I help you with today?\nSay something like "Book a flight from Paris to Berlin."`;
        const promptMessage = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
        return await stepContext.prompt('TextPrompt', { prompt: promptMessage });
    }

    private async finalStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        if (stepContext.result) {
            const result = stepContext.result as TestDetails;

            const msg = `Your Name is ${ result.name } and your email is ${ result.mail }.`;
            await stepContext.context.sendActivity(msg);
        }


        return await stepContext.replaceDialog(this.initialDialogId, { restartMsg: 'What else can I do for you?' });
    }
}
