/* Praveen Pujar
 * 2/3/2022
 * 
*/
public class JWTDemo{
 
    
     public JWTDemo() {      
        Auth.JWT jwt = new Auth.JWT();
        jwt.setSub('sf_handsonpracticeoftrailhead@psl.com'); 
        jwt.setAud('https://login.salesforce.com'); 
        jwt.setIss('3MVG9n_HvETGhr3B0gT8TcGeCIgxovMhR.bxHfrmD74HxMlCV0iy96W_p.cpfQpGzBhalB28nYw4HhkR5ARxQ');
        
        //Additional claims to set scope
        Map<String, Object> claims = new Map<String, Object>();
        claims.put('exp', system.now().gettime());
            
        jwt.setAdditionalClaims(claims);

        //Create the object that signs the JWT bearer token
        Auth.JWS jws = new Auth.JWS(jwt, 'salesforcetest');
        
        //Get the resulting JWS in case debugging is required
        String token = jws.getCompactSerialization();
        
        //Set the token endpoint that the JWT bearer token is posted to
        String tokenEndpoint = 'https://login.salesforce.com/services/oauth2/token';
        
        //POST the JWT bearer token
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
        
        //Get the access token
        String accessToken = bearer.getAccessToken();
        
         /*Http hp=new Http();
         HttpRequest req=new HttpRequest();
         req.setHeader('Authorization', 'Bearer '+accessToken);
         req.setEndpoint('https://praveenpujarpsl-dev-ed.my.salesforce.com/services/data/v48.0/sobjects/Account/');
         req.setMethod('GET'); */
       	 //With named credentials
       	 
       	 string service='/services/data/v48.0/sobjects/Account/'; 
         Http hp=new Http();
         HttpRequest req=new HttpRequest();
         req.setEndpoint('callout:JWT_Demo'+service);
         req.setMethod('GET');
         HttpResponse res=hp.send(req);
         System.debug('Res statuscode'+res.getstatuscode());
         System.debug('Res '+res.getbody());
         
         
      /* HttpResponse res=hp.send(req);
         System.debug('Res statuscode'+res.getstatuscode());
         System.debug('Res '+res.getbody());*/
         

    }
}