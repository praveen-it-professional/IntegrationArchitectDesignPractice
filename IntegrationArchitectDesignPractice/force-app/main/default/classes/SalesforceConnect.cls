public class SalesforceConnect {

    public static void makeCalloutToOtherOrg(){
        //Steps
        //1. Create Connected App in other org B, you will get customer key, client secret, redirect URL= Empty
        //2. Create an Auth.Provider in Org A, Select Provider Type- Salesforce, Enter Client secret and consumer key org B
        //authorization ednpoint and token endpoint will be mentioned here.
        //3. Update the step1- enter the redirect URL created in step2 in step1 and update
        //4. create named credentials in Org A to avoid exposing sensitive information in apex class like, endpoint url, authorization header
        //5. make callout
        Http ht=new Http();
        HttpRequest request=new HttpRequest();
        //request.setEndpoint('callout:CallToSFHandsOnOrg'+'/services/data/v29.0/sobjects/');
        /*request.setEndpoint('callout:CallToSFHandsOnOrg'+'/services/apexrest/getCase/002w00000PB2qv/');
        request.setMethod('GET');*/
        string meesage='{"subject" : "Bigfoot Sighting!","status" : "New","origin" : "Phone","priority" : "Low"}';
        request.setEndpoint('callout:CallToSFHandsOnOrg'+'/services/apexrest/getCase');
        request.setMethod('POST');
        request.setBody(meesage);
        request.setHeader('content-type', 'application/json');//otherwise you will get 415- unsupported media type
        
        HttpResponse resp=ht.send(request);
        if(resp.getStatusCode()==400){
            System.debug('Authorization Failed!!!');
        }else if(resp.getStatusCode()==200){
            System.debug('response returned:'+JSON.serializePretty(resp.getBody()));
        }
        
        HttpRequest request1=new HttpRequest();
        //request.setEndpoint('callout:CallToSFHandsOnOrg'+'/services/data/v29.0/sobjects/');
        request.setEndpoint('callout:CallToSFHandsOnOrg'+'/services/apexrest/getCase/5002w00000PB2tLAAT');
        request.setMethod('DELETE');
        
        HttpResponse resp1=ht.send(request);
        if(resp1.getStatusCode()==400){
            System.debug('Authorization Failed!!!');
        }else if(resp1.getStatusCode()==200){
            System.debug('response returned:'+JSON.serializePretty(resp1.getBody()));
        }
         
    }
}