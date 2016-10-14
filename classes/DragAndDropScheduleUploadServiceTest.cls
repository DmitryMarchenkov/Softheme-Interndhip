@isTest
private class DragAndDropScheduleUploadServiceTest {
	
	@isTest 
	static void testAttachDoc() {
		Date scheduleDate = Date.today();
		String dateString = scheduleDate.year() + '-' + scheduleDate.month() + '-' + scheduleDate.day();
		TestSetupWebService.scheduleDate = dateString;

		TestSetupWebService.createRequestSchedule();
		DragAndDropScheduleUploadService.attachDoc();

		Test.startTest();
			DragAndDropScheduleUploadService.attachDoc();
		Test.stopTest();

		List<Schedule__c> schedules = [SELECT Id, ScheduleDate__c FROM Schedule__c];
		System.assertEquals(1, schedules.size(), 'Schedule did not be inserted');
		System.assertEquals(scheduleDate, schedules[0].ScheduleDate__c, 'Schedule Date does not match');

		List<Attachment> attachment = [SELECT Id, Name, Body FROM Attachment];
		System.assertEquals(1, attachment.size(), 'Attachment did not be inserted');
		System.assertEquals(TestSetupWebService.filename + '.' + TestSetupWebService.fileres, attachment[0].Name, 'Attachment Name does not match');
		System.assertEquals(TestSetupWebService.fileBody.toString(), attachment[0].Body.toString(), 'Attachment Body does not match');
	}
}