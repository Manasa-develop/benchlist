namespace benchlist;

using {
  cuid,
  managed
} from '@sap/cds/common';

entity BenchLists : cuid, managed {
  dc                     : String(20);
  employeeNumber         : String(10);
  name                   : String(100);
  costCenter             : String(30);
  platform               : String(20);
  role                   : String(50);
  primarySkills          : String(150);
  availability           : Integer;
  pillarLead             : String(100);
  benchStatus            : String(20);
  resourceProposalStatus : String(10);
  comment                : String(100);
//skillwiseSplits: Association to SkillwiseSplits;
}

@cds.persistence.skip
entity SkillwiseSplits as
  select from BenchLists {
    key primarySkills,
    key benchStatus,
    key role,
    key resourceProposalStatus,
        count(1) as employeeCount : Integer,
        // Navigation link (association) to BenchLists
        to_benchlists     : Association to many BenchLists
                              on to_benchlists.primarySkills = $self.primarySkills
                                                  /* and to_benchlists.benchStatus = $self.benchStatus
                                                     and to_benchlists.role = $self.role
                                                     and to_benchlists.resourceProposalStatus = $self.resourceProposalStatus */
  }
  group by
    primarySkills,
    benchStatus,
    role,
    resourceProposalStatus; 

/*  @assert.unique: {role: [role]}
 entity Roles : cuid {
   role : String(50) @mandatory;
 }

@assert.unique: {benchStatus: [benchStatus]}
entity BenchStatuses : cuid {
  benchStatus : String(20) @mandatory;
}

@assert.unique: {resourceProposalStatus: [resourceProposalStatus]}
entity ResourceProposalStatuses : cuid {
  resourceProposalStatus : String(10) @mandatory;
}
 */