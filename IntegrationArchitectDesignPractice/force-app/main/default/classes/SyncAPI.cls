@RestResource(urlMapping='/getCase11/*')
global with sharing class SyncAPI {
    
    @HttpGet
    global static Case getCaseById(){
        RestRequest request= RestContext.request;
        string caseId= request.requestURI.substring(request.requestURI.lastIndexof('/')+1);
        
        Case cs=[Select Id,casenumber,subject from Case where id =:caseId];
        return cs;
    }
    
    @HttpPost
    global static Id insertCase(string subject, string status,string origin,string priority){
        
        Case cs=new Case(
        subject=subject,
        status=status,
        origin=origin,
        priority=priority
        );
        
        insert cs;
        return cs.id;
    }
    
    @HttpPatch
    global static Id upsertCase(){
        
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
 
    }
    
    @HttpPut
    global static ID upsertCase(String subject, String status,
        String origin, String priority, String id) {
        Case thisCase = new Case(
                Id=id,
                Subject=subject,
                Status=status,
                Origin=origin,
                Priority=priority);
        // Match case by Id, if present.
        // Otherwise, create new case.
        upsert thisCase;
        // Return the case ID.
        return thisCase.Id;
     }
    
    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
    }      
            

}