public with sharing class CommentsQueueable implements Queueable,Database.AllowsCallouts {
    public List<Post__c> posts = new List<Post__c>();
    public CommentsQueueable(List<Post__c> posts) {
        this.posts = posts;
    }
    
    public void execute(QueueableContext context) {
        if(this.posts.size() == 0){
            return;
        }
        Post__c aPost = this.posts.remove(0);
        HttpResponse response  = commentsService.getCommentsByExternalId(aPost.External_Id__c);

        //logica de insertar
        List<CommentWrapper> commentsWrapp = CommentWrapper.parse(response.getbody());
        List<Comment__c> comments = new List<Comment__c>();

        for(CommentWrapper wrapp : commentsWrapp){
            Comment__c aComment = new Comment__c(
                Post__c = aPost.Id,
                External_Id__c = String.valueOf(wrapp.id),
                Name = wrapp.name,
                Email__c = wrapp.email,
                Body__c = wrapp.body
            );
            comments.add(aComment);
        }

        insert comments;


        if(this.posts.size() != 0){
            CommentsQueueable queueable = new CommentsQueueable(this.posts);
            System.enqueueJob(queueable);
        }
    }
}