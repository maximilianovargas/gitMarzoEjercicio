public with sharing class AccountManage {
    
    public List<Account> accounts;

    public AccountManage() {
        this.accounts = new List<Account>();
    }

    public AccountManage(List<Account> accounts){
        this.accounts = accounts;
    }

    public List<Account> getAccounts() {
        return this.accounts;
    }

    public static void staticMethod(Integer num) {
        num = 2+3;
    }
}