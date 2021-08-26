import { InputHints, MessageFactory } from 'botbuilder';
import {
    ConfirmPrompt,
    DialogTurnResult,
    TextPrompt,
    WaterfallDialog,
    WaterfallStepContext
} from 'botbuilder-dialogs';
import { BookingDetails } from './slots/bookingDetails';
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
        const bookingDetails = stepContext.options as BookingDetails;

        if (!bookingDetails.destination) {
            const messageText = 'To what city would you like to travel?';
            const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
            return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        } else {
            return await stepContext.next(bookingDetails.destination);
        }
    }

    private async originStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const bookingDetails = stepContext.options as BookingDetails;

        bookingDetails.destination = stepContext.result;
        if (!bookingDetails.origin) {
            const messageText = 'From what city will you be travelling?';
            const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
            return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        } else {
            return await stepContext.next(bookingDetails.origin);
        }
    }

    private async travelDateStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const bookingDetails = stepContext.options as BookingDetails;
        bookingDetails.origin = stepContext.result;

        const messageText = 'On which Date will you be Traveling?';
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);

        return await stepContext.prompt(TEXT_PROMPT, {prompt: msg});
    }

    private async confirmStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const bookingDetails = stepContext.options as BookingDetails;

        bookingDetails.travelDate = stepContext.result;
        const messageText = `Please confirm, I have you traveling to: ${ bookingDetails.destination } from: ${ bookingDetails.origin } on: ${ bookingDetails.travelDate }. Is this correct?`;
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);

        return await stepContext.prompt(CONFIRM_PROMPT, { prompt: msg });
    }

    private async finalStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        if (stepContext.result === true) {
            const bookingDetails = stepContext.options as BookingDetails;

            return await stepContext.endDialog(bookingDetails);
        }
        return await stepContext.endDialog();
    }
}
