sap.ui.define([
  "sap/ui/core/Fragment",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sap/ui/core/Component",
  "sap/m/ColumnListItem",   
  "sap/m/Text"              

], function (Fragment, Filter, FilterOperator, Component, ColumnListItem , Text ) {
  "use strict";

  function _findView(oControl) {
    let o = oControl;
    while (o && !o.isA?.("sap.ui.core.mvc.View")) {
      o = o.getParent && o.getParent();
    }
    return o;
  }

  return {
   
onEmployeeCountPress: async function (oEvent) {
  const oSource = oEvent.getSource();
  const oView = _findView(oSource);
  const oRowData = oSource.getBindingContext().getObject();

  const aFilters = [
    new Filter("primarySkills", FilterOperator.EQ, oRowData.primarySkills),
    new Filter("benchStatus", FilterOperator.EQ, oRowData.benchStatus),
    new Filter("role", FilterOperator.EQ, oRowData.role),
    new Filter("resourceProposalStatus", FilterOperator.EQ, oRowData.resourceProposalStatus)
  ];

  const FRAGMENT_ID = "EmployeeDialog";

  if (!oView._employeeDialog) {
    oView._employeeDialog = await Fragment.load({
      id: FRAGMENT_ID,
      name: "benchlist.skillwisesplit.ext.fragment.EmployeeDialog",
      controller: this
    });
    oView.addDependent(oView._employeeDialog);
  }

  const oTable = Fragment.byId(FRAGMENT_ID, "employeeTable");

  oTable.bindItems({
    path: "/BenchListDetails",
    filters: aFilters,
    
  parameters: {
    $$groupId: "$auto"
  },
  template: new ColumnListItem({
    cells: [
      new Text({ text: "{dc}" }),
      new Text({ text: "{employeeNumber}" }),
      new Text({ text: "{name}" }),
      new Text({ text: "{costCenter}" }),
      new Text({ text: "{platform}" }),
      new Text({ text: "{role}" }),
      new Text({ text: "{primarySkills}" }),
      new Text({ text: "{availability}" }),
      new Text({ text: "{pillarLead}" }),
      new Text({ text: "{benchStatus}" }),
      new Text({ text: "{resourceProposalStatus}" }),
      new Text({ text: "{comment}" }),
    ]
  })
  });

  oView._employeeDialog.open();
},


    onDialogClose: function (oEvent) {
      const oView = _findView(oEvent.getSource());
      oView?._employeeDialog?.close();
    }
  };
});