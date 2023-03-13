public with sharing class ScheduleClass implements Schedulable {
    public void execute(SchedulableContext ctx) {
        MyBatch batch = new MyBatch('NEXT_MONTH');
        ID executeId = Database.executeBatch(batch);
    }
}