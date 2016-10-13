@isTest
private class ClearNotationTest {

	@isTest
	public static void testClearNotation() {
		Integer notationsCount = 20;
		TestSetup.count = notationsCount;
		TestSetup.notationText = 'I am test notation';
		TestSetup.insertNotations();

		Test.startTest();
			ClearNotation scheduleClass = new ClearNotation();
			String sch = '0 0 1 * * ?';
			String jobID = system.schedule('Clear Notation', sch, scheduleClass);
		Test.stopTest();

 		CronTrigger ct = [	SELECT Id, CronExpression, TimesTriggered, NextFireTime
         					FROM CronTrigger 
         					WHERE id = :jobID];

        System.assertEquals(sch, ct.CronExpression);

		List<Notation__c> notations = [SELECT Id FROM Notation__c WHERE Note__c LIKE 'I am test notation%'];
		System.assertEquals(10, notations.size(), 'Scheduled class did not delete notations!');
	}
}