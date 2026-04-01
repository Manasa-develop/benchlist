sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheBenchListsList.iSeeThisPage();
            Then.onTheBenchListsList.onFilterBar().iCheckFilterField("Skillwise Split");
            Then.onTheBenchListsList.onTable().iCheckColumns(9, {"dc":{"header":"DC"},"employeeNumber":{"header":"Employee Number"},"name":{"header":"Name"},"costCenter":{"header":"Cost Center"},"platform":{"header":"Platform"},"primarySkills":{"header":"Primary Skills"},"availability":{"header":"Availability"},"pillarLead":{"header":"Pillar Lead"},"skillwiseSplits_ID":{"header":"Skillwise Split"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheBenchListsList.onFilterBar().iExecuteSearch();
            
            Then.onTheBenchListsList.onTable().iCheckRows();

            When.onTheBenchListsList.onTable().iPressRow(0);
            Then.onTheBenchListsObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});