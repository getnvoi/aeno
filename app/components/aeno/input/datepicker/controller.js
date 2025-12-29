import { Datepicker } from "stimulus-datepicker";

export default class extends Datepicker {
  static values = {
    ...Datepicker.values,
    locales: { type: Array, default: ["en-US", "default"] },
    dateFormat: { type: String, default: "MM/DD/YYYY" },
  };

  connect() {
    super.connect();
  }
}
