import { Controller } from "@hotwired/stimulus"
import "@zxing/library";


// Connects to data-controller="bar-code-reader"
export default class extends Controller {
  static targets = ['sourceSelect', 'sourceSelectPanel', 'result']

  connect() {
    let selectedDeviceId;
    this.codeReader = new ZXing.BrowserMultiFormatReader();
    console.log("ZXing code reader initialized");
    this.codeReader
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
            this.selectedDeviceId = this.sourceSelectTarget.value;
          };

          const sourceSelectPanel =
            this.sourceSelectPanelTarget;
          this.sourceSelectPanelTarget.style.display = "block";
        }
      })
      .catch((err) => {
        console.error(err); 
      });
  }
  start(){
    this.codeReader.decodeFromVideoDevice(
      this.selectedDeviceId,
      "video",
      (result, err) => {
        if (result) {
          console.log(result);
          this.resultTarget.textContent = result.text;
        }
        if (err && !(err instanceof ZXing.NotFoundException)) {
          console.error(err);
          this.resultTarget.textContent = err;
        }
      }
    );
    console.log(
      `Started continous decode from camera with id ${this.selectedDeviceId}`
    );

  }

  reset(){
    if (this.codeReader) {
      this.codeReader.reset();
      this.resultTarget.textContent = "";
      console.log("Reset.");
    }
  }
}
