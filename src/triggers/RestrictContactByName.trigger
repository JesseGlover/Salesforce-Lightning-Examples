/**
 * Created by jglov on 12/24/2019.
 */

trigger RestrictContactByName on Contact (before insert, before update) {
    //check contacts prior to insert or update for invalid data
    for (Contact c : Trigger.new) {
        //invalid name is invalid
        if (c.LastName == 'INVALIDNAME') {
            System.debug('Last Name is invalid: ' + c.LastName);
            c.addError('The Last Name "' + c.LastName + '" is not allowed for DML');
        }

    }
}