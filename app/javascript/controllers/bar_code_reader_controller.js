import { Controller } from "@hotwired/stimulus"
import "@zxing/library";


// Connects to data-controller="bar-code-reader"
export default class extends Controller {
  static targets = ['sourceSelect', 'sourceSelectPanel']

  connect() {
    let selectedDeviceId;
    const codeReader = new ZXing.BrowserMultiFormatReader();
    console.log("ZXing code reader initialized");
    codeReader
      .getVideoInputDevices()
      .then((videoInputDevices) => {
        selectedDeviceId = videoInputDevices[0].deviceId;
        if (videoInputDevices.length >= 1) {
          videoInputDevices.forEach((element) => {
            const sourceOption = document.createElement("option");
            sourceOption.text = element.label;
            sourceOption.value = element.deviceId;
            this.sourceSelectTarget.appendChild(sourceOption);
          });

          this.sourceSelectTarget.onchange = () => {
            selectedDeviceId = this.sourceSelectTarget.value;
          };

          const sourceSelectPanel =
            this.sourceSelectPanelTarget;
          this.sourceSelectPanelTarget.style.display = "block";
        }

        document.getElementById("startButton").addEventListener("click", () => {
          codeReader.decodeFromVideoDevice(
            selectedDeviceId,
            "video",
            (result, err) => {
              if (result) {
                console.log(result);
                document.getElementById("result").textContent = result.text;
              }
              if (err && !(err instanceof ZXing.NotFoundException)) {
                console.error(err);
                document.getElementById("result").textContent = err;
              }
            }
          );
          console.log(
            `Started continous decode from camera with id ${selectedDeviceId}`
          );
        });

        document.getElementById("resetButton").addEventListener("click", () => {
          codeReader.reset();
          document.getElementById("result").textContent = "";
          console.log("Reset.");
        });
      })
      .catch((err) => {
        console.error(err);
      });
  }
}
