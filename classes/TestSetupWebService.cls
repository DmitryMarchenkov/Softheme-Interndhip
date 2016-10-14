@isTest
public class TestSetupWebService {
	public static String materialName;	
	public static String materialTheme;	
	public static String scheduleDate;	

	public static String filename;	
	public static String fileres;	
	public static Blob fileBody;	

	@isTest
	public static void init() {
		filename = 'testFile';
    	fileres = 'jpg';
    	fileBody = Blob.valueOf('Test Attachment');
	}	

	@isTest
	public static void createRequestMaterial() {
		init();
		RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/DragAndDrop/materials'; 
        req.addParameter('FileName', filename);
        req.addParameter('FileResolution', fileres);
        req.addParameter('MaterialName', materialName);
        req.addParameter('MaterialTheme', materialTheme);
		req.requestBody = fileBody;

		req.httpMethod = 'POST';
		RestContext.request = req;
		RestContext.response = res;
	}	

	@isTest
	public static void createRequestSchedule() {
		init();
		RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/DragAndDrop/schedule'; 
        req.addParameter('FileName', filename);
        req.addParameter('FileResolution', fileres);
        req.addParameter('ScheduleDate', scheduleDate);
		req.requestBody = fileBody;
		req.httpMethod = 'POST';
		RestContext.request = req;
		RestContext.response = res;
	}
}