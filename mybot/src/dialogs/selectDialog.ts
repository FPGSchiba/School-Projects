import { InputHints, MessageFactory, StatePropertyAccessor, TurnContext } from 'botbuilder';
import { Flow } from '../components/Flow';
import { Prompt, WaterfallDialog } from 'botbuilder-dialogs';
import {
    ComponentDialog,
    DialogSet,
    DialogTurnResult,
    DialogState,
    TextPrompt,
    DialogTurnStatus,
    WaterfallStepContext
} from 'botbuilder-dialogs';
import { CancelAllDialogs } from 'botbuilder-dialogs-adaptive';
import { CancelAndHelpDialog } from './cancelAndHelpDialog';

const SELECT_DIALOG = 'selectWaterfallDialog';
const TEXT_PROMPT_SELECT = 'TextPrompt'

export class SelectDialog extends CancelAndHelpDialog {

    private flows: Flow[]
    private mainDialogID: string

    constructor(Flows: Flow[], MAIN_DIALOG_ID: string, id?: string ) {
        super(id || SELECT_DIALOG);

        this.flows = Flows;
        this.mainDialogID = MAIN_DIALOG_ID;

        if (!Flows && !MAIN_DIALOG_ID) throw new Error('[MainDialog]: Missing parameter "Flows" & "MAIN_DIALOG_ID" is required');
        this.addDialog(new TextPrompt(TEXT_PROMPT_SELECT))
        Flows.forEach((Flow) => {
            this.addDialog(Flow.Dialog)
        });

        this.addDialog(new WaterfallDialog(SELECT_DIALOG, [
            this.introStep.bind(this),
            this.actStep.bind(this),
            this.finalStep.bind(this)
        ]));

        this.initialDialogId = SELECT_DIALOG;
    }

    private async introStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        await stepContext.context.sendActivity("I am a Chat-Bot a Virtual-Assistant to help you with your Problems", null, InputHints.IgnoringInput);
        const messageText = "How may I help you?";
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
        return await stepContext.prompt(TEXT_PROMPT_SELECT, { prompt: msg });
    }

    private async actStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        var resultID = ""

        console.log(stepContext.result);
        this.flows.forEach((flow) => {
            if (flow.Entry.includes(stepContext.context.activity.text)){
                resultID = flow.Dialog.id;
            }
        });

        if(resultID != ""){
            await stepContext.beginDialog(resultID);
        }
        else{
            const messageText = `I did not find that flow.`;
            await stepContext.context.sendActivity(messageText, null, InputHints.IgnoringInput);
        }

        return await stepContext.next();
    }

    private async finalStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        return await stepContext.replaceDialog(this.mainDialogID);
    }
}
