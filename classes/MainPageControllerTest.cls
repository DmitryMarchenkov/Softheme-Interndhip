@isTest
private class MainPageControllerTest {
	
	@isTest 
	static void testSaveNotations() {
		TestSetup.init();
		String notationText = 'Test Notation';
		TestSetup.controller.inputNotation = notationText;

		Test.startTest();
			TestSetup.controller.saveNotations();
		Test.stopTest();

		List<Notation__c> notations = [SELECT Id FROM Notation__c WHERE Note__c = :notationText];
		System.assertEquals(1, notations.size(), 'Notation did not inserted!');
	}	

	@isTest 
	static void testSaveNotationsNeg() {
		TestSetup.init();
		String notationText = '   ';
		TestSetup.controller.inputNotation = notationText;

		Test.startTest();
			TestSetup.controller.saveNotations();
		Test.stopTest();

		List<Notation__c> notations = [SELECT Id FROM Notation__c WHERE Note__c = :notationText];
		System.assertEquals(0, notations.size(), 'Notation did not inserted!');
	}
	
	@isTest 
	public static void testRemoveMaterials() {
		TestSetup.count = 20;
		TestSetup.insertMaterial();

		List<Material__c> insertedMaterials = [SELECT Id FROM Material__c WHERE Theme__c = 'Web'];
		System.assertEquals(1, insertedMaterials.size(), 'Materials did not be inserted!');
		Test.startTest();
			TestSetup.controller.removeMaterial();
		Test.stopTest();

		List<Material__c> materials = [SELECT Id FROM Material__c WHERE Theme__c = 'Web'];
		System.assertEquals(0, materials.size(), 'Materials did not be deleted!');
	}
	
	@isTest 
	public static void testShowSchedule() {
		Date today = Date.today();
		TestSetup.scheduleDate = today;
		TestSetup.insertSchedule();
		TestSetup.controller.scheduleDate = TestSetup.scheduleDate;

		List<Schedule__c> insertedSchedule = [SELECT Id FROM Schedule__c WHERE ScheduleDate__c = :today];
		System.assertEquals(1, insertedSchedule.size(), 'Schedule did not be inserted!');
		Test.startTest();
			TestSetup.controller.showSchedule();
		Test.stopTest();

		List<Schedule__c> schedules = TestSetup.controller.schedules;
		System.assertEquals(1, schedules.size(), 'Schedule did not be obtained in controller!');

		Attachment scheduleImg = TestSetup.controller.scheduleImg;
		System.assertEquals('Test Schedule', scheduleImg.Body.toString(), 'Attachment for schedule does not exist!');
	}
	
	@isTest 
	public static void testShowScheduleNeg() {
		Date today = Date.today();
		TestSetup.scheduleDate = today.addDays(2);
		TestSetup.insertSchedule();

		List<Schedule__c> insertedSchedule = [SELECT Id FROM Schedule__c WHERE ScheduleDate__c = :today];
		System.assertEquals(0, insertedSchedule.size(), 'Schedule did not be inserted!');
		Test.startTest();
			TestSetup.controller.showSchedule();
		Test.stopTest();

		List<Schedule__c> schedules = TestSetup.controller.schedules;
		System.assertEquals(0, schedules.size(), 'Schedule did not be obtained in controller!');
	}

	@isTest 
	static void testRemoveNotation() {
		Integer countNotations = 10;
		TestSetup.numberToDelete = 3;
		TestSetup.count = countNotations;
		String notationText = 'Test Notation';
		TestSetup.notationText = notationText;
		TestSetup.insertNotations();

		List<Notation__c> insertedNotations = [SELECT Id, Note__c FROM Notation__c WHERE Note__c LIKE 'Test%'];
		System.assertEquals(countNotations, insertedNotations.size(), 'Notation did not inserted!');
		
		Test.startTest();
			TestSetup.controller.removeNotation();
		Test.stopTest();

		List<Notation__c> notations = [SELECT Id, Note__c FROM Notation__c WHERE Note__c LIKE 'Test%'];
		System.assertEquals(countNotations - 1, notations.size(), 'Notation did not inserted!');
	}

	@isTest 
	static void testRemoveAttachment() {
		Integer countAttachments = 10;
		TestSetup.count = countAttachments;
		TestSetup.numberToDelete = 3;

		TestSetup.insertMaterial();
		List<Attachment> insertedAttachment = [SELECT Id FROM Attachment];
		System.assertEquals(countAttachments, insertedAttachment.size(), 'Attachment did not inserted!');

		Test.startTest();
			TestSetup.controller.removeAttachment();
		Test.stopTest();

		List<Attachment> attachment = [SELECT Id FROM Attachment];
		System.assertEquals(countAttachments - 1, attachment.size(), 'Notation did not inserted!');
	}
}