import { InputHints, MessageFactory } from 'botbuilder';
import {
    ConfirmPrompt,
    DialogTurnResult,
    TextPrompt,
    WaterfallDialog,
    WaterfallStepContext
} from 'botbuilder-dialogs';
import { WelcomeDetails } from './slots/welcomeDetails';
import { CancelAndHelpDialog } from './cancelAndHelpDialog';

const CONFIRM_PROMPT = 'confirmPrompt';
const TEXT_PROMPT = 'textPrompt';
const WATERFALL_DIALOG = 'waterfallDialog';

export class WelcomeDialog extends CancelAndHelpDialog {
    constructor(id?: string) {
        super(id || 'welcomeDialog');

        this.addDialog(new TextPrompt(TEXT_PROMPT))
            .addDialog(new ConfirmPrompt(CONFIRM_PROMPT))
            .addDialog(new WaterfallDialog(WATERFALL_DIALOG, [
                this.greetingStep.bind(this),
                this.nameStep.bind(this),
                this.emailStep.bind(this),
                this.confirmStep.bind(this),
                this.finalStep.bind(this)
            ]));

        this.initialDialogId = WATERFALL_DIALOG;
    }

    private async greetingStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const messageText = 'Hello! I am a bot';
        const msg = MessageFactory.text(messageText, messageText, InputHints.IgnoringInput);
        return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
    }

    private async nameStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const welcomeDetails = stepContext.options as WelcomeDetails;

        if (!welcomeDetails.name) {
            const messageText = 'What is your name?';
            const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
            return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        } else {
            return await stepContext.next(welcomeDetails.name);
        }
    }

    private async emailStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const welcomeDetails = stepContext.options as WelcomeDetails;
        welcomeDetails.name = stepContext.result;

        const messageText = 'Your email is';
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);

        return await stepContext.prompt(TEXT_PROMPT, {prompt: msg});
    }

    private async confirmStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        const welcomeDetails = stepContext.options as WelcomeDetails;

        welcomeDetails.email = stepContext.result;
        const messageText = `Please confirm, Your name is ${ welcomeDetails.name } and your email is ${ welcomeDetails.email }. Is this correct?`;
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);

        return await stepContext.prompt(CONFIRM_PROMPT, { prompt: msg });
    }

    private async finalStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        if (stepContext.result === true) {
            const welcomeDetails = stepContext.options as WelcomeDetails;

            return await stepContext.endDialog(welcomeDetails);
        }
        return await stepContext.endDialog();
    }
}
