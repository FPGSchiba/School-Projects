"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
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
const botbuilder_dialogs_adaptive_1 = require("botbuilder-dialogs-adaptive");
const data = __importStar(require("../../resources/test.json"));
const botbuilder_dialogs_1 = require("botbuilder-dialogs");
const moment = require('moment');
const MAIN_WATERFALL_DIALOG = 'mainWaterfallDialog';
class MainDialog extends botbuilder_dialogs_1.ComponentDialog {
    constructor(Dialog) {
        super('MainDialog');
        if (!Dialog)
            throw new Error('[MainDialog]: Missing parameter \'bookingDialog\' is required');
        // Define the main dialog and its related components.
        // This is a sample "book a flight" dialog.
        this.addDialog(new botbuilder_dialogs_1.TextPrompt('TextPrompt'))
            .addDialog(Dialog)
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
            const testDialog = new botbuilder_dialogs_adaptive_1.AdaptiveDialog("test");
            testDialog.schema = data;
            console.log(data);
            const dialogContext = yield dialogSet.createContext(context);
            yield testDialog.beginDialog(dialogContext);
        });
    }
    introStep(stepContext) {
        return __awaiter(this, void 0, void 0, function* () {
            ;
            const messageText = stepContext.options.restartMsg ? stepContext.options.restartMsg : `What can I help you with today?\nSay something like "Book a flight from Paris to Berlin."`;
            const promptMessage = botbuilder_1.MessageFactory.text(messageText, messageText, botbuilder_1.InputHints.ExpectingInput);
            return yield stepContext.prompt('TextPrompt', { prompt: promptMessage });
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