import Bee from "@mailupinc/bee-plugin";

function initBee() {
  $.ajax({ url: "/editor/token", success: startBee });
}

function beeConfig() {
  return {
    uid: "RailsExampleApp",
    container: "bee-plugin-container",
    language: "en-US",
    autosave: false,
    preventClose: false,
    onSave: (jsonFile, htmlFile) => {
      console.log("onSave", jsonFile, htmlFile);
    },
    onSaveAsTemplate: (jsonFile) => {
      console.log("onSaveAsTemplate", jsonFile);
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
