sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"benchlist/skillwisesplit/test/integration/pages/SkillwiseSplitsList",
	"benchlist/skillwisesplit/test/integration/pages/SkillwiseSplitsObjectPage"
], function (JourneyRunner, SkillwiseSplitsList, SkillwiseSplitsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('benchlist/skillwisesplit') + '/test/flpSandbox.html#benchlistskillwisesplit-tile',
        pages: {
			onTheSkillwiseSplitsList: SkillwiseSplitsList,
			onTheSkillwiseSplitsObjectPage: SkillwiseSplitsObjectPage
        },
        async: true
    });

    return runner;
});

