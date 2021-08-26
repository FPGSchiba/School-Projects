import { ActivityHandler, BotState, ConversationState, StatePropertyAccessor, UserState } from 'botbuilder';
import { Dialog, DialogState } from 'botbuilder-dialogs';
import { MainDialog } from '../dialogs/mainDialog';

export class DialogBot extends ActivityHandler {
    private conversationState: BotState;
    private userState: BotState;
    private dialog: Dialog;
    private dialogState: StatePropertyAccessor<DialogState>;

    constructor(conversationState: BotState, userState: BotState, dialog: Dialog) {
        super();
        if (!conversationState) {
            throw new Error('[DialogBot]: Missing parameter. conversationState is required');
        }
        if (!userState) {
            throw new Error('[DialogBot]: Missing parameter. userState is required');
        }
        if (!dialog) {
            throw new Error('[DialogBot]: Missing parameter. dialog is required');
        }

        this.conversationState = conversationState as ConversationState;
        this.userState = userState as UserState;
        this.dialog = dialog;
        this.dialogState = this.conversationState.createProperty<DialogState>('DialogState');

        this.onMessage(async (context, next) => {
            console.log('Running dialog with Message Activity.');
            await (this.dialog as MainDialog).run(context, this.dialogState);

            await next();
        });
    }

    public async run(context: any): Promise<void> {
        await super.run(context);
        await this.conversationState.saveChanges(context, false);
        await this.userState.saveChanges(context, false);
    }
}
