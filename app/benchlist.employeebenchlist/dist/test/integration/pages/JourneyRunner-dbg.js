sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"benchlist/employeebenchlist/test/integration/pages/BenchListsList",
	"benchlist/employeebenchlist/test/integration/pages/BenchListsObjectPage"
], function (JourneyRunner, BenchListsList, BenchListsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('benchlist/employeebenchlist') + '/test/flpSandbox.html#benchlistemployeebenchlist-tile',
        pages: {
			onTheBenchListsList: BenchListsList,
			onTheBenchListsObjectPage: BenchListsObjectPage
        },
        async: true
    });

    return runner;
});

