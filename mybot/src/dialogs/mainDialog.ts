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
import { SelectDialog } from './selectDialog';

const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';
const TEXT_PROMPT = 'TextPrompt'

export class MainDialog extends ComponentDialog {

    private flows: Flow[]

    constructor(Flows: Flow[]) {
        super('MainDialog');

        this.flows = Flows;

        if (!Flows) throw new Error('[MainDialog]: Missing parameter \'Flows\' is required');
        this.addDialog(new TextPrompt(TEXT_PROMPT))
        Flows.forEach((Flow) => {
            this.addDialog(Flow.Dialog)
        });
        this.addDialog(new WaterfallDialog(MAIN_WATERFALL_DIALOG, [
            this.introStep.bind(this),
            this.actStep.bind(this),
            this.finalStep.bind(this)
        ]))

        this.initialDialogId = MAIN_WATERFALL_DIALOG;
    }


    public async run(context: TurnContext, accessor: StatePropertyAccessor<DialogState>) {
        const dialogSet = new DialogSet(accessor);
        dialogSet.add(this);

        const dialogContext = await dialogSet.createContext(context);
        const results = await dialogContext.continueDialog();
        if (results.status === DialogTurnStatus.empty) {
            await dialogContext.beginDialog(this.id);
        }
    }

    private async introStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        await stepContext.context.sendActivity("I am a Chat-Bot a Virtual-Assistant to help you with your Problems", null, InputHints.IgnoringInput);
        const messageText = "How may I help you?";
        const msg = MessageFactory.text(messageText, messageText, InputHints.ExpectingInput);
        return await stepContext.prompt(TEXT_PROMPT, { prompt: msg });
    }

    private async actStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        var resultID = ""

        this.flows.forEach((flow) => {
            if (flow.Entry.includes(stepContext.context.activity.text)){
                resultID = flow.Dialog.id;
            }
        });

        if(resultID != ""){
            return await stepContext.beginDialog(resultID);
        }
        else{
            const messageText = `I did not find that flow.`;
            await stepContext.context.sendActivity(messageText, null, InputHints.IgnoringInput);
        }

        return await stepContext.next();
    }

    private async finalStep(stepContext: WaterfallStepContext): Promise<DialogTurnResult> {
        return await stepContext.replaceDialog(this.id);
    }
}
