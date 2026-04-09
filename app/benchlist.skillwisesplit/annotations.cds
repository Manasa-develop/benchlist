using skillwisesplitSrv as service from '../../srv/service';
using from '../annotations';

annotate service.SkillwiseSplits with @(
    UI.SelectionFields: [
        benchStatus,
        role,
        resourceProposalStatus,
    ],
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: primarySkills,
        },
        {
            $Type : 'UI.DataField',
            Value : employeeCount,
            @UI.Hidden,
        },
   /*      {
            $Type : 'UI.DataFieldWithNavigationPath',
            //$Type: 'UI.DataField',
            Label : 'Count',
            Target: 'to_benchlists',
            Value : employeeCount,
        }, */
    ]
);

/* annotate service.SkillwiseSplits with {
    benchStatus            @(
        Common.Label                   : 'Bench Status',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'BenchStatuses',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: benchStatus,
                ValueListProperty: 'benchStatus',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    );
    role                   @(
        Common.Label                   : 'Role',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Roles',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: role,
                ValueListProperty: 'role',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    );
    resourceProposalStatus @(
        Common.Label                   : 'Resource Proposed',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ResourceProposalStatuses',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: resourceProposalStatus,
                ValueListProperty: 'resourceProposalStatus',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    );
}; */

annotate service.SkillwiseSplits with {
    resourceProposalStatus @Common.Label: 'Resource Proposed'
};
