import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["box", "input"];
  static values = { pattern: String };
  static classes = ["filled"];

  connect() {
    this.inputTarget.focus();
    if (this.boxTargets.length > 0) {
      this.boxTargets[0].classList.add(this.filledClass);
    }
  }

  input() {
    const filtered = this.#filter(this.inputTarget.value);
    if (filtered !== this.inputTarget.value) this.inputTarget.value = filtered;
    this.#updateBoxes();
  }

  async paste(evt) {
    evt.preventDefault();
    try {
      const filtered = this.#filter(await navigator.clipboard.readText());
      this.inputTarget.value = filtered;
      this.#updateBoxes();
      this.inputTarget.focus();
    } catch (error) {
      console.error("Failed to read clipboard:", error);
    }
  }

  #filter(text) {
    return (text.match(this.regex) || [])
      .slice(0, this.boxTargets.length)
      .join("");
  }

  #updateBoxes() {
    const value = this.inputTarget.value;
    const currentIndex = Math.min(value.length, this.boxTargets.length);
    this.boxTargets.slice(0, currentIndex).forEach((box, i) => {
      box.textContent = value[i];
      box.classList.add(this.filledClass);
    });
    this.boxTargets.slice(currentIndex).forEach((box) => {
      box.textContent = "";
      box.classList.remove(this.filledClass);
    });
  }

  get regex() {
    return new RegExp(this.patternValue, "g");
  }
}
