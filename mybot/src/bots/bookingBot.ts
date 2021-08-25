// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

import { BotState } from 'botbuilder';
import { Dialog, DialogState } from 'botbuilder-dialogs';
import { MainDialog } from '../dialogs/mainDialog';
import { DialogBot } from './dialogBot';

export class DialogAndWelcomeBot extends DialogBot {
    constructor(conversationState: BotState, userState: BotState, dialog: Dialog) {
        super(conversationState, userState, dialog);

        this.onMembersAdded(async (context, next) => {
            const membersAdded = context.activity.membersAdded;
            for (const member of membersAdded) {
                if (member.id !== context.activity.recipient.id) {
                    await (dialog as MainDialog).run(context, conversationState.createProperty<DialogState>('DialogState'));
                }
            }
            await next();
        });
    }
}
