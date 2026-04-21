using benchlistSrv as service from '../../srv/service';
using from '../annotations';

annotate service.BenchLists with @(
    UI.SelectionFields: [
        dc,
        costCenter,
        platform,
        primarySkills,
        pillarLead,
        role,
    ],
    UI.LineItem       : [

        {
            $Type: 'UI.DataField',
            Value: dc,
        },
        {
            $Type: 'UI.DataField',
            Value: employeeNumber,
        },
        {
            $Type: 'UI.DataField',
            Value: name,
        },
        {
            $Type: 'UI.DataField',
            Value: costCenter,
        },
        {
            $Type: 'UI.DataField',
            Value: platform,
        },
        {
            $Type: 'UI.DataField',
            Value: primarySkills,
        },
        {
            $Type: 'UI.DataField',
            Value: availability,
        },
        {
            $Type: 'UI.DataField',
            Value: pillarLead,
        },
        {
            $Type: 'UI.DataField',
            Value: role,
        },
        {
            $Type: 'UI.DataField',
            Value: benchStatus,
            Label: 'benchStatus',
        },
        {
            $Type: 'UI.DataField',
            Value: resourceProposalStatus,
            Label: 'resourceProposalStatus',
        },
    ],
);

annotate service.BenchLists with {
    role @Common.Label: 'Role'
};
