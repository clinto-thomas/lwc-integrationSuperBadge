/**
 * @description       : 
 * @author            : CLINTO THOMAS
 * @group             : 
 * @last modified on  : 11-24-2020
 * @last modified by  : CLINTO THOMAS
 * Modifications Log 
 * Ver   Date         Author          Modification
 * 1.0   11-24-2020   CLINTO THOMAS   Initial Version
**/
public class ProjectCalloutServiceMockFailure {
   //Implement http mock callout failure here 
   global HTTPResponse respond(HttpRequest request){
      HTTPResponse response = new HTTPResponse();
      response.setStatusCode(200);
      return response;
   }
}