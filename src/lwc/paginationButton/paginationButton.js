/**
 * Created by gamedevmadeeasy on 1/24/20.
 */

import {LightningElement} from 'lwc';

export default class PaginationButton extends LightningElement {
    previousHandler() {
        this.dispatchEvent(new CustomEvent('previous'));
    }

    nextHandler() {
        this.dispatchEvent(new CustomEvent('next'));
    }
}