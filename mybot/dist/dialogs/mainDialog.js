"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MainDialog = void 0;
const botbuilder_dialogs_1 = require("botbuilder-dialogs");
const moment = require('moment');
const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';
class MainDialog extends botbuilder_dialogs_1.ComponentDialog {
    constructor(bookingDialog) {
        super('MainDialog');
        if (!bookingDialog)
            throw new Error('[MainDialog]: Missing parameter \'bookingDialog\' is required');
        // Define the main dialog and its related components.
        // This is a sample "book a flight" dialog.
        this.addDialog(new botbuilder_dialogs_1.TextPrompt('TextPrompt'))
            .addDialog(bookingDialog)
            .addDialog(new botbuilder_dialogs_1.WaterfallDialog(MAIN_WATERFALL_DIALOG, [
            this.introStep.bind(this),
            this.finalStep.bind(this)
        ]));
        this.initialDialogId = MAIN_WATERFALL_DIALOG;
    }
    run(context, accessor) {
        return __awaiter(this, void 0, void 0, function* () {
            const dialogSet = new botbuilder_dialogs_1.DialogSet(accessor);
            dialogSet.add(this);
            const dialogContext = yield dialogSet.createContext(context);
            const results = yield dialogContext.continueDialog();
            if (results.status === botbuilder_dialogs_1.DialogTurnStatus.empty) {
                yield dialogContext.beginDialog(this.id);
            }
        });
    }
    introStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            ;
            return yield stepContext.prompt("<emptyPrompt>", {});
        });
    }
    finalStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            if (stepContext.result) {
                const result = stepContext.result;
                const msg = `Your Name is ${result.name} and your email is ${result.mail}.`;
                yield stepContext.context.sendActivity(msg);
            }
            return yield stepContext.replaceDialog(this.initialDialogId, { restartMsg: 'What else can I do for you?' });
        });
    }
}
exports.MainDialog = MainDialog;
//# sourceMappingURL=mainDialog.js.map