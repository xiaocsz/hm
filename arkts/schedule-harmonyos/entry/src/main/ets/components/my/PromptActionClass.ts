// PromptActionClass.ts
import { BusinessError } from '@kit.BasicServicesKit';
import { ComponentContent, window } from '@kit.ArkUI';
import { UIContext } from '@ohos.arkui.UIContext';

export class PromptActionClass {
  static ctx: UIContext;
  static contentNode: ComponentContent<Object>;
  static options: Object;

  static setContext(context: UIContext) {
    this.ctx = context;
  }

  static setContentNode(node: ComponentContent<Object>) {
    this.contentNode = node;
  }

  static setOptions(options: Object) {
    this.options = options;
  }

  static openDialog() {
    if (this.contentNode !== null) {
      this.ctx.getPromptAction().openCustomDialog(this.contentNode, this.options)
        .then(() => {
          console.info('OpenCustomDialog complete.')
        })
        .catch((error: BusinessError) => {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          console.error(`OpenCustomDialog args error code is ${code}, message is ${message}`);
        })
    }
  }

  static closeDialog() {
    if (this.contentNode !== null) {
      this.ctx.getPromptAction().closeCustomDialog(this.contentNode)
        .then(() => {
          console.info('CloseCustomDialog complete.')
        })
        .catch((error: BusinessError) => {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          console.error(`CloseCustomDialog args error code is ${code}, message is ${message}`);
        })
    }
  }

  static updateDialog(options: Object) {
    if (this.contentNode !== null) {
      this.ctx.getPromptAction().updateCustomDialog(this.contentNode, options)
        .then(() => {
          console.info('UpdateCustomDialog complete.')
        })
        .catch((error: BusinessError) => {
          let message = (error as BusinessError).message;
          let code = (error as BusinessError).code;
          console.error(`UpdateCustomDialog args error code is ${code}, message is ${message}`);
        })
    }
  }
}