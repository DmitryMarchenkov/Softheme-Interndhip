@isTest
private class DragAndDropFileUploadServiceTest {
	
	@isTest 
	static void testAttachDoc() {
		String materialName = 'Test Material';
    	String materialTheme = 'Web';

		TestSetupWebService.materialName = materialName;
		TestSetupWebService.materialTheme = materialTheme;

		TestSetupWebService.createRequestMaterial();

		Test.startTest();
			DragAndDropFileUploadService.attachDoc();
		Test.stopTest();

		List<Material__c> materials = [SELECT Id, Name, Theme__c FROM Material__c];
		System.assertEquals(1, materials.size(), 'Material did not be inserted');
		System.assertEquals(materialName, materials[0].Name, 'Material Name does not match');
		System.assertEquals(materialTheme, materials[0].Theme__c, 'Material Theme does not match');

		List<Attachment> attachment = [SELECT Id, Name, Body FROM Attachment];
		System.assertEquals(1, attachment.size(), 'Attachment did not be inserted');
		System.assertEquals(TestSetupWebService.filename + '.' + TestSetupWebService.fileres, attachment[0].Name, 'Attachment Name does not match');
		System.assertEquals(TestSetupWebService.fileBody.toString(), attachment[0].Body.toString(), 'Attachment Body does not match');
	}
}