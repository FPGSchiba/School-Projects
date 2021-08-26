import { BotState } from 'botbuilder';
import { Dialog, DialogState, DialogSet } from 'botbuilder-dialogs';
import { MainDialog } from '../dialogs/mainDialog';
import { DialogBot } from './dialogBot';

export class FlowBot extends DialogBot {
    constructor(conversationState: BotState, userState: BotState, dialog: Dialog) {
        super(conversationState, userState, dialog);

        this.onMembersAdded(async (context, next) => {
            const membersAdded = context.activity.membersAdded;
            for (const member of membersAdded) {
                if (member.id !== context.activity.recipient.id) {
                    console.log("Runnning MainDialog");
                    await (dialog as MainDialog).run(context, conversationState.createProperty<DialogState>('DialogState'));
                }
            }
            await next();
        });
    }
}
