sap.ui.define(
  [
    "sap/m/MessageToast",
    "sap/ui/core/Fragment",
    "sap/m/MessageBox",
    "sap/ui/core/Core"
  ],
  function (MessageToast, Fragment, MessageBox, Core) {
    "use strict";

    // ====== CONFIG ======
    const FRAG_NAME = "benchlist.employeebenchlist.ext.fragment.UploadDialog";
    const FRAG_ID = "benchlistUploadDialog"; // used by Fragment.byId(FRAG_ID, ...)

    // ====== STATE ======
    let pDialog;
    let oDialog;
    let selectedFile = null;

    // ✅ store FE OData model once resolved during onUploadPress
    let oMainModel = null;

    // -------------------------
    // Helpers
    // -------------------------
    function isODataV4Model(m) {
      return !!(m && typeof m.bindContext === "function");
    }

    function readFileAsBase64(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onerror = () => reject(reader.error || new Error("File read failed"));
        reader.onload = () => {
          const result = String(reader.result || "");
          const base64 = result.includes(",") ? result.split(",")[1] : "";
          if (!base64) return reject(new Error("Could not extract base64 from file."));
          resolve(base64);
        };
        reader.readAsDataURL(file);
      });
    }

    function getFragControl(sId) {
      return Fragment.byId(FRAG_ID, sId);
    }

    function setSelectedFileText(sText) {
      const oText = getFragControl("selectedFileText");
      if (oText) oText.setText(sText || "");
    }

    // -------------------------
    // ✅ Model resolution that works when FE passes no params
    // Tries: oParams.extensionAPI -> this.getModel -> this.getView().getModel -> UIArea scan
    // -------------------------
    function resolveODataModel(oParams, oThis) {
      // 1) FE action params sometimes carry extensionAPI
      const oExtApi = oParams && (oParams.extensionAPI || oParams.oExtensionAPI);
      if (oExtApi && typeof oExtApi.getModel === "function") {
        const m = oExtApi.getModel();
        if (isODataV4Model(m)) return m;
      }

      // 2) FE sometimes binds `this` to an object that has getModel()
      if (oThis && typeof oThis.getModel === "function") {
        const m = oThis.getModel();
        if (isODataV4Model(m)) return m;
      }

      // 3) Sometimes `this` is a controller-like object
      if (oThis && typeof oThis.getView === "function") {
        const v = oThis.getView();
        if (v && typeof v.getModel === "function") {
          const m = v.getModel();
          if (isODataV4Model(m)) return m;
        }
      }

      // 4) If params is a UI5 event, try source model or parents
      const oSource = oParams && typeof oParams.getSource === "function" && oParams.getSource();
      if (oSource) {
        // walk up parents until we find a control with OData V4 model
        let c = oSource;
        while (c) {
          if (typeof c.getModel === "function") {
            const m = c.getModel();
            if (isODataV4Model(m)) return m;
          }
          c = c.getParent && c.getParent();
        }
      }

      // 5) Last resort: scan UIAreas, find owner component, use its default model
      const mUIAreas = Core.mUIAreas || {};
      const aAreas = Object.keys(mUIAreas).map((k) => mUIAreas[k]).filter(Boolean);

      for (let i = 0; i < aAreas.length; i++) {
        const ua = aAreas[i];
        const root = ua && ua.getRootNode && ua.getRootNode();
        if (!root) continue;

        const comp = sap.ui.core.Component.getOwnerComponentFor(root);
        if (comp && typeof comp.getModel === "function") {
          const m = comp.getModel();
          if (isODataV4Model(m)) return m;
        }
      }

      // Helpful debug to see what FE is passing
      // (You can keep this temporarily)
      console.log("DEBUG onUploadPress args:", { oParams, thisObj: oThis });

      throw new Error(
        "Could not resolve OData V4 model. In your runtime, FE is not passing extensionAPI/press event, " +
        "and `this` is not bound to an object with getModel()."
      );
    }

    // -------------------------
    // OData V4 Action execution (NO manual CSRF)
    // -------------------------
    async function executeUploadBenchData(oModel, fileName, base64Content) {
      const oAction = oModel.bindContext("/uploadBenchData(...)"); // unbound action
      oAction.setParameter("fileName", fileName);
      oAction.setParameter("content", base64Content);

      await oAction.execute(); // UI5 handles CSRF internally

      const oObj = oAction.getBoundContext && oAction.getBoundContext() && oAction.getBoundContext().getObject();
      return (oObj && typeof oObj === "object" && "value" in oObj) ? oObj.value : oObj;
    }

    // -------------------------
    // Fragment Controller
    // -------------------------
    const oFragController = {
      onFileChange: function (oEvent) {
        let file = null;

        const aFiles = oEvent && oEvent.getParameter && oEvent.getParameter("files");
        if (aFiles && aFiles[0]) file = aFiles[0];

        if (!file) {
          const src = oEvent && oEvent.getSource && oEvent.getSource();
          const domRef = src && src.getFocusDomRef && src.getFocusDomRef();
          file = domRef && domRef.files && domRef.files[0];
        }

        selectedFile = file || null;
        setSelectedFileText(selectedFile ? ("Selected: " + selectedFile.name) : "");
      },

      onConfirmUpload: async function () {
        try {
          if (!selectedFile) {
            MessageBox.warning("Please choose a file first.");
            return;
          }

          // ✅ NEVER rely on event-source model inside dialog.
          // Use dialog model (preferred) or stored main model.
          const oModel = (oDialog && oDialog.getModel && oDialog.getModel()) || oMainModel;
          if (!isODataV4Model(oModel)) {
            throw new Error(
              "OData V4 model not available on dialog. " +
              "This means onUploadPress could not capture and set the FE model."
            );
          }

          const base64 = await readFileAsBase64(selectedFile);
          const processed = await executeUploadBenchData(oModel, selectedFile.name, base64);

          MessageToast.show("Upload successful. Processed: " + processed);
          oDialog && oDialog.close();

          setTimeout(() => window.location.reload(), 400);
        } catch (e) {
          MessageBox.error("Upload failed: " + (e && e.message ? e.message : String(e)));
        }
      },

      onCancelUpload: function () {
        oDialog && oDialog.close();
      }
    };

    // -------------------------
    // Dialog Loader
    // -------------------------
    async function getDialog() {
      if (!pDialog) {
        pDialog = Fragment.load({
          id: FRAG_ID,
          name: FRAG_NAME,
          controller: oFragController
        })
          .then(function (dlg) {
            oDialog = dlg;
            return dlg;
          })
          .catch(function (e) {
            pDialog = null;
            throw e;
          });
      }
      return pDialog;
    }

    // -------------------------
    // Exported handler called by manifest "press"
    // -------------------------
    return {
      // IMPORTANT: FE may call this with NO params.
      onUploadPress: async function (oParams) {
        try {
          // ✅ resolve model using oParams OR `this` binding
          oMainModel = resolveODataModel(oParams, this);

          const dlg = await getDialog();

          // ✅ Ensure dialog has the model so fragment buttons can access it
          dlg.setModel(oMainModel);

          // reset state
          selectedFile = null;
          setSelectedFileText("");

          dlg.open();
        } catch (e) {
          console.error(e);
          MessageBox.error("Failed to open dialog:\n" + (e && e.message ? e.message : String(e)));
        }
      }
    };
  }
);