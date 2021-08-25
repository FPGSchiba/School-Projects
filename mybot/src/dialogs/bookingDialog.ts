// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

import { InputHints, MessageFactory } from 'botbuilder';
import {
    ConfirmPrompt,
    DialogTurnResult,
    TextPrompt,
    WaterfallDialog,
    WaterfallStepContext
} from 'botbuilder-dialogs';
import { TestDetails } from './bookingDetails';
import { CancelAndHelpDialog } from './cancelAndHelpDialog';

const CONFIRM_PROMPT = 'confirmPrompt';
const TEXT_PROMPT = 'textPrompt';
const WATERFALL_DIALOG = 'waterfallDialog';

export class BookingDialog extends CancelAndHelpDialog {
    constructor(id: string) {
        super(id || 'bookingDialog');

        this.addDialog(new TextPrompt(TEXT_PROMPT))
            .addDialog(new ConfirmPrompt(CONFIRM_PROMPT))
            .addDialog(new WaterfallDialog(WATERFALL_DIALOG, [
                this.destinationStep.bind(this),
                this.originStep.bind(this),
                this.travelDateStep.bind(this),
                this.confirmStep.bind(this),
                this.finalStep.bind(this)
            ]));

        this.initialDialogId = WATERFALL_DIALOG;
    }

    private async destinationStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const testDetails = stepContext.options as TestDetails;

        if (!testDetails) {
            const messageText = 'To what city would you like to travel?';
            const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
            return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        } else {
            return await stepContext.next(testDetails);
        }
    }

    private async originStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const bookingDetails = stepContext.options as TestDetails;

        // Capture the response to the previous step's prompt
        bookingDetails.name = stepContext.result;
        if (!bookingDetails) {
            const messageText = 'From what city will you be travelling?';
            const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
            return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        } else {
            return await stepContext.next(bookingDetails);
        }
    }

    private async travelDateStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const bookingDetails = stepContext.options as TestDetails;
        bookingDetails.name = stepContext.result;
        console.log(bookingDetails);
        const messageText = 'Which Date would you like to travel on?';
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
        return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
    }

    private async confirmStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const bookingDetails = stepContext.options as TestDetails;

        // Capture the results of the previous step
        bookingDetails.name = stepContext.result;
        const messageText = `Please confirm, I have you traveling to: ${ bookingDetails.name } from: ${ bookingDetails.name } on: ${ bookingDetails.name }. Is this correct?`;
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);

        // Offer a YES/NO prompt.
        return await stepContext.prompt(CONFIRM_PROMPT, { prompt: msg });
    }

    private async finalStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        if (stepContext.result === true) {
            const bookingDetails = stepContext.options as TestDetails;

            return await stepContext.endDialog(bookingDetails);
        }
        return await stepContext.endDialog();
    }

    private isAmbiguous(timex: string): boolean {
        var re = new RegExp("\d{1,2}(\.|\/)\d{1,2}(\.|\/)\d{2,4}");
        return re.exec(timex) != null;
    }
}
