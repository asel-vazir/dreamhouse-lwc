/**
 * Created by Asel on 4/3/20.
 */

global class FOBCalloutScheduled implements Schedulable {
    global void execute(SchedulableContext sc) {
        FOBCalloutBatchJob fobBatch = new FOBCalloutBatchJob();
        Database.executeBatch(fobBatch, 200);

    }
}