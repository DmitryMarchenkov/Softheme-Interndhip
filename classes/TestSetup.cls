@isTest
public class TestSetup {
	public static MainPageController controller;
	public static Notation__c notation;
	public static Material__c material;
	public static Schedule__c schedule;
	public static Attachment attachment;
	public static List<Notation__c> notations;
	public static List<Attachment> attachments;
	public static Integer count;
	public static Integer numberToDelete;
	public static Date scheduleDate;
	public static String notationText; 
	public static Id attachmentParentId; 

	@isTest
	public static void init() {
		controller = new MainPageController();
		material = new Material__c();
		schedule = new Schedule__c();
		notations = new List<Notation__c>();
		attachments = new List<Attachment>();
	}	

	@isTest
	public static void insertNotations() {
		init();
		for(Integer i = 0; i < count; i++) {
			notation = new Notation__c();
			notation.Note__c = notationText + i;
			notations.add(notation);
		}
		insert notations;

		if(numberToDelete != null) {
			ApexPages.currentPage().getParameters().put('removeNotationId',notations[numberToDelete].Id);
		}
	}

	@isTest
	public static void insertSchedule() {
		init();
		schedule.ScheduleDate__c = scheduleDate;
		insert schedule;

		attachment = new Attachment();
		attachment.Name = 'Test ScheduleAtt';
		attachment.ParentId = schedule.Id;
		attachment.Body = Blob.valueOf('Test Schedule');
		insert attachment;
	}

	@isTest
	public static void insertMaterial() {
		init();
		material.Name = 'Web Test';
		material.Theme__c = 'Web';
		insert material;

		ApexPages.currentPage().getParameters().put('removeMaterialId',material.Id);
		attachmentParentId = material.Id;
		insertAttachment();
	}

	@isTest
	public static void insertAttachment() {
		init();
		for(Integer i = 0; i < count; i++) {
			attachment = new Attachment();
			attachment.Name = 'TestAttachment ' + i;
			attachment.ParentId = attachmentParentId;
			attachment.Body = Blob.valueOf('TestBODY' + i);
			attachments.add(attachment);
		}
		insert attachments;
		
		if(numberToDelete != null) {
			ApexPages.currentPage().getParameters().put('removeAttachmentId',attachments[numberToDelete].Id);
		}
	}
}