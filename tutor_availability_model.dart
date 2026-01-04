/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Tutor Availability Data Model for the EduCare App.
- Defines the structure for tutor availability records
- Stores available days, time slots, and teaching mode
- Used by tutor manage availability screen
- Data will be retrieved by admin for scheduling purposes
--------------------------------------------------*/

class AvailabilitySlot {
  String startTime;
  String endTime;
  String mode;

  AvailabilitySlot({
    required this.startTime,
    required this.endTime,
    required this.mode,
  });
}

class TutorAvailabilityDay {
  String day;
  String date;
  bool isOn;
  List<AvailabilitySlot> slots;

  TutorAvailabilityDay({
    required this.day,
    required this.date,
    this.isOn = false,
    required this.slots,
  });
}
