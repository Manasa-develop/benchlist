namespace benchlist;

using {
  managed
} from '@sap/cds/common';

@assert.unique: { employeeNumber: [employeeNumber] }
entity BenchLists : managed {
  key employeeNumber         : String(10);
  dc                     : String(20);
  name                   : String(100);
  costCenter             : String(30);
  platform               : String(20);
  role                   : String(50);
  primarySkills          : String(150);
  availability           : Decimal(5, 2);
  pillarLead             : String(100);
  benchStatus            : String(20);
  resourceProposalStatus : String(10);
  comment                : String(200);
}

entity SkillwiseSplits as
  select from BenchLists {
    key primarySkills,
    key benchStatus,
    key role,
    key resourceProposalStatus,
        count(1) as employeeCount : Integer,
  }
  group by
    primarySkills,
    benchStatus,
    role,
    resourceProposalStatus; 
 define view Roles as select from BenchLists {
  key role
 }
group by role;

define view BenchStatuses as select from BenchLists {
  key benchStatus
 }
group by benchStatus;


define view ResourceProposalStatuses as select from BenchLists {
  key resourceProposalStatus
 }
group by resourceProposalStatus;