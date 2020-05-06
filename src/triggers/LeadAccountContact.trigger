/**
 * Created by Asel on 4/22/20.
 */

trigger LeadAccountContact on Lead (after insert) {
    for (Lead l : Trigger.new) {

        Account ac = new Account();
        ac.Name = l.LastName;
        ac.Phone = l.Phone;
        insert ac;

        Contact con = new Contact();
        con.LastName = l.LastName;
        con.Email = l.Email;
        con.Phone = l.Phone;
        con.AccountId = ac.Id;
        insert con;
    }

}
