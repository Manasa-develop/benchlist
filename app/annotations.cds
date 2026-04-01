using { benchlistSrv } from '../srv/service.cds';
using { skillwisesplitSrv } from '../srv/service.cds';

annotate benchlistSrv.BenchLists with @UI.HeaderInfo: { TypeName: 'Bench List', TypeNamePlural: 'Bench Lists' };
/* annotate benchlistSrv.BenchLists with {
  skillwiseSplits @Common.ValueList: {
    CollectionPath: 'SkillwiseSplits',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: skillwiseSplits_ID, 
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'benchStatus'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'role'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'resourceProposalStatus'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'primarySkills'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'count'
      },
    ],
  }
}; */
annotate benchlistSrv.BenchLists with {
  dc @title: 'DC';
  employeeNumber @title: 'Employee Number';
  name @title: 'Name';
  costCenter @title: 'Cost Center';
  platform @title: 'Platform';
  primarySkills @title: 'Primary Skills';
  availability @title: 'Availability';
  pillarLead @title: 'Pillar Lead';
  createdAt @title: 'Created At';
  createdBy @title: 'Created By';
  modifiedAt @title: 'Modified At';
  modifiedBy @title: 'Modified By'
};

annotate benchlistSrv.BenchLists with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: dc },
 { $Type: 'UI.DataField', Value: employeeNumber },
 { $Type: 'UI.DataField', Value: name },
 { $Type: 'UI.DataField', Value: costCenter },
 { $Type: 'UI.DataField', Value: platform },
 { $Type: 'UI.DataField', Value: primarySkills },
 { $Type: 'UI.DataField', Value: availability },
 { $Type: 'UI.DataField', Value: pillarLead },
    { $Type: 'UI.DataField', Label: 'Skillwise Split', Value: skillwiseSplits_ID }
];

annotate benchlistSrv.BenchLists with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: dc },
 { $Type: 'UI.DataField', Value: employeeNumber },
 { $Type: 'UI.DataField', Value: name },
 { $Type: 'UI.DataField', Value: costCenter },
 { $Type: 'UI.DataField', Value: platform },
 { $Type: 'UI.DataField', Value: primarySkills },
 { $Type: 'UI.DataField', Value: availability },
 { $Type: 'UI.DataField', Value: pillarLead },
 { $Type: 'UI.DataField', Value: createdAt },
 { $Type: 'UI.DataField', Value: createdBy },
 { $Type: 'UI.DataField', Value: modifiedAt },
 { $Type: 'UI.DataField', Value: modifiedBy },
    { $Type: 'UI.DataField', Label: 'Skillwise Split', Value: skillwiseSplits_ID }
  ]
};

/* annotate benchlistSrv.BenchLists with {
  skillwiseSplits @Common.Label: 'Skillwise Split'
}; */

annotate benchlistSrv.BenchLists with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate benchlistSrv.BenchLists with @UI.SelectionFields: [
  skillwiseSplits_ID
];

annotate skillwisesplitSrv.SkillwiseSplits with @UI.HeaderInfo: { TypeName: 'Skillwise Split', TypeNamePlural: 'Skillwise Splits' };
annotate skillwisesplitSrv.SkillwiseSplits with {
  primarySkills @title: 'Primary Skills';
  count @title: 'Count'
};

annotate skillwisesplitSrv.SkillwiseSplits with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: primarySkills },
 { $Type: 'UI.DataField', Value: count }
];

annotate skillwisesplitSrv.SkillwiseSplits with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: primarySkills },
 { $Type: 'UI.DataField', Value: count }
  ]
};

/* annotate skillwisesplitSrv.SkillwiseSplits with {
  benchList @Common.Label: 'Bench Lists'
}; */

annotate skillwisesplitSrv.SkillwiseSplits with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate skillwisesplitSrv.Roles with @UI.HeaderInfo: { TypeName: 'Role', TypeNamePlural: 'Roles', Title: { Value: role } };
annotate skillwisesplitSrv.Roles with {
  ID @UI.Hidden @Common.Text: { $value: role, ![@UI.TextArrangement]: #TextOnly }
};
annotate skillwisesplitSrv.Roles with @UI.Identification: [{ Value: role }];
annotate skillwisesplitSrv.Roles with {
  role @title: 'Role'
};

annotate skillwisesplitSrv.Roles with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: role }
];

annotate skillwisesplitSrv.Roles with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: role }
  ]
};

annotate skillwisesplitSrv.Roles with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate skillwisesplitSrv.Roles with @UI.SelectionFields: [
  role
];

annotate skillwisesplitSrv.BenchStatuses with @UI.HeaderInfo: { TypeName: 'Bench Status', TypeNamePlural: 'Bench Statuses', Title: { Value: benchStatus } };
annotate skillwisesplitSrv.BenchStatuses with {
  ID @UI.Hidden @Common.Text: { $value: benchStatus, ![@UI.TextArrangement]: #TextOnly }
};
annotate skillwisesplitSrv.BenchStatuses with @UI.Identification: [{ Value: benchStatus }];
annotate skillwisesplitSrv.BenchStatuses with {
  benchStatus @title: 'Bench Status'
};

annotate skillwisesplitSrv.BenchStatuses with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: benchStatus }
];

annotate skillwisesplitSrv.BenchStatuses with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: benchStatus }
  ]
};

annotate skillwisesplitSrv.BenchStatuses with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate skillwisesplitSrv.BenchStatuses with @UI.SelectionFields: [
  benchStatus
];

annotate skillwisesplitSrv.ResourceProposalStatuses with @UI.HeaderInfo: { TypeName: 'Resource Proposal Status', TypeNamePlural: 'Resource Proposal Statuses', Title: { Value: resourceProposalStatus } };
annotate skillwisesplitSrv.ResourceProposalStatuses with {
  ID @UI.Hidden @Common.Text: { $value: resourceProposalStatus, ![@UI.TextArrangement]: #TextOnly }
};
annotate skillwisesplitSrv.ResourceProposalStatuses with @UI.Identification: [{ Value: resourceProposalStatus }];
annotate skillwisesplitSrv.ResourceProposalStatuses with {
  resourceProposalStatus @title: 'Resource Proposal Status'
};

annotate skillwisesplitSrv.ResourceProposalStatuses with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: resourceProposalStatus }
];

annotate skillwisesplitSrv.ResourceProposalStatuses with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: resourceProposalStatus }
  ]
};

annotate skillwisesplitSrv.ResourceProposalStatuses with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate skillwisesplitSrv.ResourceProposalStatuses with @UI.SelectionFields: [
  resourceProposalStatus
];

