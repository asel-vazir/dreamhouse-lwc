/**
 * Created by Asel on 3/26/20.
 */

global class InvoiceGenerateBatchScheduled implements Schedulable {
    global void execute(SchedulableContext sc) {
        InvoiceGenerateBatchJob invBatch = new InvoiceGenerateBatchJob();
        Database.executeBatch(invBatch, 200);

    }
}