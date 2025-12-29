import { Controller } from "@hotwired/stimulus";
import intlTelInput from "intl-tel-input";

export default class extends Controller {
  static values = {
    defaultCountry: { type: String, default: "us" },
    preferredCountries: { type: Array, default: ["us", "gb"] },
  };

  connect() {
    this.iti = intlTelInput(this.element, {
      initialCountry: this.defaultCountryValue,
      preferredCountries: this.preferredCountriesValue,
      utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@25.2.0/build/js/utils.js",
    });
  }

  disconnect() {
    if (this.iti) {
      this.iti.destroy();
    }
  }
}
