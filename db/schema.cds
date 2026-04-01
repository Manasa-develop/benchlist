namespace benchlist;
using { cuid, managed } from '@sap/cds/common';

entity BenchLists : cuid, managed {
  dc: String(20);
  employeeNumber: String(10);
  name: String(100);
  costCenter: String(30);
  platform: String(20);
  role: String(50);
  primarySkills: String(150);
  availability: Integer;
  pillarLead: String(100);
  benchStatus: String(20);
  resourceProposalStatus: String(10);
  comment: String(100);
  //skillwiseSplits: Association to SkillwiseSplits;
}

@cds.persistence.skip
entity SkillwiseSplits as select from BenchLists {
  key benchStatus,
  key role,
  key resourceProposalStatus,
  key primarySkills,
  count(1) as count : Integer,
  
// Navigation link (association) to employees
    association to many BenchLists
      on BenchLists.primarySkills = $self.primarySkills as to_BenchLists

}
group by benchStatus,role,resourceProposalStatus,primarySkills;

/*  @cds.persistence.skip
entity SkillwiseSplits : cuid {
  benchStatus: String(20);
  role: String(50);
  resourceProposalStatus: String(10);
  primarySkills: String(150);
  count: Integer;
  benchList: Association to many BenchLists on benchList.skillwiseSplits = $self;
}
 */

@assert.unique: { role: [role] }
entity Roles : cuid {
  role: String(50) @mandatory;
}

@assert.unique: { benchStatus: [benchStatus] }
entity BenchStatuses : cuid {
  benchStatus: String(20) @mandatory;
}

@assert.unique: { resourceProposalStatus: [resourceProposalStatus] }
entity ResourceProposalStatuses : cuid {
  resourceProposalStatus: String(10) @mandatory;
}

