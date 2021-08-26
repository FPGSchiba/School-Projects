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
exports.BookingDialog = void 0;
const botbuilder_1 = require("botbuilder");
const botbuilder_dialogs_1 = require("botbuilder-dialogs");
const cancelAndHelpDialog_1 = require("./cancelAndHelpDialog");
const CONFIRM_PROMPT = 'confirmPrompt';
const TEXT_PROMPT = 'textPrompt';
const WATERFALL_DIALOG = 'waterfallDialog';
class BookingDialog extends cancelAndHelpDialog_1.CancelAndHelpDialog {
    constructor(id) {
        super(id || 'bookingDialog');
        this.addDialog(new botbuilder_dialogs_1.TextPrompt(TEXT_PROMPT))
            .addDialog(new botbuilder_dialogs_1.ConfirmPrompt(CONFIRM_PROMPT))
            .addDialog(new botbuilder_dialogs_1.WaterfallDialog(WATERFALL_DIALOG, [
            this.destinationStep.bind(this),
            this.originStep.bind(this),
            this.travelDateStep.bind(this),
            this.confirmStep.bind(this),
            this.finalStep.bind(this)
        ]));
        this.initialDialogId = WATERFALL_DIALOG;
    }
    destinationStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const bookingDetails = stepContext.options;
            if (!bookingDetails.destination) {
                const messageText = 'To what city would you like to travel?';
                const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
                return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
            }
            else {
                return yield stepContext.next(bookingDetails.destination);
            }
        });
    }
    originStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const bookingDetails = stepContext.options;
            bookingDetails.destination = stepContext.result;
            if (!bookingDetails.origin) {
                const messageText = 'From what city will you be travelling?';
                const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
                return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
            }
            else {
                return yield stepContext.next(bookingDetails.origin);
            }
        });
    }
    travelDateStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const bookingDetails = stepContext.options;
            bookingDetails.origin = stepContext.result;
            const messageText = 'On which Date will you be Traveling?';
            const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
            return yield stepContext.prompt(TEXT_PROMPT, { prompt: msg });
        });
    }
    confirmStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            const bookingDetails = stepContext.options;
            bookingDetails.travelDate = stepContext.result;
            const messageText = `Please confirm, I have you traveling to: ${bookingDetails.destination} from: ${bookingDetails.origin} on: ${bookingDetails.travelDate}. Is this correct?`;
            const msg = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
            return yield stepContext.prompt(CONFIRM_PROMPT, { prompt: msg });
        });
    }
    finalStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            if (stepContext.result === true) {
                const bookingDetails = stepContext.options;
                return yield stepContext.endDialog(bookingDetails);
            }
            return yield stepContext.endDialog();
        });
    }
}
exports.BookingDialog = BookingDialog;
//# sourceMappingURL=bookingDialog.js.map