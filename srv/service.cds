using { benchlist as my } from '../db/schema.cds';

@path: '/service/benchlist'
@requires: 'authenticated-user'
service benchlistSrv {
  @odata.draft.enabled
  entity BenchLists as projection on my.BenchLists;
}

@path: '/service/skillwisesplit'
@requires: 'authenticated-user'
service skillwisesplitSrv {
 // @odata.draft.enabled
  @readonly
  entity SkillwiseSplits as projection on my.SkillwiseSplits;
  @odata.draft.enabled
  entity Roles as projection on my.Roles;
  @odata.draft.enabled
  entity BenchStatuses as projection on my.BenchStatuses;
  @odata.draft.enabled
  entity ResourceProposalStatuses as projection on my.ResourceProposalStatuses;
}