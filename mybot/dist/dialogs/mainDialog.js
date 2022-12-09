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
const botbuilder_1 = require("botbuilder");
const botbuilder_dialogs_1 = require("botbuilder-dialogs");
const botbuilder_dialogs_2 = require("botbuilder-dialogs");
const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';
const TEXT_PROMPT = 'TextPrompt';
class MainDialog extends botbuilder_dialogs_2.ComponentDialog {
    constructor(Flows) {
        super('MainDialog');
        this.flows = Flows;
        if (!Flows)
            throw new Error('[MainDialog]: Missing parameter \'Flows\' is required');
        this.addDialog(new botbuilder_dialogs_2.TextPrompt(TEXT_PROMPT));
        Flows.forEach((Flow) => {
            this.addDialog(Flow.Dialog);
        });
        this.addDialog(new botbuilder_dialogs_1.WaterfallDialog(MAIN_WATERFALL_DIALOG, [
            this.introStep.bind(this),
            this.actStep.bind(this),
            this.finalStep.bind(this)
        ]));
        this.initialDialogId = MAIN_WATERFALL_DIALOG;
    }
    run(context, accessor) {
        return __awaiter(this, void 0, void 0, function* () {
            const dialogSet = new botbuilder_dialogs_2.DialogSet(accessor);
            dialogSet.add(this);
            const dialogContext = yield dialogSet.createContext(context);
            const results = yield dialogContext.continueDialog();
            if (results.status === botbuilder_dialogs_2.DialogTurnStatus.empty) {
                yield dialogContext.beginDialog(this.id);
            }
        });
    }
    introStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            yield stepContext.context.sendActivity("I am a Chat-Bot a Virtual-Assistant to help you with your Problems", null, botbuilder_1.InputHints.IgnoringInput);
            const messageText = "How may I help you?";
            const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
            return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        });
    }
    actStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            var resultID = "";
            this.flows.forEach((flow) => {
                if (flow.Entry.includes(stepContext.context.activity.text)) {
                    resultID = flow.Dialog.id;
                }
            });
            if (resultID != "") {
                return yield stepContext.beginDialog(resultID);
            }
            else {
                const messageText = `I did not find that flow.`;
                yield stepContext.context.sendActivity(messageText, null, botbuilder_1.InputHints.IgnoringInput);
            }
            return yield stepContext.next();
        });
    }
    finalStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield stepContext.replaceDialog(this.id);
        });
    }
}
exports.MainDialog = MainDialog;
//# sourceMappingURL=mainDialog.js.map