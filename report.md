## Level6 Ideation

# Caregiver does not receive the SMS or is not near its phone
  Some things we can not control, 100 percent. But with some strategies we can improve them. If caregiver not receive sms due to some reason i think in that case we can not do anything except to dubug the issue. But in that case in which phone is not near by caregiver we can manage this stuff in that way let say whenever caregiver receive message a pop up should appear appear on his side for some time and caregiver should response by clicking it so that we can confirm caregiver receive notification if he get message and in did not reply in given time we can deduct some points from his/her profile. In that way caregiver will be responsible to stay active on his phone when his status is avaialable.
  And when he did not reply intime notification send to anaother caregiver.

# How does the care giver enters the patient's house?
  In addtional info of patient we can store such things how to enter in house, and other details so that when care giver receive alert from patient he get that info too.

# What if our system is down? any ways to limit point of failure?
  - If we want to achieive high availablity then we have to Increase redundancy
  - So that if we have several clusters and one of them is down for some reason other still active in that way our end users not face any down time.
  - But if we increase redundancy, the cost also increase. SO it depends on our requirement how much we bare the down time.
  - To calulate availabilty we have this formula
  percentage of availability = (total elapsed time - sum of downtime)/ total elapsed time
  - But still we can not acheive 100% of availablity but as i said by some techniques we acheive to 99 to 99%
  
# Design Choices
- Design i choose MVC
- I create 3 folders alerts, health_centers, patients
  In alerts, create only alert schema
  In patients, create only patient schema
  In health_center, create schema of device, caregiver, health_center
- And create 3 files of alert, patient, health_center in johan_alerts_service directory
- In web/controller directory create alert_controller.

# Red flags in the current solution
As such there is no red flag in current solution. I tried to resolve as much possible corner cases.
- But maybe if we integrate with atual twilio we face some issue and at that time we can resolve those, and also we face some issues like above mentioned if message is not send properly,or its send but did not receive, These type of issues maybe we face in future and we have to figure out how to minimize these risk.


# Things that you would do differently
- I can add location of caregiver, and send notification to caregiver according to criteria like near location.
- Also i will add location of patient
- I will also add point criteria on caregiver profile and if he response on every notification in time we will add some extra bonus on his/her profile.
