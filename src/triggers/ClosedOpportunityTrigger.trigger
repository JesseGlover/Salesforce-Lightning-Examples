/**
 * Created by jglov on 12/24/2019.
 */

trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    // A list of tasks
    List<Task> taskList = new List<Task>();

    // loop through opportunity based on the new trigger
    for (Opportunity opportunity : Trigger.new) {
        // make sure that the trigger is only checking for the is insert stage
        if (Trigger.isInsert) {
            // check if the stage name of the opportunity is Closed Won
            if (opportunity.StageName == 'Closed Won') {
                // add a new task called Follow Up Test Task and set the WhatId to
                // opportunity Id
                taskList.add(new Task
                        (Subject = 'Follow Up Test Task', WhatId = opportunity.Id));
            }
        }

        // make sure that the trigger is only checking for the is update stage
        if (Trigger.isUpdate) {
            // check if the stage name of the opportunity is Closed Won and
            // check if the stage name of the opportunity is not the same as the old
            // trigger's result.
            if (opportunity.StageName == 'Closed Won' && opportunity.StageName !=
                    Trigger.oldMap.get(opportunity.Id).StageName) {
                // add a new task called Follow Up Test Task and set the WhatId to
                // opportunity Id
                taskList.add(
                        new Task(Subject = 'Follow Up Test Task', WhatId = opportunity.Id));
            }
        }
    }

    // check if the size of the tasklist is greater than 0
    if (taskList.size() > 0) {
        // if it is, insert the task list
        insert taskList;
    }
}