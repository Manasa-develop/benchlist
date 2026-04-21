using {benchlist as my} from '../db/schema.cds';

@path    : '/service/benchlist'
@requires: 'authenticated-user'
service benchlistSrv {
  @odata.draft.enabled
  entity BenchLists as projection on my.BenchLists;

  
  action uploadBenchData(
    fileName : String,
    content  : LargeBinary
  ) returns Integer;

}

@path    : '/service/skillwisesplit'
@requires: 'authenticated-user'
service skillwisesplitSrv {
  // @odata.draft.enabled
  @readonly
  @cds.redirection.target
  entity BenchListDetails         as projection on my.BenchLists;

  @readonly
  entity SkillwiseSplits          as projection on my.SkillwiseSplits;

  entity Roles                    as projection on my.Roles;
  entity BenchStatuses            as projection on my.BenchStatuses;
  entity ResourceProposalStatuses as projection on my.ResourceProposalStatuses;
}
