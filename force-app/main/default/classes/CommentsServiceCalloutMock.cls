@isTest
global with sharing class CommentsServiceCalloutMock implements HttpCalloutMock {
    public String body = '['+
		'  {'+
		'    \"postId\": 5,'+
		'    \"id\": 21,'+
		'    \"name\": \"aliquid rerum mollitia qui a consectetur eum sed\",'+
		'    \"email\": \"Noemie@marques.me\",'+
		'    \"body\": \"deleniti aut sed molestias explicabo\\ncommodi odio ratione nesciunt\\nvoluptate doloremque est\\nnam autem error delectus\"'+
		'  },'+
		'  {'+
		'    \"postId\": 5,'+
		'    \"id\": 22,'+
		'    \"name\": \"porro repellendus aut tempore quis hic\",'+
		'    \"email\": \"Khalil@emile.co.uk\",'+
		'    \"body\": \"qui ipsa animi nostrum praesentium voluptatibus odit\\nqui non impedit cum qui nostrum aliquid fuga explicabo\\nvoluptatem fugit earum voluptas exercitationem temporibus dignissimos distinctio\\nesse inventore reprehenderit quidem ut incidunt nihil necessitatibus rerum\"'+
		'  },'+
		'  {'+
		'    \"postId\": 5,'+
		'    \"id\": 23,'+
		'    \"name\": \"quis tempora quidem nihil iste\",'+
		'    \"email\": \"Sophia@arianna.co.uk\",'+
		'    \"body\": \"voluptates provident repellendus iusto perspiciatis ex fugiat ut\\nut dolor nam aliquid et expedita voluptate\\nsunt vitae illo rerum in quos\\nvel eligendi enim quae fugiat est\"'+
		'  },'+
		'  {'+
		'    \"postId\": 5,'+
		'    \"id\": 24,'+
		'    \"name\": \"in tempore eos beatae est\",'+
		'    \"email\": \"Jeffery@juwan.us\",'+
		'    \"body\": \"repudiandae repellat quia\\nsequi est dolore explicabo nihil et\\net sit et\\net praesentium iste atque asperiores tenetur\"'+
		'  },'+
		'  {'+
		'    \"postId\": 5,'+
		'    \"id\": 25,'+
		'    \"name\": \"autem ab ea sit alias hic provident sit\",'+
		'    \"email\": \"Isaias_Kuhic@jarrett.net\",'+
		'    \"body\": \"sunt aut quae laboriosam sit ut impedit\\nadipisci harum laborum totam deleniti voluptas odit rem ea\\nnon iure distinctio ut velit doloribus\\net non ex\"'+
		'  }'+
		']';
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(this.body);
        response.setStatusCode(200);
        return response;
     }
}