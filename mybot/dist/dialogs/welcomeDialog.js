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
exports.WelcomeDialog = void 0;
const botbuilder_1 = require("botbuilder");
const botbuilder_dialogs_1 = require("botbuilder-dialogs");
const cancelAndHelpDialog_1 = require("./cancelAndHelpDialog");
const CONFIRM_PROMPT = 'confirmPrompt';
const TEXT_PROMPT = 'textPrompt';
const WATERFALL_DIALOG = 'waterfallDialog';
class WelcomeDialog extends cancelAndHelpDialog_1.CancelAndHelpDialog {
    constructor(id) {
        super(id || 'welcomeDialog');
        this.addDialog(new botbuilder_dialogs_1.TextPrompt(TEXT_PROMPT))
            .addDialog(new botbuilder_dialogs_1.ConfirmPrompt(CONFIRM_PROMPT))
            .addDialog(new botbuilder_dialogs_1.WaterfallDialog(WATERFALL_DIALOG, [
            this.greetingStep.bind(this),
            this.nameStep.bind(this),
            this.emailStep.bind(this),
            this.confirmStep.bind(this),
            this.finalStep.bind(this)
        ]));
        this.initialDialogId = WATERFALL_DIALOG;
    }
    greetingStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const messageText = 'Hello! I am a bot';
            const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.IgnoringInput);
            return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        });
    }
    nameStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const welcomeDetails = stepContext.options;
            if (!welcomeDetails.name) {
                const messageText = 'What is your name?';
                const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
                return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
            }
            else {
                return yield stepContext.next(welcomeDetails.name);
            }
        });
    }
    emailStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const welcomeDetails = stepContext.options;
            welcomeDetails.name = stepContext.result;
            const messageText = 'Your email is';
            const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
            return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        });
    }
    confirmStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const welcomeDetails = stepContext.options;
            welcomeDetails.email = stepContext.result;
            const messageText = `Please confirm, Your name is ${welcomeDetails.name} and your email is ${welcomeDetails.email}. Is this correct?`;
            const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
            return yield stepContext.prompt(CONFIRM_PROMPT, { prompt: msg });
        });
    }
    finalStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            if (stepContext.result === true) {
                const welcomeDetails = stepContext.options;
                return yield stepContext.endDialog(welcomeDetails);
            }
            return yield stepContext.endDialog();
        });
    }
}
exports.WelcomeDialog = WelcomeDialog;
//# sourceMappingURL=welcomeDialog.js.map