import Bee from "@mailupinc/bee-plugin";

function initBee() {
  if ($("#bee-plugin-container").length == 0) return;

  $.ajax({ url: "/bee_templates/token", success: startBee });
}

// For a complete list on the supported params https://docs.beefree.io/configuration-parameters/
function beeConfig() {
  return {
    uid: "RailsExampleApp",
    container: "bee-plugin-container",
    language: "en-US",
    autosave: false,
    preventClose: false,
    mergeTags: [
      { name: "First Name", value: "{{firstName}}" },
      { name: "Last Name", value: "{{lastName}}" },
    ],
    onSave: (jsonFile, htmlFile) => {
      console.log("onSave", jsonFile, htmlFile);
    },
    onSaveAsTemplate: (jsonFile) => {
      let name = prompt("Template name", "My template");

      $.ajax({
        method: "POST",
        url: "/bee_templates",
        data: { template: jsonFile, name: name },
        success: () => alert("Template saved"),
        error: (msg) => alert(`Couldn't save the template ${msg}`),
      });
    },
    onSend: (htmlFile) => {
      console.log("onSend", htmlFile);
    },
    onError: (errorMessage) => {
      console.log("onError ", errorMessage);
    },
  };
}

function startBee(auth) {
  $.ajax({
    url: $("#bee-plugin-container").data("template"),
    success: (template) => new Bee(auth).start(beeConfig(), template),
  });
}

$(document).on("turbolinks:load", initBee);
